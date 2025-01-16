package com.itwillbs.goodbuy.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.goodbuy.aop.LoginCheck;
import com.itwillbs.goodbuy.aop.LoginCheck.MemberRole;
import com.itwillbs.goodbuy.service.MemberService;
import com.itwillbs.goodbuy.service.OauthService;
import com.itwillbs.goodbuy.vo.MemberVO;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class OauthController {
	@Autowired
	private OauthService oauthService;
	
	@Autowired
	private MemberService memberService;
	//-----------------------------------------------------
	// [카카오 로그인 -> callback]
	// RedirectURI : http://localhost:8081/kakaologin 
	// RedirectURI : http://c3d2407t1p2.itwillbs.com//kakaologin
	// REST API 키 : 6a7a7bde7898c6d7f7c08a7a14bad8e9
	@RequestMapping("/kakaologin")
	public String kakaoAuth(@RequestParam(value = "code", required = false) String code, HttpSession session) throws Exception{
//		log.info(">>>>>>>>> 인가코드(code) : " + code);
		//XHyGGUGXppCApLCvVq8GvXLqYmbS7bv2Gm0t0quhhPcc0F9FvVhq6gAAAAQKKiVQAAABk-J2TydPBWDH3LuH7A
		
		// 1. 인가코드로 카카오 서버에 인가토큰(accessToken)을 요청
		// => POST로 요청, JSON형식으로 받음 => GSON 사용
		String accessToken = oauthService.getKakaoAccessToken(code);
//		log.info(">>>>>>>> 엑세스토큰(accessToken) : " + accessToken);
		//jx1VkMYt8wqyh3wQb0idjHPTvaaPeK76AAAAAQopyNgAAAGT4nZW6iHmgQBvj-MV
		
		// 2. 가져온 엑세스 토큰으로 사용자 정보 요청
		HashMap<String, Object> userInfo = oauthService.getUserInfo(accessToken);
		log.info(userInfo);
		log.info(">>>>>>> 아이디 : " + userInfo.get("id"));
		log.info(">>>>>>> 닉네임 : " + userInfo.get("nickname"));
		log.info(">>>>>>> 이메일 : " + userInfo.get("email"));
		log.info(">>>>>>> 프로필사진 : " + userInfo.get("profile_image"));
		
		// 3.카카오 서버에서 가져온 정보로 로그인 판별
		// => email로 기존에 등록된 회원 이메일 있는지 판별
		String mem_email = (String) userInfo.get("email");
		MemberVO member = memberService.getMemberEmail(mem_email); //=> 이메일 중복검사 코드 재사용
		log.info("중복검사: " + member);
		
		// 등록된 정보가 없는 경우 카카오 회원 정보 인서트 
		// => 인서트 후 다시 vo에 담아서 리턴
		if(member == null) {
			member = oauthService.setMemberInfo(userInfo);
			log.info(">>>>>>>> 인서트 후 MemberVO : "+ member);
		} 
		
		//세션에 저장
		session.setAttribute("sId", member.getMem_id());
		session.setAttribute("sNick", member.getMem_nick());
		session.setAttribute("sGrade", member.getMem_grade());
		session.setAttribute("sProfile", member.getMem_profile());
		session.setMaxInactiveInterval(60 * 120);
		
		if(member.getMem_passwd() == null) {
			return "member/sns_pw_regist";
		}
		
		//메인페이지로 이동
		return "index";
	}  
	
	// ===========================================================================================
	// [ 최초 1회 비밀번호 등록 => 회원수정/탈퇴를 위해]
	@LoginCheck(memberRole = MemberRole.USER)
	@PostMapping("PwRegist")
	public String pwRegist(String mem_passwd, HttpSession session, BCryptPasswordEncoder passwordEncoder,Model model) {
		String mem_id = (String)session.getAttribute("sId");
//		System.out.println("세션 아이디 : " + mem_id);
//		System.out.println("입력한 비번 : " + mem_passwd);
		
		// [ 비밀번호 암호화 ]
	    String securePasswd = passwordEncoder.encode(mem_passwd);
//		    System.out.println("암호화 비번 : " + securePasswd);
	    
	    // 암호화된 비번 등록
	    int updateCount = oauthService.registPasswd(mem_id, securePasswd);
	    
	    if (updateCount > 0) {
	    	model.addAttribute("msg", "비밀번호가 정상적으로 등록되었습니다.");
	    	model.addAttribute("targetURL", "./");
			return "result/success";
	    } else {
	    	model.addAttribute("msg", "비밀번호 등록 실패! \n다시 입력해 주세요");
	    	return "result/fail";
		}
	}
	
	
}
