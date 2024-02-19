package org.nallume.controller;

import org.apache.ibatis.annotations.Param;
import org.nallume.dto.BoardDTO;
import org.nallume.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class RestController {
	
	@Autowired
	private BoardService boardService;
	
	@PostMapping("/restDetail")
	public @ResponseBody BoardDTO restDetail(@Param("no") int no) {
		System.out.println("restDetail : " + no);
		BoardDTO detail =  boardService.detail2(no);
		System.out.println(detail.getBoard_title());
		System.out.println(detail.getBoard_content());
		
		return detail;
	}
}
