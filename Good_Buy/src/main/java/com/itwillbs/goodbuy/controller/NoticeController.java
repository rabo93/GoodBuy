package com.itwillbs.goodbuy.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.goodbuy.service.NoticeService;
import com.itwillbs.goodbuy.vo.NoticeVO;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class NoticeController {
	@Autowired
	private NoticeService service;
	
	String uploadPath = "/resources/upload";
	
	
	@GetMapping("NoticeWrite")
	public String noticeWriteForm() {
		return "notice/notice_write_form";
	}
	
	@PostMapping("NoticeWrite")
	public String noticeWrite(NoticeVO notice, HttpSession session) {
		//	실제 경로
		String realPath = getRealPath(session);
		//	서브 디렉토리 생성
		String subDir = createDirectories(realPath);
		realPath += "/" + subDir;
		String fileName = addFileProcess(notice, realPath, subDir);
		log.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>> fileName : " + fileName);
		notice.setNotice_file(fileName);
		
		service.insertNotice(notice);
		
		return "redirect:/NoticeMain";
	}
	
	
	

	@GetMapping("NoticeMain")
	public String noticeMain(Model model) {
		List<NoticeVO> noticeList = service.getNoticeList();
		log.info(">>>> noticeList : " + noticeList);
		model.addAttribute("noticeList", noticeList);
		
		return "notice/notice_list";
	}
	
	
	//	============================================================================
	//	실제 업로드 경로 메서드
	public String getRealPath(HttpSession session) {
		String realPath = session.getServletContext().getRealPath(uploadPath);
		return realPath;
	}
	
	//	서브디렉토리 생성
	public String createDirectories(String realPath) {
		//	현재 시스템 날짜
		LocalDate today = LocalDate.now();
		//	날짜 포맷 패턴
		String datePattern = "yyyy/MM/dd";
		//	패턴 문자열 전달
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern(datePattern);
		
		//	날짜 형식으로 경로 저장
		String subDir = today.format(dtf);
		//	기존 실제 업로드 경로
		realPath += "/" + subDir;
		//	실제 경로 전달
		Path path = Paths.get(realPath);
		
		try {
			//	실제 경로 생성
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return subDir;
	}
	
	public String addFileProcess(NoticeVO notice, String realPath, String subDir) {
		MultipartFile muti = notice.getFile();
		notice.setNotice_file("");
		String fileName = "";
		
		if(!muti.getOriginalFilename().equals("")) {
			fileName = UUID.randomUUID().toString().subSequence(0, 8) + "_" + muti.getOriginalFilename();
			notice.setNotice_file(subDir +  "/" + fileName);
			try {
				muti.transferTo(new File(realPath, fileName));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		return fileName;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}


















