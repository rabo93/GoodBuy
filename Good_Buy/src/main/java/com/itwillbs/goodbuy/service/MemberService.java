package com.itwillbs.goodbuy.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

	// 이메일 조회 요청
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
	
	




}
