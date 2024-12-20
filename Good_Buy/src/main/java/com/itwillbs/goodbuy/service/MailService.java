package com.itwillbs.goodbuy.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.goodbuy.handler.GenerateRandomCode;
import com.itwillbs.goodbuy.handler.SendMailClient;
import com.itwillbs.goodbuy.vo.MailAuthInfo;
import com.itwillbs.goodbuy.vo.MemberVO;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
public class MailService {
	@Autowired
	private SendMailClient sendMailClient;
	
	@Autowired
	private MemberService memberService;

	public MailAuthInfo sendAuthMail(MemberVO member, String email1 , String email2) {
		System.out.println("memberService : " + member);
		String fullEmail = member.getMem_email();
		log.info(">>>>>>>>>> 가입메일: " + member.getMem_email());
		
		String email = email1 + '@' +  email2;
		String auth_code = GenerateRandomCode.getRandomCode(50);
		
		String subject = "[굿바이]가입 인증코드 입니다.";
		// 주소 수정해야함!!
		String content = "<a href=\"http://localhost:8081/MemberEmailAuth?mem_email="+ email + "&auth_code=" + auth_code +"\">[클릭]이메일 인증하기</a>";
		// String content = "<a href=\"http://c3d2407t1p1.itwillbs.com/MemberEmailAuth?mem_email="+ email + "&auth_code=" + auth_code +"\">[클릭]이메일 인증하기</a>";
	
		new Thread(new Runnable() {
			@Override
			public void run() {
				sendMailClient.sendMail(email, subject, content);
				System.out.println("메일 발송 쓰레드 작업 완료!" + new Date());
			}
		}).start();
		
		System.out.println("메일 발송 쓰레드 작업 시작" + new Date());
		System.out.println("member email : " + email);
		
		MailAuthInfo mailAuthInfo = new MailAuthInfo(email, auth_code);
		
		return mailAuthInfo;
	}

	//	========================================================================
	public MailAuthInfo sendPasswdMail(MemberVO dbMember, String email, String temPasswd) {
		String dbemail = email;
		System.out.println(dbMember);
//		String tempPasswd = GenerateRandomCode.getRandomCode(5);
		
		String subject = "[굿바이]임시 비밀번호가 발급되었습니다.";
		String content = "<h1>" + temPasswd + "</h1>";
		
		new Thread(new Runnable() {
			
			@Override
			public void run() {
				sendMailClient.sendMail(email, subject, content);
				System.out.println("비밀번호 변경 메일 발송 쓰레드 작업 완료!" + new Date());
			}
		}).start();
		
		System.out.println("memverVO" + dbMember.getMem_email());
		
		MailAuthInfo mailAuthInfo = new MailAuthInfo(email, temPasswd);
		return mailAuthInfo;
	}

	//	===========================메일 다시 보내기=============================================
	public MailAuthInfo reSendAuthMail(MemberVO member, String mem_email) {
			System.out.println("memberService : " + member);
			String mail = member.getMem_email();
			System.out.println("@@@@@@@@@@@@@"+ member.getMem_email());
			
			String auth_code = GenerateRandomCode.getRandomCode(50);
			
			String subject = "[굿바이]가입 인증코드 입니다.";
			// 주소 수정해야함!!
			String content = "<a href=\"http://localhost:8081/MemberEmailAuth?mem_email="+ mail + "&auth_code=" + auth_code +"\">[클릭]이메일 인증하기</a>";
			// String content = "<a href=\"http://c3d2407t1p1.itwillbs.com/MemberEmailAuth?mem_email="+ mail + "&auth_code=" + auth_code +"\">[클릭]이메일 인증하기</a>";
		
			new Thread(new Runnable() {
				@Override
				public void run() {
					sendMailClient.sendMail(mail, subject, content);
					System.out.println("메일 발송 쓰레드 작업 완료!" + new Date());
				}
			}).start();
			
			System.out.println("메일 발송 쓰레드 작업 시작" + new Date());
			System.out.println("member email : " + mail);
			
			MailAuthInfo mailAuthInfo = new MailAuthInfo(mail, auth_code);
			
			return mailAuthInfo;
		}

}
