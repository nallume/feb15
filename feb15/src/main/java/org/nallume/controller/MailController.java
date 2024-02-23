package org.nallume.controller;

import org.apache.commons.mail.EmailException;
import org.nallume.service.MailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MailController {
	
	@Autowired
	private MailService mailService;
	
	@GetMapping("/mail")
	public String mail() {
		//로그인 한 사용자만 접근 가능
		return "mail";
	}
	
	//jsp에서 해당 내용물을 받아서(name으로 오는 것) 서비스로 보냄 -> 서비스에서 메일 발송
	@PostMapping("/mail")
	public String mail(@RequestParam("email") String email, 
			@RequestParam("title") String title, @RequestParam("content") String content) throws EmailException {
		//System.out.println("email : " + email);
		//System.out.println("title : " + title);
		//System.out.println("content : " + content);
		
		mailService.sendTextMail(email, title, content);
		mailService.sendHTMLMail(email, title, content);
		
		return "redirect:/mail";
	}
	
}
