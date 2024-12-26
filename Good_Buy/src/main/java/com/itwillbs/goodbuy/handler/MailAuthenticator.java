package com.itwillbs.goodbuy.handler;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class MailAuthenticator extends Authenticator {
//	@Value("${SENDER_MAIL_ADDRESS}")
//	private String sender_mail_address;
//	
//	@Value("${GMAIL_APP_PASSWORD}")
//	private String gmail_app_password;
//	
//	private PasswordAuthentication passwordAuthentication;
//	
//	public MailAuthenticator() {
//		System.out.println("MailAuthenticator()");
//	}
//	@Override
//	protected PasswordAuthentication getPasswordAuthentication() {
//		passwordAuthentication = new PasswordAuthentication(sender_mail_address, gmail_app_password);
////		passwordAuthentication = new PasswordAuthentication("paighkdlxld2@gmail.com", "fhotnojirxjwxanc");
//		return passwordAuthentication;
//	}
	
}
