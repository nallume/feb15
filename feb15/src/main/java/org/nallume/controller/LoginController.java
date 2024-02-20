package org.nallume.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.nallume.dto.LoginDTO;
import org.nallume.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class LoginController {
	
	@Autowired
	LoginService loginService;
	
	@GetMapping("/login")
	public String login() {	
		return "login";
	}
	
	/*
	 * @GetMapping("/login") public void login() { }
	 */
	
	@PostMapping("/login")
	public String login(HttpServletRequest request) {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		//System.out.println("id : " + id + " /pw : " + pw);
		LoginDTO loginDTO = new LoginDTO();
		loginDTO.setId(id);
		loginDTO.setPw(pw);		
		LoginDTO login = loginService.login(loginDTO);
		
		if(login.getCount() == 1) {
			//세션 만들기
			HttpSession session = request.getSession();
			session.setAttribute("mid", id);
			session.setAttribute("mname", login.getMname());
			return "redirect:/index";
		}
		return "redirect:/login";
		
	}
	
	
	@GetMapping("/logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		if(session.getAttribute("mid") != null) {
			session.removeAttribute("mid");
		}
		if(session.getAttribute("mname") != null) {
			session.removeAttribute("mname"); //이것과
		}
		session.invalidate(); //요것 꼭 확인ㅇ하기
		
		return "redirect:/login";
	}
	
}
