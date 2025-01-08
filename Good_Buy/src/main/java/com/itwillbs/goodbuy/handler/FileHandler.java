package com.itwillbs.goodbuy.handler;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import net.coobird.thumbnailator.Thumbnailator;

@Component
public class FileHandler {
	
	//	실제 경로 리턴 메서드
	public String getRealPath(HttpSession session, String virtualPath) {
		return session.getServletContext().getRealPath(virtualPath);
	}
	
	//	중복 방지 처리
	public String processDuplicateFileName(String originalFilename) {
		String uuid = UUID.randomUUID().toString().substring(0,8);
		String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
		
		return System.currentTimeMillis() + "_" + uuid + fileExtension;
	}
	
	//	임시 경로에 저장된 파일을 실제 업로드 처리 메서드
	public String completeUpload(MultipartFile file, String realPath, String fileName) {
		String uploadFileName = "";
		String subDir = creatDirectories(realPath);
		
		try {
			file.transferTo(new File(realPath, subDir + "/" + fileName ));
			uploadFileName = subDir + "/" + fileName;
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return uploadFileName;
	}
	

	public String createThumbnailImage(String realPath, String uploadFileName) {
		String thumbnailFileName = "";
		StringBuffer sb = new StringBuffer(uploadFileName);
		sb.insert(sb.lastIndexOf("/") + 1, "thumb_");
		
		String fileName = sb.toString();
		
		File file = new File(realPath, uploadFileName);
		
		File thumbnailFile = new File(realPath, fileName);
		
		try(FileInputStream fis = new FileInputStream(file);
				FileOutputStream fos = new FileOutputStream(thumbnailFile);) {
			
			BufferedImage bufferedImage = ImageIO.read(fis);
			int width = bufferedImage.getWidth();
			int height = bufferedImage.getHeight();
			
			if(width > 150 || height > 150) {
				width = 150;
				height = 150;
			}
			
			Thumbnailator.createThumbnail(file, thumbnailFile, width, height);
			
			thumbnailFileName = sb.toString();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		
		return thumbnailFileName;
	}
	
	//	서브디렉토리 생성 메서드
	private String creatDirectories(String realPath) {
		String subDir = "";
		
		LocalDate today = LocalDate.now();
		String datePattern = "yyyy/MM/dd";
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern(datePattern);
		subDir = today.format(dtf);
		return subDir;
	}
	
	
}
