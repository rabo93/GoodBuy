package com.itwillbs.goodbuy.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AttendanceVO {
	private String mem_id;
	private LocalDate check_in_date;
	private int streak_days;
}
