package org.nallume.controller;

import java.util.List;

import javax.annotation.Resource;

import org.nallume.dto.NoticeDTO;
import org.nallume.service.NoticeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class NoticeController {
	
	@Resource(name="NoticeService")
	private NoticeService noticeService;
	
	@GetMapping("/notice")
	public String notice(Model model) {
		List<NoticeDTO> list = noticeService.noticeList();
		model.addAttribute("list", list);
		return "notice";
	}
	
	
	@GetMapping("/ndetail")
	public String ndetail(@RequestParam("no") int no, Model model) {
		NoticeDTO dto = noticeService.detail(no);
		model.addAttribute("detail", dto);
		return "ndetail?no="+no;
	}
}
