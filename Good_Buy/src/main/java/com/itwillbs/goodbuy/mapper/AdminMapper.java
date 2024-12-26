package com.itwillbs.goodbuy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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

}
