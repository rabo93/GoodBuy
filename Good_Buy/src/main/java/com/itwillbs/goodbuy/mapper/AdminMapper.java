package com.itwillbs.goodbuy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.goodbuy.aop.AdminLog;
import com.itwillbs.goodbuy.vo.FaqVO;
import com.itwillbs.goodbuy.vo.MemberVO;
import com.itwillbs.goodbuy.vo.NoticeVO;

@Mapper
public interface AdminMapper {

	// 공통코드 등록 (상위코드)
	@AdminLog
	int insertCommonCode(Map<String, Object> mainCode);

	// 공통코드 등록 (하위코드)
	@AdminLog
	int insertCommonCodeType(@Param("subCodes") List<Map<String, Object>> subCodes);

	// 공통코드 목록 조회
	List<Map<String, Object>> selectCommonCodes(@Param("param") Map<String, Object> param);
	
	// 공통코드 컬럼 수 조회
	int selectCommonCodesTotal();

	// 공통코드 검색 컬럼 수 조회
	int selectCommonCodesFiltered(@Param("param") Map<String, Object> param);

	// 공통코드 컬럼 수정
	@AdminLog
	int updateCommonCodes(Map<String, Object> param);

	// 공통코드 컬럼 삭제
	@AdminLog
	int deleteCommonCodes(Map<String, Object> param);

	// 사용되지않는 공통코드(상위코드) 삭제
	@AdminLog
	int deleteDeprecatedCommonCode();

	//---------------------------------------------------------
	// 회원 목록 조회 + 검색 조건
	List<MemberVO> selectMemberList(@Param("param") Map<String, Object> param);

	// 회원 상세정보 조회
	MemberVO selectMember(String mem_id);
	
	// 회원 상태 수정
	@AdminLog
	int updateMemberInfo(MemberVO member);
	
	// 회원 목록 전체 컬럼 수 조회
	int selectMemberListTotal();
	
	// 회원 검색 후 컬럼 수 조회
	int selectMemberListFiltered(@Param("param") Map<String, Object> param);
	
	// 회원 삭제
	@AdminLog
	int deleteMember(String mem_id);
	
	//---------------------------------------------------------
	// 신고 상품 목록 전체 컬럼 수 조회
	int selectProductReportTotal();
	
	// 신고 상품 검색 필터링 후 컬럼 수 조회
	int selectProductReportFiltered(@Param("param") Map<String, Object> param);

	// 필터링 된 신고 상품 목록 가져오기
	List<Map<String, Object>> selectProductReportList(@Param("param") Map<String, Object> paramr);
	
	// 신고 상품 조치 및 수정
	@AdminLog
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
	@AdminLog
	int deleteNotice(@Param("deleteItems") List<Integer> deleteItems);
	
	//---------------------------------------------------------
	// Faq 목록 조회 (필터링, 검색어, 페이징 적용) + 검색 조건
	List<Map<String, Object>> selectFaqList(@Param("start") int start, 
											@Param("length") int length,
											@Param("searchValue") String searchValue,
											@Param("faqCate") int faqCate, 
											@Param("listStatus") int listStatus, 
											@Param("orderColumn") String orderColumn, 
											@Param("orderDir") String orderDir);
	
	// Faq 전체 컬럼 수 조회
	int selectFaqTotal();
	
	// FAQ 검색 후 컬럼 수 조회
	int selectFaqFiltered(
			@Param("faqCate") int faqCate, 
			@Param("listStatus") int listStatus, 		
			@Param("searchValue") String searchValue);

	// Faq 수정
	@AdminLog
	int updateFaqInfo(Map<String, Object> param);
	
	// Faq 삭제
	@AdminLog
	int deleteFaq(@Param("deleteItems") List<Integer> faqIds);

	//---------------------------------------------------------
	// 1:1 문의 목록 전체 컬럼 수 조회
	int selectEnquireTotal();
	
	// 1:1 문의 검색 필터링 후 컬럼 수 조회
	int selectEnquireListFiltered(@Param("param") Map<String, Object> param);
	
	// 필터링 된 1:1 문의 목록 가져오기
	List<Map<String, Object>> selectEnquireList(@Param("param") Map<String, Object> param);
	
	// 답글 등록(수정)
	@AdminLog
	int updateReplyInfo(Map<String, Object> param);

	// =====================================================
	// 로그 저장
	int insertLog(@Param("log") Map<String, Object> result);


}
