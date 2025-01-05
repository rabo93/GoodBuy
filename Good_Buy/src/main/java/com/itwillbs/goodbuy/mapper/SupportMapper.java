package com.itwillbs.goodbuy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.goodbuy.vo.SupportVO;

@Mapper
public interface SupportMapper {

//	List<SupportVO> selectSupportList(String id);

	SupportVO selectSupportDetail(int support_id);

	List<SupportVO> selectSupportList(int startRow, int listLimit,
									@Param("MEM_ID")String id);

	int selectSupportListCount(String id);
	//1:1 글쓰기
	int insertSupport(SupportVO support);

	
	
}
