package org.nallume.controller;

import org.nallume.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping("/member")
	public String board(Model model) {
		model.addAttribute("list", memberService.memberList());
		return "member";
	}
}
