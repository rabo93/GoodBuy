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
import com.itwillbs.goodbuy.vo.MemberVO;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
public class AdminService {

	@Autowired
	private AdminMapper mapper;

	// ============== [ 공통코드 ] ==============
	// 공통코드 - 등록
	@Transactional
	public int registCommonCode(Map<String, Object> mainCode, List<Map<String, Object>> subCodes) {
		// 상위코드 등록
		int insertMainCodeResult = mapper.insertCommonCode(mainCode);
		if(insertMainCodeResult == 0) {
			throw new RuntimeException("공통코드 등록에 실패했습니다.");
		}
			
		// 하위코드 등록
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

	// 공통코드 - 목록 조회
	public List<Map<String, Object>> getCommonCodes(int start, int length, String searchValue) {
		return mapper.selectCommonCodes(start, length, searchValue);
	}

	// 공통코드 전체 컬럼 수 조회
	public int getCommonCodesTotal() {
		return mapper.selectCommonCodesTotal();
	}

	// 공통코드 검색 컬럼 수 조회
	public int getCommonCodesFiltered(String searchValue) {
		return mapper.selectCommonCodesFiltered(searchValue);
	}

	// 공통코드 컬럼 수정
	public int modifyCommonCode(Map<String, Object> param) {
		return mapper.updateCommonCodes(param);
	}

	// 공통코드 컬럼 삭제
	@Transactional
	public int removeCommonCode(Map<String, Object> param) {
		// 상위코드 삭제
		int deleteCommonCodeResult = mapper.deleteCommonCodes(param);
		if(deleteCommonCodeResult == 0) {
			throw new RuntimeException("공통코드 삭제에 실패했습니다.");
		}
		
		// 하위코드 삭제
		if(deleteCommonCodeResult > 0) {
			// 하위코드 삭제
			int deleteDeprecatedCommonCodeResult = mapper.deleteDeprecatedCommonCode();
			
	        return deleteCommonCodeResult + deleteDeprecatedCommonCodeResult;
		} else {
			log.info(">>> 삭제할 상위코드가 없습니다.");
		}
		
		return deleteCommonCodeResult;
	}

	// ============== [ 회원관리 ] ==============
	// 회원 목록 조회
	public List<MemberVO> getMemberList() {
		return mapper.selectMemberList();
	}

	// 회원 상세 조회
	public MemberVO getMember(String mem_id) {
		return mapper.selectMember(mem_id);
	}

	
}
