package com.itwillbs.goodbuy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.goodbuy.vo.SupportVO;

@Mapper
public interface SupportMapper {

	List<SupportVO> selectSupportList(String id);

	SupportVO selectSupportDetail(int support_id);
	
}
