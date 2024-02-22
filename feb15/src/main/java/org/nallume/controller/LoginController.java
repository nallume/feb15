package org.nallume.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;
import org.nallume.dto.LoginDTO;
import org.nallume.dto.MemberDTO;
import org.nallume.service.LoginService;
import org.nallume.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class LoginController {
	
	@Autowired
	LoginService loginService;
	@Autowired
	private Util util;
	
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
			if(login.getPw().equals(loginDTO.getPw()) && login.getMcount() < 5) {				
				//세션 만들기
				HttpSession session = request.getSession();
				session.setAttribute("mid", id);
				session.setAttribute("mname", login.getMname());
				//해당 id의 mcount를 0으로 만들기
				loginService.mcountReset(loginDTO);
				return "redirect:/index?login=1010";
			} else {
				//잘못된 로그인 5번 시도했으면 잠그기
				//해당 id의 mcount를 +1 시키기
				loginService.mcountUp(loginDTO);
				return "redirect:/login?count="+login.getMcount();				
			}			
		} else {			
			return "redirect:/login?login=1024";
		}
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
	
	@GetMapping("/myInfo@{id}") // 경로변수
	public String myInfo(@PathVariable("id") String id) throws EmailException {
		//System.out.println("id : " + id);		
		//로그인 여부 검사
		if(util.getSession().getAttribute("mid") != null) {	
			//인증요청 - ajax용으로 빼두기
			//loginService.myInfo();				
			return "myInfo";
		} else {
			return "redirect:/login?error=error";
		}
		
	}
	
	
}
