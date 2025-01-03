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
import com.itwillbs.goodbuy.vo.FaqVO;
import com.itwillbs.goodbuy.vo.MemberVO;
import com.itwillbs.goodbuy.vo.NoticeVO;

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
	public List<Map<String, Object>> getCommonCodes(int start, int length, String searchValue, String orderColumn, String orderDir) {
		return mapper.selectCommonCodes(start, length, searchValue, orderColumn, orderDir);
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
	public List<MemberVO> getMemberList(
			int start, 
			int length, 
			String searchValue, 
			int memStatus, 
			String memGrade, 
			String orderColumn, 
			String orderDir) {
		return mapper.selectMemberList(start, length, searchValue, memStatus, memGrade, orderColumn, orderDir);
	}

	// 회원 상세 조회
	public MemberVO getMember(String mem_id) {
		return mapper.selectMember(mem_id);
	}

	// 회원 상태 수정
	public int modifyMemberInfo(MemberVO member) {
		return mapper.updateMemberInfo(member);
	}
	
	// 회원 목록 전체 컬럼 수 조회
	public int getMemberListTotal() {
		return mapper.selectMemberListTotal();
	}
	
	// 회원 목록 필터 후 컬럼 수 조회
	public int getMemberListFiltered(int memStatus, String memGrade, String searchValue) {
		return mapper.selectMemberListFiltered(memStatus, memGrade, searchValue);
	}
	
	// 회원 삭제
	public int removeMember(String mem_id) {
		return mapper.deleteMember(mem_id);
	}
	
	// ============== [ 공지사항 관리 ] ==============
	// [ 신고 회원 관리 ]
	
	// [ 신고 상품 관리 ]
	// 신고 상품 목록 전체 컬럼 수 조회
	public int getProductReportTotal() {
		return mapper.selectProductReportTotal();
	}
	
	// 신고 상품 검색 필터링 후 컬럼 수 조회
	public int getProductReportFiltered(String status, String searchValue, String searchDate) {
		return mapper.selectProductReportFiltered(status, searchValue, searchDate);
	}
	
	// 필터링 된 신고 상품 목록 가져오기
	public List<Map<String, Object>> getProductReportList(int start, int length, String status, String searchValue, String searchDate, String orderColumn, String orderDir) {
		return mapper.selectProductReportList(start, length, status, searchValue, searchDate, orderColumn, orderDir);
	}
	
	// ============== [ 공지사항 관리 ] ==============
	// 공지사항 목록 전체 컬럼 수 조회
	public int getNoticeListTotal() {
		return mapper.selectNoticeListTotal();
	}
	
	// 공지사항 필터링 후 컬럼 수 조회
	public int getNoticeListFiltered(String searchValue) {
		return mapper.selectNoticeListFiltered(searchValue);
	}
	
	// 공지사항 전체 목록 조회 (필터링, 검색어, 페이징 적용)
	public List<NoticeVO> getNoticeList(int start, int length, String searchValue, String orderColumn, String orderDir) {
		return mapper.selectNoticeList(start, length, searchValue, orderColumn, orderDir);
	}
	
	// 공지사항 삭제
	public int removeNotice(List<Integer> deleteItems) {
		return mapper.deleteNotice(deleteItems);
	}
	
	// ============== [ FAQ 관리 ] ==============
	// FAQ 목록 조회
	public List<Map<String, Object>> getFaqList(int start, int length, String searchValue) {
		log.info(">>> admin faq");
		return mapper.selectFaqList(start, length, searchValue);
	}
	
	// FAQ 전체 컬럼 수 조회
	public int getFaqTotal() {
		return mapper.selectFaqTotal();
	}
	
	// FAQ 검색 컬럼 수 조회
	public int getFaqFiltered(String searchValue) {
		return mapper.selectFaqFiltered(searchValue);
	}
	
	// FAQ 수정
	public int modifyFaqInfo(Map<String, Object> param) {
		return mapper.updateFaqInfo(param);
	}
	
	// FAQ 삭제
	public int removeFaq(int faqId) {
		return mapper.deleteFaq(faqId);
	}





	


	








	
}
