package org.nallume.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.nallume.service.BoardService;
import org.nallume.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	@Autowired
	private Util util;
	
	@GetMapping("/index")
	public String index() {
		return "index";
	}

	
	@GetMapping("/board")
	public String board(Model model) {
		model.addAttribute("list", boardService.boardList());
		return "board";
	}
	
	@GetMapping("/detail")
	public String detail(HttpServletRequest request, Model model) {
		int no = util.str2Int(request.getParameter("no"));
		Map<String, Object> map = boardService.detail(no);
		model.addAttribute("detail", map);
		return "detail";
	}

	@GetMapping("/detail2")
	public String detail2(HttpServletRequest request, Model model) {
		String no = request.getParameter("no");
		model.addAttribute("detail", boardService.detail2(no));
		return "detail";
	}
}
