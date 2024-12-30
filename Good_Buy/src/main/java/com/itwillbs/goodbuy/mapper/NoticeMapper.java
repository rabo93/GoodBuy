package com.itwillbs.goodbuy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.goodbuy.vo.NoticeVO;

@Mapper
public interface NoticeMapper {
	//	공지사항 게시물 조회
	List<NoticeVO> getNoticeList(@Param("startRow") int startRow,
								 @Param("listLimit") int listLimit,
								 @Param("searchType") String searchType,
								 @Param("searchKeyword") String searchKeyword);
	
	//	공지사항 글 쓰기
	void insertNotice(NoticeVO notice);
	
	//	글 상세내용 조회
	NoticeVO getNoticeBoard(int notice_id);
	
	//	공지사항 게시글 삭제
	int deleteNotice(int notice_id);
	
	//	공지사항 수정폼에서 첨부파일 삭제
	int deleteNoticeFile(Map<String, String> map);
	
	//	공지사항 수정
	int updateNotice(NoticeVO notice);

	//	조회수 증가
	void updateReadCount(NoticeVO notice);
	
	//	공지사항 게시글 총 갯수
	int getNoticeListCount(@Param("searchType") String searchType,
						   @Param("searchKeyword") String searchKeyword);
}
