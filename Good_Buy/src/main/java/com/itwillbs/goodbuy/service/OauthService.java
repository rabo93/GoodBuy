package com.itwillbs.goodbuy.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.itwillbs.goodbuy.mapper.MemberMapper;
import com.itwillbs.goodbuy.vo.MemberVO;

import lombok.extern.log4j.Log4j2;
@Log4j2
@Service
public class OauthService {
	@Autowired
	private MemberMapper memberMapper;
	
	//-------------------------------------------------------------------
	// [카카오 로그인 연동]
	// 1. 인가코드로 엑세스토큰 발급 요청
	public String getKakaoAccessToken(String code) {
		String accessToken = "";
	    String refreshToken = "";
	    String reqURL = "https://kauth.kakao.com/oauth/token";
	    
	    try {
	        // 1) connection 생성
	    	URL url = new URL(reqURL);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        
	        // POST 요청을 위해 기본값이 false인 setDoOutput을 true로 변경
	        conn.setRequestMethod("POST");
	        conn.setDoOutput(true);
	        
	        // 2) POST로 보낼 Body 작성
	        // POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
	        // BufferedWriter 간단하게 파일을 끊어서 보내기로 토큰값을 받아오기위해 전송
	        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
	        StringBuilder sb = new StringBuilder();
	        sb.append("grant_type=authorization_code");
	        sb.append("&client_id=6a7a7bde7898c6d7f7c08a7a14bad8e9");  		//REST_API_KEY 입력
	        sb.append("&redirect_uri=http://c3d2407t1p2.itwillbs.com/kakaologin");   //설정해 놓은 redirect_uri 주소
//	        sb.append("&redirect_uri=http://localhost:8081/kakaologin");   //설정해 놓은 redirect_uri 주소
	        sb.append("&code=" + code);
	        bw.write(sb.toString());
	        bw.flush();
	        
	        // 결과 코드가 200이라면 성공
	        // 여기서 안되는경우가 많이 있어서 필수 확인 !! **
	        int responseCode = conn.getResponseCode();
//	        log.info(">>>>> responseCode(200이면 정상) : " + responseCode);

	        // 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
	        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        String line = "";
	        String result = "";

	        while ((line = br.readLine()) != null) {
	            result += line;
	        }
//	        log.info(">>>>>>>> response body : " + result);
	        /* response body : 
				{
					"access_token":"jx1VkMYt8wqyh3wQb0idjHPTvaaPeK76AAAAAQopyNgAAAGT4nZW6iHmgQBvj-MV",
					"token_type":"bearer",
					"refresh_token":"xhxMCFz5ohmmbhcbO1O38HnXX2sn5OR9AAAAAgopyNgAAAGT4nZW5yHmgQBvj-MV",
					"id_token":"eyJraWQiOiI5ZjI1MmRhZGQ1ZjIzM2Y5M2QyZmE1MjhkMTJmZWEiLCJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI2YTdhN2JkZTc4OThjNmQ3ZjdjMDhhN2ExNGJhZDhlOSIsInN1YiI6IjM4NDI2MTAyOTciLCJhdXRoX3RpbWUiOjE3MzQ2NzEyMjYsImlzcyI6Imh0dHBzOi8va2F1dGgua2FrYW8uY29tIiwibmlja25hbWUiOiLquYDrs7TrnbwiLCJleHAiOjE3MzQ2OTI4MjYsImlhdCI6MTczNDY3MTIyNiwicGljdHVyZSI6Imh0dHBzOi8vaW1nMS5rYWthb2Nkbi5uZXQvdGh1bWIvUjExMHgxMTAucTcwLz9mbmFtZT1odHRwczovL3QxLmtha2FvY2RuLm5ldC9hY2NvdW50X2ltYWdlcy9kZWZhdWx0X3Byb2ZpbGUuanBlZyIsImVtYWlsIjoicmFibzkzQGtha2FvLmNvbSJ9.TbCUWuOgF4A6d0al6-S_ygyJyoOwGDshrPxniykdveQttqu7ADUMLAdAWuRtsanFBSdUvouPT9i59HZseeiCSRVy90B6mO0biFRqu3bLpJ8REFaaMunPTYc7g9KouW8A5O_OKFJsuutCMJUFX3-9OOZejvyJBpOV8KjB9kEnJiKtSABJZcQvRNpSZxD6wRzqvLxdxGh8hU7jhAv2KQafVqqzbgs-ZcbWnERaSFX_F9U1UJcmtfvOQEa5r6Z_ko5XjY4wXfjKhqXkSQdNFSAZwJ63ucmguPBsJ_V_PzHaa-6fb7siEFIByvab2UsV3UO2kpXz-4h0JEYZhbc80g7lxg",
					"expires_in":21599,
					"scope":"account_email profile_image profile_nickname",
					"refresh_token_expires_in":5183999
				} 
	         * */
	        
	        // 3) 받아온 결과 JSON 파싱(GSON)
	        // Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
	        JsonParser parser = new JsonParser();
	        JsonElement element = parser.parse(result);

	        accessToken = element.getAsJsonObject().get("access_token").getAsString();
	        refreshToken = element.getAsJsonObject().get("refresh_token").getAsString();
//	        log.info(">>>>>>>>> access_token : " + accessToken);
//	        log.info(">>>>>>>>> refresh_token : " + refreshToken);

	        br.close();
	        bw.close();
	        
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	    
	    return accessToken;
	}

	//--------------------------------------------------------------------------------------
	// 2. 엑세스토큰으로 사용자 정보 요청
	public HashMap<String, Object> getUserInfo(String access_token) {
		//요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
        HashMap<String, Object> userInfo = new HashMap<>();
        String reqURL = "https://kapi.kakao.com/v2/user/me";
        
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            //요청에 필요한 Header에 포함될 내용
            conn.setRequestProperty("Authorization", "Bearer " + access_token);

            int responseCode = conn.getResponseCode();
//            log.info(">>>>>> responseCode(200이면 정상) : " + responseCode);

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
//            log.info(">>>>>> response body : " + result);
            /* response body : 
				 {
					"id":3842610297,
					"connected_at":"2024-12-20T05:00:31Z",
					"properties":{
						"nickname":"김보라",
						"profile_image":"http://img1.kakaocdn.net/thumb/R640x640.q70/?fname=http://t1.kakaocdn.net/account_images/default_profile.jpeg",
						"thumbnail_image":"http://img1.kakaocdn.net/thumb/R110x110.q70/?fname=http://t1.kakaocdn.net/account_images/default_profile.jpeg"
					},
					"kakao_account":
						{
							"profile_nickname_needs_agreement":false,
							"profile_image_needs_agreement":false,
							"profile":{
								"nickname":"김보라",
								"thumbnail_image_url":"http://img1.kakaocdn.net/thumb/R110x110.q70/?fname=http://t1.kakaocdn.net/account_images/default_profile.jpeg",
								"profile_image_url":"http://img1.kakaocdn.net/thumb/R640x640.q70/?fname=http://t1.kakaocdn.net/account_images/default_profile.jpeg",
								"is_default_image":true,
								"is_default_nickname":false
							},
							"has_email":true,
							"email_needs_agreement":false,
							"is_email_valid":true,
							"is_email_verified":true,
							"email":"rabo93@kakao.com"
						}
				}
             * */
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
            JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
            
            // 카카오에서 응답받은 id값을 임의의 id값으로 변환하여 저장
            String id = "kakao@" + element.getAsJsonObject().get("id").getAsString();
            String nickname = properties.getAsJsonObject().get("nickname").getAsString();
            String profile_image = properties.getAsJsonObject().get("profile_image").getAsString();
            String email = kakao_account.getAsJsonObject().get("email").getAsString();
            
            userInfo.put("id", id);
            userInfo.put("nickname", nickname);
            userInfo.put("email", email);
            userInfo.put("profile_image", profile_image);

        } catch (IOException e) {
            e.printStackTrace();
        }
        
        return userInfo;
		
	}
	
	//--------------------------------------------------------------------------------------
	// 3. 카카오 회원 정보 삽입
	public MemberVO setMemberInfo(HashMap<String, Object> userInfo) {
	    memberMapper.insertMemberInfo(userInfo);
	    return memberMapper.getMemberById((String) userInfo.get("id"));
	}
	//--------------------------------------------------------------------------------------
	// 암호화된 비번 등록
	public int registPasswd(String mem_id, String securePasswd) {
		return memberMapper.updatePasswd(mem_id, securePasswd);
	}

	

}
