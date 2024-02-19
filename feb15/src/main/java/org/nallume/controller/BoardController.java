package org.nallume.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.nallume.dto.BoardDTO;
import org.nallume.dto.CommentDTO;
import org.nallume.dto.WriteDTO;
import org.nallume.service.BoardService;
import org.nallume.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	
	@GetMapping("/detail2")
	public String detail(HttpServletRequest request, Model model) {
		int no = util.str2Int(request.getParameter("no"));
		Map<String, Object> map = boardService.detail(no);
		model.addAttribute("detail", map);
		return "detail";
	}

	@GetMapping("/detail")
	public String detail2(@RequestParam(value = "no", defaultValue = "10", required = true) String no, Model model) {   //spring이 알아서 int타입에 맞게 형변환 해줌
		//String no = request.getParameter("no");
		//System.out.println(util.str2Int2(no));
		
		if(util.str2Int2(no) != 0) {
			//0이 아님 = 정상 : db에 물어보기 / 값 가져오기 / 붙이기 / 이동하기
			BoardDTO detail = boardService.detail2(util.str2Int2(no));
			model.addAttribute("detail", detail);
			//System.out.println("여기까진");
			
			//24-02-19  댓글 출력
			System.out.println("댓글 수 : "+ detail.getComment());
			if (detail.getComment() > 0) {
				List<CommentDTO> commentsList = boardService.commentsList(util.str2Int2(no));
				model.addAttribute("commentsList", commentsList);
				//System.out.println(commentsList.get(0).getMid());
			}
			
			return "detail";
			
			
		} else {
			//0이야 = 비정상 : 에러로 페이지 이동하기
			//return "error/error"; //에러폴더/error.jsp
			return "redirect:/error"; //controller에 있는 ("/error") mapping을 실행해라 - 만들라는 소리
		}	
	}
	
	//글쓰기 (24-02-16)  : 내용 + 제목 받아 -> db로 보내 -> 저장 -> 그 뒤에? 보드로 돌아가기 내가 쓴 글로 넘어가는것도 괜찮은데 동적쿼리를 써야함 - 나중에..
	@PostMapping("/write")
	//public String write(@Param("title") String title, @Param("content") String content) {
	public String write(WriteDTO dto) {
		
		int result = boardService.write(dto);  // 1 or 0
		
		//추가로 세션 관련 작업 더 필요함
		if (result == 1) {
			return "redirect:/detail?no="+dto.getBoard_no();			
		} else {
			return "redirect:/error";
		}
		
	}
	
	//댓글쓰기 24-02-19 
	@PostMapping("/commentWrite")
	public String commentWrite(CommentDTO comment) {
		int result = boardService.commentWrite(comment);
		System.out.println("결과 : " + result);
		return "redirect:/detail?no="+comment.getNo();
	}
	
	
}
