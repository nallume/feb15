package org.nallume.controller;

import java.util.List;

import org.nallume.dto.BoardDTO;
import org.nallume.dto.SearchDTO;
import org.nallume.service.AdminService;
import org.nallume.service.BoardService;
import org.nallume.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestMapping("/admin")
public class AdminController {
//administrator = admin
//root
	
	@Autowired
	AdminService adminService;

	
	@GetMapping("/") //얘는 경로  localhost/admin
	public String index() {
		return "admin/index";  //얘는 폴더
	}

	@GetMapping("/index") //얘는 경로  localhost/admin
	public String index2() {
		return "admin/index";  //얘는 폴더
	}
	
	@GetMapping("/login") //localhost/admin/login
	public String login() {
		return "admin/login";
	}

	@GetMapping("/join") //localhost/admin/join
	public String join() {
		return "admin/join";
	}
	
	@GetMapping("/boardList")
	public String boardList(Model model) {		
		List<BoardDTO> list = adminService.boardList();
		model.addAttribute("list", list);
		return "admin/boardList";
	}
	@GetMapping("/commentList")
	public String commentList() {
		return "admin/commentList";
	}

	@GetMapping("/memberList")
	public String memberList() {
		return "admin/memberList";
	}
}
