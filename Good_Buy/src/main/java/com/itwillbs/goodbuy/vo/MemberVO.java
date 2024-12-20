package com.itwillbs.goodbuy.vo;

import java.sql.Date;
import org.springframework.web.multipart.MultipartFile;
import lombok.Data;

@Data
	public class MemberVO {
		private int memIdx;
		private String mem_id;
		private String mem_passwd;
		private String mem_name;
		private String mem_nick;
		private String mem_birthday;
		//--------------------------
		private String mem_email;
		private String mem_email1;
		private String mem_email2;
		//--------------------------
		private String mem_gender;
		private String mem_phone;
		//--------------------------
		private String memPostCode;
		private String memAddress1;
		private String memAddress2;
		//--------------------------
		private String memGrade;	//ENUM(일반/관리자)
		//--------------------------
		private int memStatus; 		//회원상태 (1:정상 2:정지 3:탈퇴)
		private Date memRegDate;
		private Date memWithdrawDate;  
		//--------------------------
		private String memProfile;	//프로필사진명
		private String memIntro;	//자기소개
		private int snsStatus;		//sns연동 여부(1: 연동O /2: 연동X)
		private int authStatus;		//인증여부(1: 인증O /2: 인증X)

}
