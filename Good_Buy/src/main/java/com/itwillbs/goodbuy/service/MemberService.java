package com.itwillbs.goodbuy.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.itwillbs.goodbuy.mapper.MemberMapper;
import com.itwillbs.goodbuy.vo.MailAuthInfo;
import com.itwillbs.goodbuy.vo.MemberVO;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
public class MemberService {
	@Autowired
	private MemberMapper mapper;

	public int registMember(MemberVO member) {
		return mapper.insertMember(member);
	}


	public void registMemberAuthInfo(MailAuthInfo mailauthInfo) {
		MailAuthInfo dbMailAuthInfo = mapper.selectMailAuthInfo(mailauthInfo);
		if (dbMailAuthInfo == null) {
			mapper.insertMailAuthInfo(mailauthInfo);
		} else {
			mapper.updateMailAuthInfo(mailauthInfo);
		}

	}

	public boolean requestEmailAuth(MailAuthInfo mailAuthInfo) {
		boolean isAuthsuccess = false;


		MailAuthInfo dbMailAuthInfo = mapper.selectMailAuthInfo(mailAuthInfo);
		System.out.println("조회된 인증 정보" + dbMailAuthInfo);

		// 인증정보 조회결과 판별
		if (dbMailAuthInfo != null) {
			if (mailAuthInfo.getAuth_code().equals(dbMailAuthInfo.getAuth_code())) { // 인증코드가 일치
				mapper.updateMailAuthStatus(mailAuthInfo); //인증상태 업데이트
				mapper.deleteMailAuthInfo(mailAuthInfo);

				isAuthsuccess = true;
			}
		}

		return isAuthsuccess;
	}

	public String getMemberPasswd(String id) {
		return mapper.selectMemberPasswd(id);
	}


	public MemberVO getMember(MemberVO member) {
		return mapper.selectMember(member);
		
	}
	
	public MemberVO getMemberNick(MemberVO member) {
		return mapper.selectMemberNick(member);
		
	}

	public MemberVO getMemberMail(MemberVO member) {
		return mapper.selectEmailId(member);
	}


	public int modifyMember(Map<String, String> map) {
		System.out.println("@@@mem_passwd: " + map.get("mem_passwd"));
		System.out.println("@@@mem_name: " + map.get("mem_name"));

		return mapper.updateMember(map);
	}

	
	public MemberVO getMemberEmail(String mem_email) {
		return mapper.selectEmail(mem_email);
	}

	//회원상태 탈퇴 요청
	public int withdrawMember(String id) {
		return mapper.updateMemberStatus(id,3); //3 : 탈퇴
	}

	//비밀번호 찾기로 비밀번호 업데이트
	public int setTempPasswd(String heshePasswd, String mem_email) {
		return mapper.updateTempPasswd(heshePasswd,mem_email);
	}
	
	//-------------------------------------------------------------------
	// [SNS 로그인 연동]
	// 1. 카카오 로그인
	public String getAccessToken(String authorize_code) {
		String access_Token = "";
	    String refresh_Token = "";
	    String reqURL = "https://kauth.kakao.com/oauth/token";
	    
	    try {
	        URL url = new URL(reqURL);

	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

	        // POST 요청을 위해 기본값이 false인 setDoOutput을 true로 변경
	        conn.setRequestMethod("POST");
	        conn.setDoOutput(true);
	        
	        // POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
	        // BufferedWriter 간단하게 파일을 끊어서 보내기로 토큰값을 받아오기위해 전송
	        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
	        StringBuilder sb = new StringBuilder();
	        sb.append("grant_type=authorization_code");
	        sb.append("&client_id=6a7a7bde7898c6d7f7c08a7a14bad8e9");  		//발급받은 key
	        sb.append("&redirect_uri=http://localhost:8080/KakaoAuth");    // 본인이 설정해 놓은 redirect_uri 주소
	        sb.append("&code=" + authorize_code);
	        bw.write(sb.toString());
	        bw.flush();

	        // 결과 코드가 200이라면 성공
	        // 여기서 안되는경우가 많이 있어서 필수 확인 !! **
	        int responseCode = conn.getResponseCode();
	        log.info(">>>>> responseCode : " + responseCode + "확인");

	        // 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
	        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        String line = "";
	        String result = "";

	        while ((line = br.readLine()) != null) {
	            result += line;
	        }
	        log.info("response body : " + result + "결과");

	        // Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
	        JsonParser parser = new JsonParser();
	        JsonElement element = parser.parse(result);

	        access_Token = element.getAsJsonObject().get("access_token").getAsString();
	        refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
	        
	        log.info("access_token : " + access_Token);
	        log.info("refresh_token : " + refresh_Token);

	        br.close();
	        bw.close();
	        
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	    
	    return access_Token;
	}
	
	// access_Token으로 사용자 정보 요청
//	public String getuserinfo(String access_Token, HttpSession session, RedirectAttributes rttr) {
//		return null;
//	}





}
