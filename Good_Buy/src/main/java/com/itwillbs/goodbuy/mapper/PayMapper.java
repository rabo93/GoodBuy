package com.itwillbs.goodbuy.mapper;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.goodbuy.vo.PayToken;

@Mapper
public interface PayMapper {

	// 기존 엑세스토큰 정보 조회
	String selectTokenInfo(Map<String, Object> map);
	
	// 엑세스토큰 정보 저장
	PayToken insertAccessToken(Map<String, Object> authResponse);

	// 엑세스토큰 정보 갱신
	void updateAccessToken(Map<String, Object> map);

	// 엑세스토큰 정보 조회 요청
	PayToken selectPayTokenInfo(String mem_id);

	// DB 사용자 대표계좌 정보 조회 
	String selectRepresentAccount(Map<String, Object> map);
	
	// DB 사용자 대표계좌 정보 등록 
	int insertRepresentAccount(Map<String, Object> map);

	// DB 사용자 대표계좌 정보 변경 
	int updateRepresentAccount(Map<String, Object> map);

	// DB 사용자 대표계좌 정보 조회 - fintech_num
	String selectRepresentAccountNum(String user_seq_no);


}
