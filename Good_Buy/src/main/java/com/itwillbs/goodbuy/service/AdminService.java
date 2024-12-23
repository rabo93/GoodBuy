package com.itwillbs.goodbuy.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.goodbuy.mapper.AdminMapper;

@Service
public class AdminService {

	@Autowired
	private AdminMapper mapper;
	
	@Transactional
	public int registCommonCode(Map<String, String> mainCode, List<Map<String, Object>> subCodes) {
		int insertMainCodeResult = mapper.insertCommonCode(mainCode);
		if(insertMainCodeResult == 0) {
			throw new RuntimeException("Fail to insert Main Code");
		}
		
		int insertSubCodeResult = mapper.insertCommonCodeType(subCodes);
		if(insertMainCodeResult == 0) {
			throw new RuntimeException("Fail to insert Sub Code");
		}
		
		return insertMainCodeResult + insertSubCodeResult;
	}

}
