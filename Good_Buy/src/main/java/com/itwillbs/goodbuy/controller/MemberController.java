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
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
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
import com.itwillbs.goodbuy.handler.RsaKeyGenerator;
import com.itwillbs.goodbuy.service.MailService;
import com.itwillbs.goodbuy.service.MemberService;
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
	//-------------------------------------------------------
	// 첨부파일 가상경로
	private String uploadPath = "/resources/upload";
		
	//=================================================================================================================================
	// [ 로그인 페이지 구현 ]
	@GetMapping("SNSLogin")
	public String snsLoginForm() {
		return "member/sns_login";
	}
	
	// 로그인 폼 요청 시 공개키 전송하는 기능 추가
	@GetMapping("MemberLogin")
	public String memberLoginForm(HttpSession session, Model model) {
		// RSA 알고리즘을 사용항 공개키/개인키 생성
		Map<String, String> rsaKey = RsaKeyGenerator.generateKey();
//		System.out.println("공개키 : " + rsaKey.get("publicKey"));
//		System.out.println("개인키 : " + rsaKey.get("privateKey"));
		
		// 개인키/공개키 셋은 세션에 저장해 두고(현재 실제로는 개인키만 저장해도 무관함)
		// 공개키는 클라이언트측에 전송할 수 있도록 Model 객체에 추가
		session.setAttribute("rsaKey", rsaKey);
		model.addAttribute("publicKey", rsaKey.get("publicKey"));
		
		return "member/member_login";
	}
	
	@PostMapping("MemberLogin")
	public String login(MemberVO member, Model model, HttpSession session,
						BCryptPasswordEncoder passwordEncoder,
						String encryptedData, // 아이디&패스워드를 JSON 으로 묶어서 암호화했을 경우
						@RequestParam(value = "rememberId", required = false) String rememberId,
						@CookieValue(value="userId",required=false) String cookieId,
						HttpServletResponse response) {
		// 로그인 시 입력받은 ID를 우선 사용하고, 쿠키 ID는 선택적으로 사용
	    String mem_id = (member.getMem_id() != null && !member.getMem_id().isEmpty()) 
	                    ? member.getMem_id() 
	                    : cookieId;
	    
	    //------------------------------------------------------------------
		// [ 암호화 된 데이터 복호화 ] *2025/01/08 추가됨*
		Map<String, String> rsaKey = (Map<String, String>) session.getAttribute("rsaKey");
		System.out.println("rsaKey: " + rsaKey);
		
		// RsaKeyGenerator.decrypt() 메서드 호출하여 복호화 후 결과값 리턴받기
		// => 파라미터 : 개인키, 암호문   리턴타입 : String
		//------------------------------
		// id 와 passwd 값을 JSON 으로 묶어서 전송했을 경우
		String decryptedData = RsaKeyGenerator.decrypt(rsaKey.get("privateKey"), encryptedData);
		System.out.println("복호화 된 데이터 : " + decryptedData); 
		
		// JSONObject 또는 Gson 의 JsonObject 등을 활용하여 파싱을 통해 id 와 passwd 추출
		JSONObject jo = new JSONObject(decryptedData); // JSON 문자열 파싱
		// 파싱된 각각의 아이디와 패스워드를 MemberVO 객체에 저장
		member.setMem_id(jo.getString("id"));
		member.setMem_passwd(jo.getString("passwd"));
		
		//------------------------------------------------------------------
		// [ 로그인 처리 ]
		// memberVO 파라미터로 회원 정보 조회
		MemberVO dbMember = memberService.getMemberLogin(member);
//		MemberVO dbMember = memberService.getMember(mem_id);
		log.info(">>>>>DB에 저장된 회원 정보 : " + dbMember);
		
		String failURL = "result/fail";
		
		if(dbMember == null || !passwordEncoder.matches(member.getMem_passwd(), dbMember.getMem_passwd())) {		
			model.addAttribute("msg", "로그인 실패!\\n아이디와 패스워드를 다시 확인해주세요");
			return failURL;
		} else if(dbMember.getMem_status() == 2) { // 로그인 성공이지만, 정지 회원일 경우
			model.addAttribute("msg", "신고 누적 3번으로 인해 계정이 정지되었습니다.\\n관리자에게 문의하세요.");
			return failURL;
		} else if(dbMember.getMem_status() == 3) { // 로그인 성공이지만, 탈퇴 회원일 경우
			model.addAttribute("msg", "탈퇴한 회원입니다!\\n다시 회원가입 해주세요. ");
			return failURL;
		} 
		
		// !!!!!!!!!!!!!!!!!!!로그인 성공!!!!!!!!!!!!!!!!!!!
		session.setAttribute("sId", dbMember.getMem_id());
		session.setAttribute("sNick", dbMember.getMem_nick());
		session.setAttribute("sGrade", dbMember.getMem_grade());
		session.setAttribute("sProfile", dbMember.getMem_profile());
		session.setMaxInactiveInterval(60 * 120); // 세션 타이머 설정: 2시간
		
		//--------------------------------------------------------------
		// [ 핀테크 엑세스토큰 정보 조회하여 세션에 저장하는 기능 추가 ]
		PayToken token = payService.getPayTokenInfo(dbMember.getMem_id());
//					System.out.println("member 토큰 확인 : " + token);
		session.setAttribute("token", token);
		//--------------------------------------------------------------
		// [ 쿠키 설정 ]
		// 아이디 기억하기 체크박스 처리
		Cookie cookie = new Cookie("userId", member.getMem_id()); //쿠키설정
		if(rememberId != null) { //체크 시
			cookie.setMaxAge(60*60*24*1); // 쿠키 유효기간 1일
		} else {
			cookie.setMaxAge(0); // 쿠키 삭제
		}
		response.addCookie(cookie);
		
		// [ 특정 페이지 로그인 필수 처리를 위한 로그인 완료 시 원래 페이지로 이동 처리 ]
		String prevURL = (String) session.getAttribute("prevURL");
		String redir = "redirect:";
		return ( prevURL == null ) ? redir + "/" : redir + prevURL;
	}	
	
	//=================================================================================================================================
	// [ 회원가입 ]
	@GetMapping("MemberJoin")
	public String memberJoin() {
		return"member/member_join";
	}
	
	@PostMapping("MemberJoin")
	public String join(MemberVO member, HttpSession session, BCryptPasswordEncoder passwordEncoder, Model model) {
	    // [ 휴대폰 인증완료 상태 설정 ]
	    member.setAuth_status(1);
	    
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
	// [ 아이디/닉네임/이메일 중복체크 ]
	@ResponseBody
	@GetMapping("MemberCheckId")
	public String memberCheckId(String mem_id, MemberVO member) {
		member = memberService.getMember(mem_id);
		
		boolean isDuplicate = false;
		if(member != null) { //아이디 중복일 경우
			isDuplicate= true;
		}
		return isDuplicate+"";
	}
	
	@ResponseBody
	@PostMapping("MemberCheckPhone")
	public String memberCheckPhone(String mem_phone, MemberVO member) {
		member = memberService.getMemInfo(mem_phone);
		boolean isDuplicate = false;
		if(member != null) { //중복
			isDuplicate= true;
		}
		return isDuplicate + "";
	}
	@ResponseBody
	@GetMapping("MemberCheckNick")
	public String memberCheckNick(String mem_nick, MemberVO member) {
		member = memberService.getMemberNick(member);
		
		boolean isDuplicate = false;
		if(member != null) { //닉네임 중복
			isDuplicate= true;
		}
		return isDuplicate + "";
	}
	
	@ResponseBody
	@PostMapping("MemberCheckEmail")
	public String memberCheckEmail(String mem_email, MemberVO member) {
		member = memberService.getMemberEmail(mem_email);
		
		boolean isDuplicate = false;
		if(member != null) { //이메일 중복
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
	// [ 휴대폰 번호로 아이디 찾기 ]
	@GetMapping("IDFind")
	public String inFind(String mem_phone) {
		return"member/id_finder";
	}
	
	@ResponseBody
	@PostMapping("MemberIdFind")
	public String memberIdFine(@RequestParam("mem_phone") String userPhone) {
		String mem_id = memberService.getMemberInfo(userPhone);
		
		return mem_id;
	}
	
	//-------------------------------------------------------------------------
	// [ 휴대폰 번호로 비밀번호 찾기 ]
	@GetMapping("PWFind")
	public String pwFind(String mem_phone) {
		return"member/pw_finder";
	}
	
	@ResponseBody
	@PostMapping("MemberPwFind")
	public Map<String, Object> memberPwFind(String mem_id, String mem_phone, Model model, BCryptPasswordEncoder passwordEncoder) {
		Map<String, Object> result = new HashMap<>();
//		System.out.println("입력한 id : " + mem_id);
		
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
//		System.out.println("임시비밀번호 : " + heshePasswd);
		
		// 새 임시 비밀번호로 db 업데이트
        int updateCount = memberService.setTempPasswd(heshePasswd, mem_id);
		
        if (updateCount > 0) {
	        // 메일 전송
	        MailAuthInfo mailAuthInfo = mailService.sendPasswdMail(member, temPasswd);
//        	System.out.println("인증정보 : " + mailAuthInfo);
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
	public String memberModifyForm( MemberVO member
									, BCryptPasswordEncoder passwordEncoder 
									, @RequestParam Map<String, String> map
									, @RequestParam("profile_upload") MultipartFile mem_profile_get
									, HttpSession session
									, Model model ) {
		String mem_id = (String)session.getAttribute("sId");
		map.put("mem_id", mem_id);
		map.put("mem_nick", member.getMem_nick());
		//-------------------------------------------------
		// [비밀번호 검증]
		// id로 회원 정보 조회하여 기존 패스워드 가져오기
		member = memberService.getMember(mem_id);
		String dbPasswd = member.getMem_passwd();
		// 기존 비밀번호와 입력한 비밀번호 비교 검증 
		if(dbPasswd == null || !passwordEncoder.matches(map.get("old_passwd"), dbPasswd)) {
			model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
			return "result/fail";
		}
		// 변경할 비밀번호 셋팅
		if(!map.get("mem_passwd").equals("")) {
			map.put("mem_passwd",passwordEncoder.encode(map.get("mem_passwd")));//암호화된 새로운 비밀번호
		}
		//-------------------------------------------------
		// 실제 경로 (/resources/upload)
		String realPath = getRealPath(session);
		// 서브 디렉토리 생성 (/연도/월/일)
		String subDir = createDirectories(realPath);
		realPath += "/" + subDir;
		log.info(">>>>realPath/subDir: " + realPath);
		
		// 첨부파일 업로드
		member.setMem_profile_get(mem_profile_get);
		
		String fileName = addFileProcess(member, realPath, subDir);
		member.setMem_profile(fileName);
		
		map.put("mem_profile", fileName);
		
		// ============변경된 회원 정보 수정============
		int updateCount = memberService.modifyMember(map);
		
		if(updateCount > 0) {
			// 수정 후, 뷰페이지에 뿌릴 세션 및 모델에 프로필경로명 저장
			session.setAttribute("sProfile", member.getMem_profile());
			model.addAttribute("member", member);
			model.addAttribute("msg", "회원정보 수정 성공!");
			model.addAttribute("targetURL", "MyInfo");
			return"result/success";
		} else {
			model.addAttribute("msg", "회원정보 수정 실패!\\n다시 확인해주세요 ");
			return"result/fail";
		}
		
		
	}
	
//	============================================================================
	//	실제 업로드 경로 메서드
	public String getRealPath(HttpSession session) {
		String realPath = session.getServletContext().getRealPath(uploadPath);
		System.out.println("실제realPath: " + realPath);
		return realPath;
	}
	
	//	서브디렉토리 생성
	public String createDirectories(String realPath) {
		//	현재 시스템 날짜
		LocalDate today = LocalDate.now();
		//	날짜 포맷 패턴
		String datePattern = "yyyy/MM/dd";
		//	패턴 문자열 전달
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern(datePattern);
		
		//	날짜 형식으로 경로 저장
		String subDir = today.format(dtf);
		//	기존 실제 업로드 경로
		realPath += "/" + subDir;
		//	실제 경로 전달
		Path path = Paths.get(realPath);
		
		try {
			//	실제 경로 생성
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return subDir;
	}
	
	//	파일 업로드
	public String addFileProcess(MemberVO member, String realPath, String subDir) {
		MultipartFile multi = member.getMem_profile_get(); 
//		System.out.println("multi:" + multi);
		
		if (multi == null || multi.isEmpty()) {
	        return ""; // 파일이 없을 경우 빈 문자열 반환
	    }
		
		try {
			// 랜덤 파일명 생성
	        String temp = UUID.randomUUID().toString().substring(0, 8) + "_" + multi.getOriginalFilename();
	        // 디렉토리 경로 조합 및 파일 저장
	        String savePath = realPath + File.separator + temp;
	        multi.transferTo(new File(savePath));

	        // 반환할 파일 경로
	        String fileName = "/resources/upload/" + subDir + "/" + temp;
//	        System.out.println("fileName: " + fileName); // 최종 경로 로그 확인
	        return fileName;
	        
	    } catch (IOException e) {
	        log.error("파일 업로드 중 오류 발생: ", e);
	        throw new RuntimeException("파일 업로드 실패", e); // 예외를 호출자에게 전달
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
		
		// 해당 아이디로 DB에 회원정보 조회
		MemberVO member = memberService.getMember(id);
		String dbPasswd = member.getMem_passwd();
		
		// DB비밀번호와 입력한 비밀번호가 같은지 검증
		if(dbPasswd == null || !passwordEncoder.matches(memPasswd, dbPasswd)) {
			model.addAttribute("msg", "권한이 없습니다.\\n비밀번호를 다시 확인해주세요.");
			return "result/fail";
		}
		
		// 탈퇴할 아이디가 카카오/네이버 아이디이면 삭제 처리
		if (member.getSns_status() == 1) {
			memberService.removeSnsInfo(id);
		} else {
			// 일반 계정이면 탈퇴(3) 처리
			memberService.removeMemInfo(id, 3);
		}
		
		// 회원 탈퇴 성공 시 첨부파일 제거 작업
		String realPath = getRealPath(session);
		Path path = Paths.get(realPath, member.getMem_profile());
		try {
			Files.delete(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// 세션 제거
		session.invalidate();
		
		model.addAttribute("msg", "탈퇴 처리가 완료되었습니다.");
		model.addAttribute("targetURL", "./");
		
		return "result/success";
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
		


}
