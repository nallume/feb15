package org.nallume.controller;

import org.apache.commons.mail.EmailException;
import org.apache.ibatis.annotations.Param;
import org.nallume.dto.BoardDTO;
import org.nallume.service.BoardService;
import org.nallume.service.RestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RestFullController {
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private RestService restService;
	
	@PostMapping("/restDetail")
	public BoardDTO restDetail(@Param("no") int no) {
		System.out.println("restDetail : " + no);
		BoardDTO detail =  boardService.detail2(no);
		System.out.println(detail.getBoard_title());
		System.out.println(detail.getBoard_content());
		
		return detail;
	}
	
	@PostMapping("/emailAuth")
	public int emailAuth() throws EmailException {			
		return restService.sendEmail();
	}
}
