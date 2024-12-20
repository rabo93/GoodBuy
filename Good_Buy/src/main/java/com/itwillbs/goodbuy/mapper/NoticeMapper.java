package com.itwillbs.goodbuy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.goodbuy.vo.NoticeVO;

@Mapper
public interface NoticeMapper {
	//	공지사항 게시물 조회
	List<NoticeVO> getNoticeList();

	void insertNotice(NoticeVO notice);

}
