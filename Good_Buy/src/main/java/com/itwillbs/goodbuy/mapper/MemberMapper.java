package com.itwillbs.goodbuy.mapper;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.goodbuy.vo.MailAuthInfo;
import com.itwillbs.goodbuy.vo.MemberVO;
import com.itwillbs.goodbuy.vo.WishlistVO;
import com.itwillbs.goodbuy.vo.SmsAuthInfoVO;

@Mapper
public interface MemberMapper {
	//회원 정보 조회
	MemberVO selectMember(String mem_id);

	//닉네임 조회
	MemberVO selectMemberNick(MemberVO member);

	//회원 추가
	int insertMember(MemberVO member);

	//회원정보 수정
	int updateMember(Map<String, String> map);

	// mail_auth_info 테이블에 이메일 아이디와 ,UUID로된 code 추가
	void insertMailAuthInfo(MailAuthInfo mailauthInfo);
	// ?
	void updateMailAuthInfo(MailAuthInfo mailauthInfo);

	MailAuthInfo selectMailAuthInfo(MailAuthInfo mailauthInfo);

	// 이메일 인증 후 회원상태 변경
	void updateMailAuthStatus(MailAuthInfo mailAuthInfo);

	//메일 인증 후 mail_auth_info 테이블 데이터 삭제
	void deleteMailAuthInfo(MailAuthInfo mailAuthInfo);
	
	// 회원 패스워드 조회
	String selectMemberPasswd(String id);
	

	//이메일 중복체크
	MemberVO selectEmailId(MemberVO member);
	
	
	//----------------------------------------------------------
	// 카카오 로그인 - 이메일 조회 요청
	MemberVO selectEmail(String mem_email);

	//----------------------------------------------------------
	//상점소개 저장
	int insertStoreIntro(MemberVO member);
	//상점소개 변경
	int updateStoreIntro(MemberVO member);

	//----------------------------------------------------------
	// [네이버] 회원 정보 저장
	int insertNaverMember(MemberVO member);
	//----------------------------------------------------------
	// [카카오] 회원정보 인서트 
	int insertMemberInfo(HashMap<String, Object> userInfo);
	// [카카오] 비밀번호 등록
	int updatePasswd(@Param("mem_id")String mem_id, @Param("securePasswd") String securePasswd);
	MemberVO getMemberById(String string);
	//----------------------------------------------------------
	// [CoolSMS] 휴대폰번호 인증 중복 확인
	String selectMemberInfo(String userPhone);
	// [CoolSMS] 휴대폰번호 인증 정보 저장
	void insertSmsAuthInfo(SmsAuthInfoVO smsAuthInfoVO);
	// [CoolSMS] 휴대폰번호 인증 정보 조회
	SmsAuthInfoVO selectSmsAuthInfo(String authCode);
	// [CoolSMS] 휴대폰번호 인증 상태 업데이트
	void updateAuthStatus(String authCode);
	//----------------------------------------------------------
	// 비밀번호 찾기 - 회원정보 찾기
	MemberVO selectMemInfo(String mem_phone);
	// 비밀번호 찾기 - 비밀번호 업데이트
	int updateTempPasswd(@Param("heshePasswd") String heshePasswd , @Param("mem_id") String mem_id);
	//----------------------------------------------------------
	// 회원탈퇴(삭제) 요청
//	void deleteMemInfo(String id);
	// 회원탈퇴(상태값 변경)
	void updateMemberStatus(@Param("mem_id") String id, @Param("mem_status") int mem_status);

	

	




	


	
}
