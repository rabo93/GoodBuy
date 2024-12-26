package com.itwillbs.goodbuy.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.management.RuntimeErrorException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.goodbuy.mapper.AdminMapper;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
public class AdminService {

	@Autowired
	private AdminMapper mapper;

	// [ 공통코드 ]
	// 공통코드 - 등록
	@Transactional
	public int registCommonCode(Map<String, Object> dataMap) {
		// 상위코드 등록
		Map<String, Object> mainCode = createMainCode(dataMap);
		int insertMainCodeResult = mapper.insertCommonCode(mainCode);
		if(insertMainCodeResult == 0) {
			throw new RuntimeException("공통코드 등록에 실패했습니다.");
		}
			
		// 하위코드 등록
		List<Map<String, Object>> subCodes = (List<Map<String, Object>>)dataMap.get("tbData");
		for(Map<String, Object> row : subCodes) {
			row.put("CODETYPE_ID", mainCode.get("CODETYPE_ID")); // 상위코드(PK) 넣어주기
		}
		log.info(">>>>> subCodes : " + subCodes);
		
		int insertSubCodeResult = mapper.insertCommonCodeType(subCodes);
		if(insertSubCodeResult == 0) {
			throw new RuntimeException("상세코드 등록에 실패했습니다.");
		}
		
		return insertMainCodeResult + insertSubCodeResult;
	}
	
	// 메인코드 map으로 변환
	public Map<String, Object> createMainCode(Map<String, Object> data) {
		Map<String, Object> mainCode = new HashMap<String, Object>();
		
		mainCode.put("CODETYPE_ID", data.get("CODETYPE_ID"));
		mainCode.put("CODETYPE_NAME", data.get("CODETYPE_NAME"));
		mainCode.put("DESCRIPTION", data.get("DESCRIPTION"));
		
		return mainCode;
	}

	// 공통코드 - 목록 조회
	public List<Map<String, Object>> getCommonCodes(int start, int length, String searchValue) {
		return mapper.selectCommonCodes(start, length, searchValue);
	}

	
}
