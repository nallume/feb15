package org.nallume.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Random;
import java.util.UUID;
import java.util.concurrent.ThreadLocalRandom;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import net.coobird.thumbnailator.Thumbnailator;

@Component
public class Util {
	public int str2Int(String str) {
		int num = 0;
		String strChange;	
		strChange = str.replaceAll("[^0-9]", "");
		num = Integer.parseInt(strChange);
		
		return num; 
	}
	
	public int str2Int2(String str) {
		try {
			return Integer.parseInt(str);
		} catch (Exception e) {
			return 0;
		}
	}
	
	//2024-02-21 psd 웹표준
	//서블릿리퀘스트
	public HttpServletRequest req() {
		ServletRequestAttributes sra = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpServletRequest request = sra.getRequest();
		return request;
	}
	//세션
	public HttpSession getSession() {
		HttpSession session = req().getSession();
		return session;
		//return req().getSession();
	}
	
	//ip
	public String getIP() {
		HttpServletRequest request = req();
		String ip = request.getHeader("X-FORWARDED-FOR");
        if(ip == null) {
           ip = request.getHeader("Proxy-Client-IP");
        }
        if(ip == null) {
           ip = request.getHeader("WL-Proxy-Client-IP");   
        }
        if(ip == null) {
           ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if(ip == null) {
           ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if(ip == null) {
           ip = request.getRemoteAddr();
        }
        return ip;
	}
	
	// html태그를 특수기호로 변경하기 < &lt > &gt
	public static String removeTag(String str) {

		str = str.replaceAll("<", "&lt");
		str = str.replaceAll(">", "&gt");

		return str;
	}
	
	//숫자인지 검사하는 메소드
	public boolean intCheck(String str) {
		
		try {
			Integer.parseInt(str);
			return true;			
		} catch (Exception e) {
			return false;
		}
		
	}
	
	//메일보내기
	public void sendEmail(String mname, String email, String key) throws EmailException {
		//mail보내기
		String emailAddr = "";  //email주소
		String name = "바질농부"; 					  //보내는 사람 이름
		String passwd =""; 			  // 암호
		String hostName ="smtp-mail.outlook.com"; //smpt
		int port = 587; 						  // 포트번호
		
		
		SimpleEmail simpleEmail = new SimpleEmail();	 	//전송할 메일
		simpleEmail.setCharset("UTF-8");				
		simpleEmail.setDebug(true);
		simpleEmail.setHostName(hostName);					//보내는 서버 설정 = 고정
		simpleEmail.setAuthentication(emailAddr, passwd);	//보내는 사람 인증 = 고정
		simpleEmail.setSmtpPort(port);						//사용할 port = 고정
		simpleEmail.setStartTLSEnabled(true);				//인증방법 = 고정
		simpleEmail.setFrom(emailAddr, name);				//보내는 사람 메일, 보내는 사람 이름
		simpleEmail.addTo(email); 			//받는 사람 - 우리 사이트에 가입한 회원 메일
		simpleEmail.setSubject(mname + "! 하이헬로우안녕"); 	//제목
		simpleEmail.setMsg("인증번호는 [" + key + "] 입니다.");	//본문내용 text
		simpleEmail.send();
	}
	
	//인증번호 생성
	public String randomKey() {
		String key = "";
		/*
		 * for (int i = 0; i < 4; i++) { int num = (int)(Math.random()* 9 + 1); key +=
		 * num; }
		 */	
		Random r = new Random();
		r.setSeed(System.currentTimeMillis()); // 잠깐 홀드
		key = r.nextInt(10) + "" + r.nextInt(10) + r.nextInt(10) + r.nextInt(10);		
		return key;
	}
	
	//파일 업로드
	public String fileUpload(MultipartFile upFile) {
		
		//경로 저장
		String root = req().getSession().getServletContext().getRealPath("/");
		String upfilePath = root + "resources\\upfile\\";	
		
		//UUID뽑기 - 다른 메소드로 분리하면 더 좋음
		UUID uuid = UUID.randomUUID();
		String newFileName = uuid.toString() + "-" + upFile.getOriginalFilename();
		
		//파일 진짜 업로드
		File file = new File(upfilePath, newFileName);
		
		//경로가 없다면 만들어주기 - 508p 22.1.2
		if(file.exists() == false) {
			file.mkdir(); 			
		}
		
		try {			
			//썸네일 만들기
			FileOutputStream thumbnail = 
					new FileOutputStream(new File(upfilePath, "s_" + newFileName));
			Thumbnailator.createThumbnail(upFile.getInputStream(), thumbnail, 100, 100);
			thumbnail.close();
			
			//썸네일 생성뒤 업로드
			upFile.transferTo(file);
			
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return newFileName;
	}
	
}
