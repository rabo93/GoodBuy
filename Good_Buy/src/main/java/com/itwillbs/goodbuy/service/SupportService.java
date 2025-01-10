package com.itwillbs.goodbuy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.goodbuy.mapper.SupportMapper;
import com.itwillbs.goodbuy.vo.SupportVO;

@Service
public class SupportService {
	@Autowired SupportMapper mapper;
	
	//문의사항 리스트 조회
//	public List<SupportVO> getSupporList(String id) {
//		return mapper.selectSupportList(id);
//	}

	public SupportVO getSupportDetail(int support_id) {
		return mapper.selectSupportDetail(support_id);
	}

	public List<SupportVO> getSupporList(int startRow, int listLimit, String id, String searchKeyword) {
		// TODO Auto-generated method stub
		return mapper.selectSupportList(startRow,listLimit,id,searchKeyword);
	}

	public int getSupportListCount(String id) {
		// TODO Auto-generated method stub
		return mapper.selectSupportListCount(id);
	}
	//1:1 글쓰기
	public int registSupport(SupportVO support) {
		// TODO Auto-generated method stub
		return mapper.insertSupport(support);
	}
	
	//1:1 글쓰기 삭제
	public int removeSupport(int support_id) {
		return mapper.deleteSupport(support_id);
	}

	//1:1 글쓰기 수정
//	public int EditSupport(int support_id, String support_subject, String support_content) {
//		return mapper.updateSupport(support_id,support_subject,support_content);
//	}

	public int EditSupport(SupportVO support) {
		return mapper.updateSupport(support);
	}
	//문의사항 첨부파일 삭제
	public int removeSupportFile(Map<String, String> map) {
		// TODO Auto-generated method stub
		return mapper.deleteSupportFile(map);
	}

}
