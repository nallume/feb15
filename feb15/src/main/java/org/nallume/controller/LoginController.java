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
	
	//24-02-28 어플리케이션 테스트 수행
	/*
	 스케치 - 와이어프레임 - 목업 - 프로토타입 - 스토리보드
	 
	 * 와이어프레임 : 기획 단계의 기초를 제작하는 단게. 페이지의 레이아웃이나 UI요소 등 뼈대
	 * 목업 : 와이어프레임보다 조금 더 설계 화면과 유사하게 만드는 것. 정적 모델링
	 * 프로토타입 : 다양한 인터렉션이 결합되어 실제 서비스처럼 동작하는 것.(클릭하면 넘어가게)
	 * 스토리보드 : 설명, 기능 명세서, 와이어프레임, 프로세스, 정책 등등 설계문서
	 
	 화면부터 구성해야(스케치) 뭐가 필요한지가 나옴
	 
	 */

	//아이디 = 중복검사
	//비밀번호 1 / 비밀번호 2
	//이메일 -> 중복불가
	//닉네임	
	@GetMapping("/join")
	public String join() {
		return "join";
	}
	
	@PostMapping("/join")
	public String join(HttpServletRequest request) {
		/*
		 * System.out.println(request.getParameter("id"));
		 * System.out.println(request.getParameter("pw"));
		 * System.out.println(request.getParameter("name"));
		 * System.out.println(request.getParameter("email"));
		 */
		
		MemberDTO dto = new MemberDTO();
		dto.setMid(request.getParameter("id"));
		dto.setMpw(request.getParameter("pw"));
		dto.setMname(request.getParameter("name"));
		dto.setMemail(request.getParameter("email"));
		
		int result = loginService.join(dto);
		System.out.println("결과 : " + result);
		return "redirect:/login";
	}	

	
	
}
