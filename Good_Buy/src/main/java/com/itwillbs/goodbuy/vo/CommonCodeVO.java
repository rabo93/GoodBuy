package com.itwillbs.goodbuy.vo;

import java.util.List;
import java.util.Map;

import lombok.Data;

@Data
public class CommonCodeVO {
	private Map<String, Object> mainCode;
	private List<Map<String, Object>> subCodes;
}
