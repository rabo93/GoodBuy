package com.itwillbs.goodbuy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.goodbuy.aop.AdminLog;
import com.itwillbs.goodbuy.vo.FaqVO;
import com.itwillbs.goodbuy.vo.MemberVO;
import com.itwillbs.goodbuy.vo.NoticeVO;
import com.itwillbs.goodbuy.vo.ProductOrderVO;

@Mapper
public interface AdminMapper {

	// 공통코드 등록 (상위코드)
	int insertCommonCode(Map<String, Object> mainCode);

	// 공통코드 등록 (하위코드)
	int insertCommonCodeType(@Param("subCodes") List<Map<String, Object>> subCodes);

	// 공통코드 목록 조회
	List<Map<String, Object>> selectCommonCodes(@Param("param") Map<String, Object> param);
	
	// 공통코드 컬럼 수 조회
	int selectCommonCodesTotal();

	// 공통코드 검색 컬럼 수 조회
	int selectCommonCodesFiltered(@Param("param") Map<String, Object> param);

	// 공통코드 컬럼 수정
	int updateCommonCodes(Map<String, Object> param);

	// 공통코드 컬럼 삭제
	int deleteCommonCodes(Map<String, Object> param);

	// 사용되지않는 공통코드(상위코드) 삭제
	int deleteDeprecatedCommonCode();

	//---------------------------------------------------------
	// 회원 목록 조회 + 검색 조건
	List<MemberVO> selectMemberList(@Param("param") Map<String, Object> param);

	// 회원 상세정보 조회
	MemberVO selectMember(String mem_id);
	
	// 회원 상태 수정
	int updateMemberInfo(MemberVO member);
	
	// 회원 목록 전체 컬럼 수 조회
	int selectMemberListTotal();
	
	// 회원 검색 후 컬럼 수 조회
	int selectMemberListFiltered(@Param("param") Map<String, Object> param);
	
	// 회원 삭제
	int deleteMember(String mem_id);
	
	//---------------------------------------------------------
	// 신고 회원 목록 전체 컬럼 수 조회
	int selectUserReportTotal();

	// 신고 회원 검색 필터링 후 컬럼 수 조회
	int selectUserReportFiltered(@Param("param") Map<String, Object> param);

	// 필터링 된 신고 회원 목록 가져오기
	List<Map<String, Object>> selectUserReportList(@Param("param") Map<String, Object> param);
	
	// 신고 회원 조치 및 수정
	int updateUserReport(Map<String, Object> param);

	// 회원 신고 횟수 누적
	int updateUserReportCount(Map<String, Object> param);
	
	// 회원 목록에서 경고횟수, 현재 상태(등급) 조회
	Map<String, Object> selectUserReportInfo(String memId);

	// 회원 경고횟수에 따른 계정 상태(등급) 업데이트
	int updateUserStatus(String memId);
	
	//---------------------------------------------------------
	// 신고 상품 목록 전체 컬럼 수 조회
	int selectProductReportTotal();
	
	// 신고 상품 검색 필터링 후 컬럼 수 조회
	int selectProductReportFiltered(@Param("param") Map<String, Object> param);

	// 필터링 된 신고 상품 목록 가져오기
	List<Map<String, Object>> selectProductReportList(@Param("param") Map<String, Object> paramr);
	
	// 신고 상품 조치 및 수정
	int updateProductReport(Map<String, Object> param);
	
	//---------------------------------------------------------
	// 공지사항 전체 목록 컬럼 수 조회
	int selectNoticeListTotal();
	
	// 공지사항 필터링 후 목록 컬럼 수 조회
	int selectNoticeListFiltered(@Param("param") Map<String, Object> param);
	
	// 공지사항 전체 목록 조회 (필터링, 검색어, 페이징 적용)
	List<NoticeVO> selectNoticeList(@Param("param") Map<String, Object> param);
	
	// 공지사항 첨부파일 가져오기
	List<NoticeVO> selectNoticeBoardFileList(@Param("deleteItems") List<Integer> deleteItems);
	
	// 공지사항 삭제
	int deleteNotice(@Param("deleteItems") List<Integer> deleteItems);
	
	//---------------------------------------------------------
	// Faq 목록 조회 (필터링, 검색어, 페이징 적용) + 검색 조건
	List<Map<String, Object>> selectFaqList(@Param("param") Map<String, Object> param);
	
	// Faq 전체 컬럼 수 조회
	int selectFaqTotal();
	
	// FAQ 검색 후 컬럼 수 조회
	int selectFaqFiltered(@Param("param") Map<String, Object> param);

	// Faq 수정
	int updateFaqInfo(Map<String, Object> param);
	
	// Faq 삭제
	int deleteFaq(@Param("deleteItems") List<Integer> faqIds);

	//---------------------------------------------------------
	// 1:1 문의 목록 전체 컬럼 수 조회
	int selectEnquireTotal();
	
	// 1:1 문의 검색 필터링 후 컬럼 수 조회
	int selectEnquireListFiltered(@Param("param") Map<String, Object> param);
	
	// 필터링 된 1:1 문의 목록 가져오기
	List<Map<String, Object>> selectEnquireList(@Param("param") Map<String, Object> param);
	
	// 답글 등록(수정)
	int updateReplyInfo(Map<String, Object> param);

	// =====================================================
	// 로그 저장
	int insertLog(@Param("log") Map<String, Object> result);
	// =====================================================
	
	//---------------------------------------------------------
	// 결제 관리
	// 상품 거래 목록 전체 컬럼 수 조회
	int selectOrderListTotal();
	// 상품 거래 검색 필터링 후 컬럼 수 조회
	int selectOrderListFiltered(@Param("param") Map<String, Object> param);
	
	// 필터링 된 상품 거래 목록 가져오기
	List<ProductOrderVO> selectOrderList(@Param("param") Map<String, Object> param);

	// --------------------------------------------------------
	// [ 로그 ]
	// 로그 목록 전체 컬럼 수 조회
	int selectLogListTotal();
	
	// 로그 필터링 후 컬럼 수 조회
	int selectLogListFiltered(@Param("param") Map<String, Object> param);
	
	// 필터링 된 로그 목록 조회
	List<MemberVO> selectLogList(@Param("param")Map<String, Object> param);

	// 회원 신고 기록 목록 조회
	List<Map<String, Object>> selectReportHistory(String mem_id);


}
