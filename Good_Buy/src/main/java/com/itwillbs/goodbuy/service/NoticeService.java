package com.itwillbs.goodbuy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.goodbuy.mapper.NoticeMapper;
import com.itwillbs.goodbuy.vo.NoticeVO;

@Service
public class NoticeService {
	@Autowired
	private NoticeMapper mapper;
	
	//	글 목록 불러오기
	public List<NoticeVO> getNoticeList(int startRow, int listLimit, String searchType, String searchKeyword) {
		return mapper.getNoticeList(startRow, listLimit, searchType, searchKeyword);
	}

	//	글 작성
	public void insertNotice(NoticeVO notice) {
		mapper.insertNotice(notice);
	}
	
	//	글 상세조회
	public NoticeVO getNoticeBoard(int notice_id, boolean isReadCount) {
		NoticeVO notice = mapper.getNoticeBoard(notice_id);
		
		//	조회수 증가 작업
		if(notice != null && isReadCount) {
			mapper.updateReadCount(notice);
		}
		
		return notice;
	}
	
	//	공지사항 게시글 삭제
	public int deleteNotice(int notice_id) {
		return mapper.deleteNotice(notice_id);
	}
	
	//	공지사항 수정폼에서 첨부파일 삭제
	public int deleteNoticeFile(Map<String, String> map) {
		return mapper.deleteNoticeFile(map);
	}
	
	//	공지사항 수정
	public int updateNotice(NoticeVO notice) {
		return mapper.updateNotice(notice);
	}
	
	//	공지사항 게시글 총 갯수
	public int getNoticeListCount(String searchType, String searchKeyword) {
		return mapper.getNoticeListCount(searchType, searchKeyword);
	}

}
