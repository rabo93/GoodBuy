package com.itwillbs.goodbuy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.goodbuy.mapper.NoticeMapper;
import com.itwillbs.goodbuy.vo.NoticeVO;

@Service
public class NoticeService {
	@Autowired
	private NoticeMapper mapper;
	
	
	public List<NoticeVO> getNoticeList() {
		return mapper.getNoticeList();
	}

	//	글 작성
	public void insertNotice(NoticeVO notice) {
		mapper.insertNotice(notice);
	}

}
