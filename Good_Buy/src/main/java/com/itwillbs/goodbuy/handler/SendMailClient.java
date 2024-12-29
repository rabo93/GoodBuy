package com.itwillbs.goodbuy.handler;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class SendMailClient {
    @Autowired
    private MailAuthenticator authenticator;
    
    private final String HOST = "smtp.gmail.com";
    private final String PORT = "587";
    private final String SENDER_ADDRESS = "paighkdlxld2@gmail.com";

    public void sendMail(String receiver, String subject, String content) {
        try {
            Properties props = System.getProperties();
            
            props.put("mail.smtp.host", HOST);
            props.put("mail.smtp.port", PORT);
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.ssl.protocols", "TLSv1.2");
            props.put("mail.smtp.ssl.trust", HOST);
            
            Session mailSession = Session.getDefaultInstance(props, authenticator);
            Message message = new MimeMessage(mailSession);
            Address senderAddress = new InternetAddress(SENDER_ADDRESS, "굿바이 관리자");
            
            
            Address receiverAddress = new InternetAddress(receiver);
            message.setHeader("content-type", "text/html; charset=UTF-8");
            message.setFrom(senderAddress);
            message.setRecipient(RecipientType.TO, receiverAddress);
            message.setSubject(subject);
            message.setContent("<h3>" + content + "</h3>", "text/html; charset=UTF-8");
            message.setSentDate(new Date());
            
//            System.out.println("MemberVO 이메일 값: " + );
            
            Transport.send(message);
            System.out.println("인증메일 발송 성공");
        } catch (AddressException e) {
            System.out.println("인증메일 발송 실패1");
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            System.out.println("인증메일 발송 실패2");
            e.printStackTrace();
        } catch (MessagingException e) {
            System.out.println("인증메일 발송 실패3");
            e.printStackTrace();
        }
    }
}
