package com.itwillbs.goodbuy.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.goodbuy.vo.TermVO;

@Mapper
public interface TermMapper {

	TermVO getTerm(String type);

}
