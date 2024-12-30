package com.itwillbs.goodbuy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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
			@Param("searchValue") String searchValue);
	
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

	// 회원 목록 조회
	List<MemberVO> selectMemberList();

	// 회원 상세정보 조회
	MemberVO selectMember(String mem_id);

}
