package com.itwillbs.goodbuy.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.goodbuy.mapper.TermMapper;
import com.itwillbs.goodbuy.vo.TermVO;

@Service
public class TermService {
	@Autowired
	private TermMapper mapper;

	public TermVO getTerm(String type) {
		return mapper.getTerm(type);
	}
}
