package com.itwillbs.goodbuy.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.goodbuy.service.OauthService;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class OauthController {
	@Autowired
	private OauthService oauthService;
	//-----------------------------------------------------
	// [카카오 로그인 -> callback]
	// RedirectURI : http://localhost:8081/kakaologin
	// REST API 키 : 6a7a7bde7898c6d7f7c08a7a14bad8e9
	@RequestMapping("/kakaologin")
	public String kakaoAuth(@RequestParam(value = "code", required = false) String code, Model model) throws Exception{
		log.info(">>>>>>>>> 인가코드(code) : " + code);
		//XHyGGUGXppCApLCvVq8GvXLqYmbS7bv2Gm0t0quhhPcc0F9FvVhq6gAAAAQKKiVQAAABk-J2TydPBWDH3LuH7A
		
		// 1. 인가코드로 카카오 서버에 인가토큰(accessToken)을 요청
		// => POST로 요청, JSON형식으로 받음 => GSON 사용
		String accessToken = oauthService.getKakaoAccessToken(code);
		log.info(">>>>>>>> 엑세스토큰(accessToken) : " + accessToken);
		//jx1VkMYt8wqyh3wQb0idjHPTvaaPeK76AAAAAQopyNgAAAGT4nZW6iHmgQBvj-MV
		
		// 2. 가져온 엑세스 토큰으로 사용자 정보 요청
		HashMap<String, Object> userInfo = oauthService.getUserInfo(accessToken);
		log.info(userInfo);
		log.info(">>>>>>> 닉네임 : " + userInfo.get("nickname"));
		log.info(">>>>>>> 이메일 : " + userInfo.get("email"));
		log.info(">>>>>>> 프로필사진 : " + userInfo.get("profile_image"));
		
		model.addAttribute("nickname", userInfo.get("nickname"));
//		model.addAttribute("msg", "카카오 로그인 성공! \n추가 정보 입력 페이지로 이동합니다.");
		//=> 생각해보니.. 로그인할때마다 추가 정보 입력은 말이 안됨
		
		// 로그인 성공시 회원 정보 DB에 저장
		// => email로 기존에 등록된 회원 이메일이 없을시 인서트
//		String memberEmail = oauthService.getMemberEmail(userInfo.get("email"));
//		if(memberEmail == null) {
//			oauthService.setMemberInfo(userInfo);
//		}
		
		
		//메인페이지로 이동
		return "index";
	}   
	
	
}
