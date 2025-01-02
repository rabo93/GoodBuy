package com.itwillbs.goodbuy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.goodbuy.vo.FaqVO;
import com.itwillbs.goodbuy.vo.MemberVO;

@Mapper
public interface AdminMapper {

	// 공통코드 등록 (상위코드)
	int insertCommonCode(Map<String, Object> mainCode);

	// 공통코드 등록 (하위코드)
	int insertCommonCodeType(@Param("subCodes") List<Map<String, Object>> subCodes);

	// 공통코드 목록 조회
	List<Map<String, Object>> selectCommonCodes(
			@Param("start") int start, 
			@Param("length") int length,
			@Param("searchValue") String searchValue,
			@Param("orderColumn") String orderColumn,
			@Param("orderDir") String orderDir);
	
	// 공통코드 컬럼 수 조회
	int selectCommonCodesTotal();

	// 공통코드 검색 컬럼 수 조회
	int selectCommonCodesFiltered(String searchValue);

	// 공통코드 컬럼 수정
	int updateCommonCodes(Map<String, Object> param);

	// 공통코드 컬럼 삭제
	int deleteCommonCodes(Map<String, Object> param);

	// 사용되지않는 공통코드(상위코드) 삭제
	int deleteDeprecatedCommonCode();

	// 회원 목록 조회 + 검색 조건
	List<MemberVO> selectMemberList(
			@Param("start") int start, 
			@Param("length") int length, 
			@Param("searchValue") String searchValue, 
			@Param("memStatus") int memStatus, 
			@Param("memGrade") String memGrade, 
			@Param("orderColumn") String orderColumn, 
			@Param("orderDir") String orderDir);

	// 회원 상세정보 조회
	MemberVO selectMember(String mem_id);
	
	// 회원 상태 수정
	int updateMemberInfo(MemberVO member);
	
	// 회원 목록 전체 컬럼 수 조회
	int selectMemberListTotal();
	
	// 회원 검색 후 컬럼 수 조회
	int selectMemberListFiltered(
			@Param("memStatus") int memStatus, 
			@Param("memGrade") String memGrade, 
			@Param("searchValue") String searchValue);
	
	// 회원 삭제
	int deleteMember(String mem_id);
	
	//---------------------------------------------------------
	// Faq 목록 조회
	List<Map<String, Object>> selectFaqList(@Param("start") int start, 
											@Param("length") int length,
											@Param("searchValue") String searchValue);
	// Faq 컬럼 수 조회
	int selectFaqTotal();
	
	// FAQ 검색 컬럼 수 조회
	int selectFaqFiltered(String searchValue);

	// Faq 수정
	int updateFaqInfo(Map<String, Object> param);
	
	// Faq 삭제
	int deleteFaq(int faqId);

}
