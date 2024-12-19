package com.itwillbs.goodbuy.vo;

import java.sql.Date;
import org.springframework.web.multipart.MultipartFile;
import lombok.Data;

@Data
	public class MemberVO {
		private int memIdx;
		private String memId;
		private String memPasswd;
		private String memName;
		private String memNick;
		private String memBirthday;
		//-----------------
		private String memEmail;
		private String memEmail1;
		private String memEmail2;
		//-----------------
		private String memGender;
		private String memPhone;
		private String memPostCode;
		
		
		
		private String mem_address1;
		private String mem_address2;
		//-----------------
		private String mail_auth_status; // 이메일 인증상태 (Y:인증 N:미인증)
		private String mem_grade;
		//---------------------
		private String terms1;
		private String terms2;
		private String terms3;

		private int mem_status; //회원상태 (1:정상 2:대기 3:탈퇴)
		private Date mem_reg_date;
		private Date mem_withdraw_date;  
		private String mem_like1_class;
		private String mem_like2_class;
		private MultipartFile mem_pp_file; //강사 포트폴리오 파일
		private String file_pp; //강사 포트폴리오 이름
		private String profile_image; //기본값 null
		private String hashtag;
		
		

}
