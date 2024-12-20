package com.itwillbs.goodbuy.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.goodbuy.vo.PayToken;

@Mapper
public interface PayMapper {

	PayToken insertAccessToken(Map<String, Object> authResponse);

}
