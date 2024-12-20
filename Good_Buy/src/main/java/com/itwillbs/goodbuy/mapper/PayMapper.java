package com.itwillbs.goodbuy.mapper;

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


}
