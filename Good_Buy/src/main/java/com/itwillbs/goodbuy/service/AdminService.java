package com.itwillbs.goodbuy.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.management.RuntimeErrorException;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.goodbuy.aop.AdminLog;
import com.itwillbs.goodbuy.mapper.AdminMapper;
import com.itwillbs.goodbuy.vo.FaqVO;
import com.itwillbs.goodbuy.vo.MemberVO;
import com.itwillbs.goodbuy.vo.NoticeVO;
import com.itwillbs.goodbuy.vo.ProductOrderVO;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
public class AdminService {

	@Autowired
	private AdminMapper mapper;

	// ============== [ 공통코드 ] ==============
	// 공통코드 - 등록
	@AdminLog
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
	public List<Map<String, Object>> getCommonCodes(Map<String, Object> param) {
		return mapper.selectCommonCodes(param);
	}

	// 공통코드 전체 컬럼 수 조회
	public int getCommonCodesTotal() {
		return mapper.selectCommonCodesTotal();
	}

	// 공통코드 검색 컬럼 수 조회
	public int getCommonCodesFiltered(Map<String, Object> param) {
		return mapper.selectCommonCodesFiltered(param);
	}

	// 공통코드 컬럼 수정
	@AdminLog
	public int modifyCommonCode(Map<String, Object> param) {
		return mapper.updateCommonCodes(param);
	}

	// 공통코드 컬럼 삭제
	@AdminLog
	@Transactional
	public int removeCommonCode(Map<String, Object> param) {
		// 상위코드 삭제
		int deleteCommonCodeResult = mapper.deleteCommonCodes(param);
		if(deleteCommonCodeResult == 0) {
			log.info(">>> 삭제할 상위코드가 없습니다.");
			throw new RuntimeException("공통코드 삭제에 실패했습니다.");
		}
		
		// 하위코드 삭제
		int deleteDeprecatedCommonCodeResult = mapper.deleteDeprecatedCommonCode();
		
        return deleteCommonCodeResult + deleteDeprecatedCommonCodeResult;
	}

	// ============== [ 회원관리 ] ==============
	// 회원 목록 조회
	public List<MemberVO> getMemberList(Map<String, Object> param) {
		return mapper.selectMemberList(param);
	}

	// 회원 상세 조회
	public MemberVO getMember(String mem_id) {
		return mapper.selectMember(mem_id);
	}

	// 회원 상태 수정
	@AdminLog
	public int modifyMemberInfo(MemberVO member) {
		return mapper.updateMemberInfo(member);
	}
	
	// 회원 목록 전체 컬럼 수 조회
	public int getMemberListTotal() {
		return mapper.selectMemberListTotal();
	}
	
	// 회원 목록 필터 후 컬럼 수 조회
	public int getMemberListFiltered(Map<String, Object> param) {
		return mapper.selectMemberListFiltered(param);
	}
	
	// 회원 삭제
	@AdminLog
	public int removeMember(String mem_id) {
		return mapper.deleteMember(mem_id);
	}
	
	// ============== [ 신고 관리 ] ==============
	// [ 신고 회원 관리 ]
	// 신고 회원 목록 전체 컬럼 수 조회
	public int getUserReportTotal() {
		return mapper.selectUserReportTotal();
	}
	
	// 신고 회원 검색 필터링 후 컬럼 수 조회
	public int getUserReportFiltered(Map<String, Object> param) {
		return mapper.selectUserReportFiltered(param);
	}
	
	// 필터링 된 신고 회원 목록 가져오기
	public List<Map<String, Object>> getUserReportList(Map<String, Object> param) {
		return mapper.selectUserReportList(param);
	}
	

	// 신고 회원 - 조치 및 수정
	@AdminLog
	@Transactional
	public int modifyUserReport(Map<String, Object> param) {
		// 회원 신고 횟수 누적
		int updateReportCount = mapper.updateUserReportCount(param);
		System.out.println("회원신고 누적횟수 결과 : " + updateReportCount);
		
		int updateUserReport = mapper.updateUserReport(param);
		if(updateUserReport == 0) {
			throw new RuntimeException("신고 조치 작업에 실패했습니다.");
		}
		
        return updateReportCount + updateUserReport;
	}
	
	// [ 신고 상품 관리 ]
	// 신고 상품 목록 전체 컬럼 수 조회
	public int getProductReportTotal() {
		return mapper.selectProductReportTotal();
	}
	
