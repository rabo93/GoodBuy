package com.itwillbs.goodbuy.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.goodbuy.aop.LoginCheck;
import com.itwillbs.goodbuy.aop.LoginCheck.MemberRole;
import com.itwillbs.goodbuy.handler.GenerateRandomCode;
import com.itwillbs.goodbuy.service.MailService;
import com.itwillbs.goodbuy.service.MemberService;
import com.itwillbs.goodbuy.service.OauthService;
import com.itwillbs.goodbuy.service.PayService;
import com.itwillbs.goodbuy.vo.MailAuthInfo;
import com.itwillbs.goodbuy.vo.MemberVO;
import com.itwillbs.goodbuy.vo.PayToken;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class MemberController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private MailService mailService;
	@Autowired
	private PayService payService;
	
	//-------------------------------------------------------
	//세션에 사용자 ID 저장 
	private String getSessionUserId(HttpSession session) {
	    return (String) session.getAttribute("sId");
	}
	
	//=================================================================================================================================
	// [ 로그인 페이지 구현 ]
	@GetMapping("SNSLogin")
	public String snsLoginForm() {
		return "member/sns_login";
	}
	
	@GetMapping("MemberLogin")
	public String memberLoginForm() {
		return "member/member_login";
	}
	
	@PostMapping("MemberLogin")
	public String login(MemberVO member, Model model, HttpSession session,
						BCryptPasswordEncoder passwordEncoder, 
						@RequestParam(value = "rememberId", required = false) String rememberId,
						@CookieValue(value="userId",required=false) String cookieId,
						HttpServletResponse response) {
		// 로그인 시 입력받은 ID를 우선 사용하고, 쿠키 ID는 선택적으로 사용
	    String mem_id = (member.getMem_id() != null && !member.getMem_id().isEmpty()) 
	                    ? member.getMem_id() 
	                    : cookieId;
		
		// 아이디 기억하기 체크박스 처리
		Cookie cookie = new Cookie("userId", member.getMem_id()); //쿠키설정
		if(rememberId != null) { //체크 시
			cookie.setMaxAge(60*60*24*1); // 쿠키 유효기간 1일
		} else {
			cookie.setMaxAge(0); // 쿠키 삭제
		}
		response.addCookie(cookie);
		
		// 로그인 처리
		MemberVO dbMember = memberService.getMember(mem_id);
		log.info("DB에 저장된 회원 정보 : " + dbMember);
		
		if(dbMember == null || !passwordEncoder.matches(member.getMem_passwd(), dbMember.getMem_passwd())) {		
			model.addAttribute("msg", "로그인 실패!\\n아이디와 패스워드를 다시 확인해주세요");
			return "result/fail";
		} else if(dbMember.getMem_status() == 3) { // 로그인 성공이지만, 탈퇴 회원일 경우
			model.addAttribute("msg", "탈퇴한 회원입니다!");
			return "result/fail";
		} else { //로그인 성공
			session.setAttribute("sId", dbMember.getMem_id());
			session.setAttribute("sNick", dbMember.getMem_nick());
			session.setAttribute("sGrade", dbMember.getMem_grade());
			session.setAttribute("sProfile", dbMember.getMem_profile());
//			session.setAttribute("sStore", dbMember.getMem_intro()); //상점소개
			session.setMaxInactiveInterval(60 * 120);
			
			// [ 핀테크 엑세스토큰 정보 조회하여 세션에 저장하는 기능 추가 ]
			PayToken token = payService.getPayTokenInfo(dbMember.getMem_id());
//			System.out.println("member 토큰 확인 : " + token);
			session.setAttribute("token", token);
			
			
			// 이전 페이지 저장 후 로그인 시 리다이렉트처리
			if(session.getAttribute("prevURL") == null) {
				return "redirect:/";
			} else {
				// request.getServletPath() 메서드를 통해 이전 요청 URL 을 저장할 경우
				// "/요청URL" 형식으로 저장되므로 redirect:/ 에서 / 제외하고 결합하여 사용
				return "redirect:" + session.getAttribute("prevURL");
			}
		}
		
	}	
	
	//=================================================================================================================================
	// [ 네이버 로그인 ]
	@GetMapping("NaverCallback")
	public String naverCallback() {
		return "member/naver_callback";
	}
	
	@ResponseBody
	@PostMapping("NaverLogin")
	public int naverLogin(MemberVO member, HttpSession session) {
		log.info(">>>>>>>>> 네이버 가입 계정 : " + member);
		
		String mem_email = (String)member.getMem_email();
		
		MemberVO dbMember = memberService.getMemberEmail(mem_email);
		
		log.info(">>>>>>>>>> 네이버 중복계정여부: " + dbMember);
		
		// 신규 회원 처리
	    if (dbMember == null) {
	        int result = memberService.registNaverMember(member);
	        log.info(">>>>> 신규 네이버 계정 등록 성공");

	        if (result != 1) {
	            log.error(">>>>> 네이버 계정 등록 실패");
	            return 0; // 등록 실패
	        }

	        setSessionAttributes(session, member); // 세션 설정
	        return 1; // 신규 회원 등록 성공
	    }

	    // 기존 회원 처리
	    setSessionAttributes(session, dbMember); // 세션 설정
	    log.info(">>>>> 네이버 중복 계정(기존 회원)");
	    return 2; // 기존 회원
	}
	
	// 세션 설정 메서드 
	public void setSessionAttributes(HttpSession session, MemberVO member) {
		session.setAttribute("sId", member.getMem_id());
		session.setAttribute("sNick", member.getMem_nick());
		session.setAttribute("sGrade", member.getMem_grade());
		session.setAttribute("sProfile", member.getMem_profile());
		session.setMaxInactiveInterval(60 * 120);
	}
	
	//=================================================================================================================================
	// [ 회원가입 페이지 구현 ]
	@GetMapping("MemberJoin")
	public String memberJoin() {
		return"member/member_join";
	}
	
	@PostMapping("MemberJoin")
	public String join(MemberVO member, HttpSession session, BCryptPasswordEncoder passwordEncoder, Model model) {
	    log.info("member : " + member);
	    //-----------------------------------------------------------------------
	    // [ 비밀번호 암호화 ]
	    String securePasswd = passwordEncoder.encode(member.getMem_passwd());
	    member.setMem_passwd(securePasswd);

	    //-----------------------------------------------------------------------
	    // [ 회원 가입 처리 ]
	    int insertCount = memberService.registMember(member);
	    if (insertCount > 0) {
	    	return "redirect:/MemberJoinSuccess";
	    } else {
	    	model.addAttribute("msg", "회원가입 실패\n항목을 다시 확인해주세요");
	    	return "result/fail";
	    }
	    
	}

	//=================================================================================================================================
	// [ 아이디/닉네임 중복체크 ]
	@ResponseBody
	@GetMapping("MemberCheckId")
	public String memberCheckId(String mem_id, MemberVO member) {
		System.out.println("mem_id : "+mem_id);
		
		member = memberService.getMember(mem_id);
		boolean isDuplicate = false;
		
		if(member != null) { //아이디 중복일 경우
			isDuplicate= true;
		}
		
		return isDuplicate+"";
	}
	
	@ResponseBody
	@GetMapping("MemberCheckNick")
	public String memberCheckNick(String mem_nick, MemberVO member) {
		System.out.println("mem_nick : "+mem_nick);
		member = memberService.getMemberNick(member);
		boolean isDuplicate = false;
		if(member != null) { //닉네임 중복
			isDuplicate= true;
		}
		return isDuplicate + "";
	}
	
	
	//=================================================================================================================================
	// [ 회원가입 성공 페이지로 이동 ]
	@GetMapping("MemberJoinSuccess")
	public String memberJoinSuccess() {
		return "member/member_join_success";
	}
	
	//=================================================================================================================================
	// [ 로그아웃 ]
	@GetMapping("MemberLogout")
	public String logout(HttpSession session) {
		session.invalidate(); // 세션 제거
		return "redirect:/";
	}
	//=================================================================================================================================
	// [ 아이디 찾기 ]
	@GetMapping("IDFind")
	public String inFind(String mem_phone) {
		return"member/id_finder";
	}
	
	@ResponseBody
	@PostMapping("MemberIdFind")
	public String memberIdFine(@RequestParam("mem_phone") String userPhone) {
		String mem_id = memberService.getMemberInfo(userPhone);
		System.out.println("아이디 : " + mem_id);
		
		return mem_id;
	}
	
	//-------------------------------------------------------------------------
	// [ 비밀번호 찾기 ]
	@GetMapping("PWFind")
	public String pwFind(String mem_phone) {
		return"member/pw_finder";
	}
	
	@ResponseBody
	@PostMapping("MemberPwFind")
	public Map<String, Object> memberPwFind(String mem_id, String mem_phone, Model model, BCryptPasswordEncoder passwordEncoder) {
		Map<String, Object> result = new HashMap<>();
		System.out.println("입력한 id : " + mem_id);
		
		// 본인인증한 휴대폰 번호로 회원 정보 조회
		MemberVO member = memberService.getMemInfo(mem_phone);
		if (member == null || !member.getMem_id().equals(mem_id)) {
	        result.put("success", false);
	        result.put("message", "입력한 정보로 조회된 계정이 없습니다.");
	        return result;
	    }
	    
	    // 임시 비밀번호 생성
		String temPasswd = GenerateRandomCode.getRandomCode(8);
        String heshePasswd = passwordEncoder.encode(temPasswd); //임시비밀번호 해싱처리
		System.out.println("임시비밀번호 : " + heshePasswd);
		
		// 새 임시 비밀번호로 db 업데이트
        int updateCount = memberService.setTempPasswd(heshePasswd, mem_id);
		
        if (updateCount > 0) {
	        // 메일 전송
	        MailAuthInfo mailAuthInfo = mailService.sendPasswdMail(member, temPasswd);
        	System.out.println("인증정보 : " + mailAuthInfo);
//        	memberService.registMemberAuthInfo(mailAuthInfo);
        	result.put("success", true);
        	result.put("message", "임시 비밀번호가 발송되었습니다.");
	        
	    } else {
	        result.put("success", false);
	        result.put("message", "비밀번호 변경에 실패했습니다. 다시 시도해주세요.");
	    }
		return result;
	}
	
	//=================================================================================================================================
	// [ 회원정보 수정 ]
	@LoginCheck(memberRole = MemberRole.USER)
	@GetMapping("MyInfo")
	public String memberModify(MemberVO member, HttpSession session, Model model) {
		String mem_id = (String)session.getAttribute("sId");
//		log.info(">>>>>>>>>>>>> 수정페이지 아이디 : " + mem_id);
		
		// 세션아이디로 회원 정보 가져와서 MemberVO에 담기
		member = memberService.getMember(mem_id);
		// 뷰페이지에 MemberVO 정보 전달
		model.addAttribute("member", member);
		
		return "mypage/mypage_info";
	}
	
	@LoginCheck(memberRole = MemberRole.USER)
	@PostMapping("MyInfoModify")
	public String memberModifyForm(MemberVO member, BCryptPasswordEncoder passwordEncoder 
			, @RequestParam Map<String, String> map
			, @RequestParam("profile_upload") MultipartFile profileUpload
			, HttpSession session, Model model ) {
//		System.out.println("MAP : "+map);
		System.out.println("member : "+member);
		// MAP : {mem_address1=서울 강동구 아리수로 46, mem_id=bborara, mem_passwd=1234, mem_nick=라보, mem_phone=01074511274, mem_address2=1403, mem_passwd2=1234, mem_email=bborara93@gmail.com, old_passwd=1234, mem_post_code=05237}
		// member : MemberVO(mem_idx=0, mem_id=bborara, mem_passwd=1234, mem_name=null, mem_nick=라보, mem_birthday=null, mem_email=bborara93@gmail.com, mem_email1=null, mem_email2=null, mem_gender=null, mem_phone=01074511274, mem_post_code=05237, mem_address1=서울 강동구 아리수로 46, mem_address2=1403, mem_grade=null, mem_status=0, mem_reg_date=null, mem_withdraw_date=null, mem_profile=null, mem_intro=null, sns_status=0, auth_status=0)
		
		String id = (String)session.getAttribute("sId");
		map.put("id", id);
		
		// id로 회원 정보 조회하여 기존 패스워드 가져오기
		String dbpasswd = memberService.getMemberPasswd(id);
		// 기존 비밀번호와 입력한 비밀번호 비교 검증 
		if(dbpasswd == null || !passwordEncoder.matches(map.get("old_passwd"),dbpasswd)) {
			model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
			return "result/fail";
		}
		// 변경할 비밀번호 셋팅
		if(!map.get("mem_passwd").equals("")) {
			map.put("mem_passwd",passwordEncoder.encode(map.get("mem_passwd")));//암호화된 새로운 비밀번호
		}
		
		
		// 프로필 사진 파일 업로드 처리
		if (!profileUpload.isEmpty()) {
			try {
		        String uploadDir = session.getServletContext().getRealPath("/resources/uploads/");
		        System.out.println("파일 저장 경로 : " + uploadDir);
		        
		        File uploadDirectory = new File(uploadDir);
		       
		        if (!uploadDirectory.exists()) {
		            uploadDirectory.mkdirs(); // 디렉토리가 없으면 생성
		        }
		        
		        // 파일 이름 생성
		        String fileName = id + "_profile_" + profileUpload.getOriginalFilename();
		        File destinationFile = new File(uploadDir, fileName);
	            profileUpload.transferTo(destinationFile); // 파일 저장
	            
	            map.put("mem_profile", "/resources/uploads/" + fileName); // 파일 경로를 map에 추가
	            
//	            session.setAttribute("sProfile", member.getMem_profile());
			} catch (IOException e) {
	            e.printStackTrace();
	            model.addAttribute("msg", "파일 업로드 중 오류가 발생했습니다.");
	            return "result/fail";
	        }
	        
	    }
		
		// 변경된 회원 정보 수정
		int updateCount = memberService.modifyMember(map);
		System.out.println("업데이트한 갯수 : " + updateCount);
		
		if(updateCount > 0) {
			// 수정 후, 세션에 최신 프로필 사진 경로를 업데이트
			session.setAttribute("sProfile", member.getMem_profile());
			
			model.addAttribute("msg", "회원정보 수정 성공!");
			return"result/success";
		} else {
			model.addAttribute("msg", "회원정보 수정 실패!\\n다시 확인해주세요 ");
			return"result/fail";
		}
		
		
	}
	
	
	// ===========================================================================================
	// [ 회원탈퇴 ]
	@LoginCheck(memberRole = MemberRole.USER)
	@GetMapping("MemberWithdraw")
	public String memberWithdraw() {
		return "mypage/mypage_withdraw";
	}
	
	@LoginCheck(memberRole = MemberRole.USER)
	@PostMapping("MemberWithdrawForm")
	public String memberWithdrawForm (String memPasswd, BCryptPasswordEncoder passwordEncoder, HttpSession session, Model model) {
		String id = getSessionUserId(session);
		
		// 해당 아이디로 DB에 비밀번호 조회
		String dbPasswd = memberService.getMemberPasswd(id);
		
		// DB비밀번호와 입력한 비밀번호가 같은지 검증
		if(dbPasswd == null || !passwordEncoder.matches(memPasswd, dbPasswd)) {
			model.addAttribute("msg", "권한이 없습니다./n비밀번호를 다시 확인해주세요.");
			return "result/fail";
		}
		
		// 비밀번호가 맞으면 해당 아이디 계정 삭제 처리
		memberService.removeMemInfo(id, 3); //3:탈퇴
		session.invalidate();
		
		model.addAttribute("msg", "탈퇴 처리가 완료되었습니다.");
		model.addAttribute("targetURL", "./");
		
		return "result/success";
	}
	
	


}
