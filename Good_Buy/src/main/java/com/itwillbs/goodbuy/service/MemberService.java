package com.itwillbs.goodbuy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.goodbuy.mapper.MemberMapper;
import com.itwillbs.goodbuy.vo.MailAuthInfo;
import com.itwillbs.goodbuy.vo.MemberVO;
import com.itwillbs.goodbuy.vo.SmsAuthInfoVO;
import com.itwillbs.goodbuy.vo.WishlistVO;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
public class MemberService {
	@Autowired
	private MemberMapper mapper;
	
	
	// 회원가입 시 회원 정보 등록
	public int registMember(MemberVO member) {
		return mapper.insertMember(member);
	}

	// 회원 패스워드 조회
	public String getMemberPasswd(String id) {
		return mapper.selectMemberPasswd(id);
	}

	
	public MemberVO getMember(String mem_id) {
		return mapper.selectMember(mem_id);
		
	}
	
	public MemberVO getMemberNick(MemberVO member) {
		return mapper.selectMemberNick(member);
	}

	public MemberVO getMemberMail(MemberVO member) {
		return mapper.selectEmailId(member);
	}


	//-------------------------------------------------------------
	// 카카오 로그인 - 이메일 중복확인 조회 요청
	public MemberVO getMemberEmail(String mem_email) {
		return mapper.selectEmail(mem_email);
	}


	//-------------------------------------------------------------
	// 네이버 로그인 회원 저장
	public int registNaverMember(MemberVO member) {
		return mapper.insertNaverMember(member);
	}

	//-------------------------------------------------------------
	//상점소개 들고오기
	public MemberVO getStoreIntro(MemberVO member) {
		return mapper.selectStoreIntro(member);
	}

	//상점 소개 변경
	public int registStoreIntro(MemberVO member) {
		return mapper.updateStoreIntro(member);
	}

	
	//-------------------------------------------------------------
	// 회원 수정
	public int modifyMember(Map<String, String> map) {
		return mapper.updateMember(map);
	}
	
	
	
	
	
	
	//-------------------------------------------------------------
	// [CoolSMS] 휴대폰번호 인증 중복 확인
	public String getMemberInfo(String userPhone) {
		return mapper.selectMemberInfo(userPhone);
	}
	
	// [CoolSMS] 휴대폰번호 인증 정보 저장
	public void registSmsAuthInfo(SmsAuthInfoVO smsAuthInfoVO) {
		mapper.insertSmsAuthInfo(smsAuthInfoVO);
	}
	
	// [CoolSMS] 휴대폰번호 인증 정보 조회
	public SmsAuthInfoVO getSmsAuthInfo(String authCode) {
		return mapper.selectSmsAuthInfo(authCode);
	}
	
	// [CoolSMS] 휴대폰번호 인증 상태 업데이트
	public void updateAuthStatus(String authCode) {
		mapper.updateAuthStatus(authCode);
	}
	//-------------------------------------------------------------
	// 비밀번호 찾기 - 회원정보 찾기
	public MemberVO getMemInfo(String mem_phone) {
		return mapper.selectMemInfo(mem_phone);
	}
	
	// 비밀번호 찾기 - 비밀번호 업데이트
	public int setTempPasswd(String heshePasswd, String mem_id) {
		return mapper.updateTempPasswd(heshePasswd, mem_id);
	}
	
	//-------------------------------------------------------------
	// 회원탈퇴(회원 상태 3으로 업데이트) 요청
	@Transactional
	public void removeMemInfo(String id, int mem_status) {
		mapper.updateMemberStatus(id, mem_status);
	}


}