	// 신고 상품 검색 필터링 후 컬럼 수 조회
	public int getProductReportFiltered(Map<String, Object> param) {
		return mapper.selectProductReportFiltered(param);
	}
	
	// 필터링 된 신고 상품 목록 가져오기
	public List<Map<String, Object>> getProductReportList(Map<String, Object> param) {
		return mapper.selectProductReportList(param);
	}
	
	// 신고 상품 - 조치 및 수정
	@AdminLog
	public int modifyProductReport(Map<String, Object> param) {
		return mapper.updateProductReport(param);
	}
	
	// ============== [ 공지사항 관리 ] ==============
	// 공지사항 목록 전체 컬럼 수 조회
	public int getNoticeListTotal() {
		return mapper.selectNoticeListTotal();
	}
	
	// 공지사항 필터링 후 컬럼 수 조회
	public int getNoticeListFiltered(Map<String, Object> param) {
		return mapper.selectNoticeListFiltered(param);
	}
	
	// 공지사항 전체 목록 조회 (필터링, 검색어, 페이징 적용)
	public List<NoticeVO> getNoticeList(Map<String, Object> param) {
		return mapper.selectNoticeList(param);
	}
	
	// 공지사항 첨부파일 가져오기
	public List<NoticeVO> getNoticeBoardFileList(List<Integer> deleteItems) {
		return mapper.selectNoticeBoardFileList(deleteItems);
	}
	
	// 공지사항 삭제
	@AdminLog
	public int removeNotice(List<Integer> deleteItems) {
		return mapper.deleteNotice(deleteItems);
	}
	
	// ============== [ FAQ 관리 ] ==============
	// FAQ 목록 조회  (필터링, 검색어, 페이징 적용)
	public List<Map<String, Object>> getFaqList(Map<String, Object> param) {
		log.info(">>> admin faq");
		return mapper.selectFaqList(param);
	}
	
	// FAQ 전체 컬럼 수 조회
	public int getFaqTotal() {
		return mapper.selectFaqTotal();
	}
	
	// FAQ 검색 컬럼 수 조회
	public int getFaqFiltered(Map<String, Object> param) {
		return mapper.selectFaqFiltered(param);
	}
	
	// FAQ 수정
	@AdminLog
	public int modifyFaqInfo(Map<String, Object> param) {
		return mapper.updateFaqInfo(param);
	}
	
	// FAQ 삭제
	@AdminLog
	public int removeFaq(List<Integer> faqIds) {
		return mapper.deleteFaq(faqIds);
	}

	// ============== [ 1:1 문의 관리 ] ==============
	// 1:1 문의 목록 전체 컬럼 수 조회
	public int getEnquireListTotal() {
		return mapper.selectEnquireTotal();
	}
	// 1:1 문의 검색 필터링 후 컬럼 수 조회
	public int getEnquireListFiltered(Map<String, Object> param) {
		return mapper.selectEnquireListFiltered(param);
	}
	// 필터링 된 1:1 문의 목록 가져오기
	public List<Map<String, Object>> getEnquireList(Map<String, Object> param) {
		return mapper.selectEnquireList(param);
	}
	
	
	// 답글 등록(수정)
	@AdminLog
	public int registReplyInfo(Map<String, Object> param) {
		return mapper.updateReplyInfo(param);
	}

	// =========================================================================
	// 로그 저장
	// @Transactional(propagation = Propagation.REQUIRES_NEW)
	// => Spring 트랜잭션 관리에서 트랜잭션의 전파 속성(Propagation)을 설정하는 옵션 중 하나
	//    새로운 트랜잭션 생성, 독립적인 트랜잭션, 롤백 및 커밋의 독립성 특성을 지님
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public int registLog(Map<String, Object> result) {
		return mapper.insertLog(result);
	}
	// =========================================================================

	// ============== [ 결제 관리 ] ==============
	// 상품 거래 목록 전체 컬럼 수 조회
	public int getOrderListTotal() {
		return mapper.selectOrderListTotal();
	}
	// 상품 거래 검색 필터링 후 컬럼 수 조회
	public int getOrderListFiltered(Map<String, Object> convertParam) {
		return mapper.selectOrderListFiltered(convertParam);
	}
	// 필터링 된 상품 거래 목록 가져오기
	public ProductOrderVO getOrderList(Map<String, Object> convertParam) {
		return mapper.selectOrderList(convertParam);
	}
	
	
//	// 답글 등록(수정)
//	public int registReplyInfo(Map<String, Object> param) {
//		return mapper.updateReplyInfo(param);
//	}


	
}
