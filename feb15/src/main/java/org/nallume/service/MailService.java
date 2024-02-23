package org.nallume.service;

import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.apache.commons.mail.SimpleEmail;
import org.springframework.stereotype.Service;

@Service
public class MailService {
	
	//메일 보내기 - text
	public void sendTextMail(String email, String title, String content) throws EmailException {
		
		String emailAddr = ""; // 보내는 사람 = outlook
		String pw = ""; //보내는 사람 pw = outlook
		String name = "yujin"; //보내는 사람 이름
		String host = "smtp-mail.outlook.com"; //아웃룩 호스트
		int port = 587; //아웃룩 포트
		
		SimpleEmail mail = new SimpleEmail();
		mail.setCharset("UTF-8"); //언어셋
		mail.setDebug(true);  //디버그
		mail.setHostName(host); // 호스트 = 아웃룩
		mail.setAuthentication(emailAddr, pw); //보내는 사람 메일, 비번
		mail.setSmtpPort(port); // 보내는 포트
		mail.setStartTLSEnabled(true); //인증방법 (아웃룩 시스템상 인증 필요)
		mail.setFrom(emailAddr, name); // 보내는 사람 주소, 이름
		
		//받는 사람 정보 = 파라미터로 
		mail.addTo(email); //받는 사람 메일 주소
		mail.setSubject(title); //제목
		mail.setMsg(content);  // 내용
		mail.send(); // 발송
		
	}

	public void sendHTMLMail(String email, String title, String content) throws EmailException {
		//접속정보 동일
		String emailAddr = ""; // 보내는 사람 = outlook
		String pw = ""; //보내는 사람 pw = outlook
		String name = "yujin"; //보내는 사람 이름
		String host = "smtp-mail.outlook.com"; //아웃룩 호스트
		int port = 587; //아웃룩 포트
		
		//클래스만 다름
		HtmlEmail mail = new HtmlEmail();
		mail.setCharset("UTF-8"); //언어셋
		mail.setDebug(true);  //디버그
		mail.setHostName(host); // 호스트 = 아웃룩
		mail.setAuthentication(emailAddr, pw); //보내는 사람 메일, 비번
		mail.setSmtpPort(port); // 보내는 포트
		mail.setStartTLSEnabled(true); //인증방법 (아웃룩 시스템상 인증 필요)
		mail.setFrom(emailAddr, name); // 보내는 사람 주소, 이름
		
		//받는 사람 정보 = 파라미터로 
		mail.addTo(email); //받는 사람 메일 주소
		mail.setSubject(title); //제목
		mail.setMsg(content);  // 내용
		
		//파일첨부도 가능
		EmailAttachment file = new EmailAttachment();
		file.setPath("c:\\temp\\img.png"); // 이 주소의 파일을 file에 담아
		mail.attach(file);		
		
		mail.send(); // 발송
		
	}
	
}
