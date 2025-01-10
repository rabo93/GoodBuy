package com.itwillbs.goodbuy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.goodbuy.vo.SupportVO;

@Mapper
public interface SupportMapper {

//	List<SupportVO> selectSupportList(String id);

	SupportVO selectSupportDetail(int support_id);

	List<SupportVO> selectSupportList(int startRow, int listLimit,
									@Param("MEM_ID")String id,
									@Param("searchKeyword") String searchKeyword);

	int selectSupportListCount(String id);
	//1:1 글쓰기
	int insertSupport(SupportVO support);

	//1:1 글쓰기 삭제
	int deleteSupport(int support_id);

	//1:1 글쓰기 수정
//	int updateSupport(
//			@Param("support_id") int support_id
//			,@Param("support_subject") String support_subject
//			,@Param("support_content") String support_content);

	int updateSupport(SupportVO support);
	//// 1:1 문의글 수정 - 첨부파일 삭제
	int deleteSupportFile(Map<String, String> map);
	
	
}
