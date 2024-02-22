package org.nallume.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

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

	
	//페이징 추가하기 24-02-20
	@GetMapping("/board")
	public String board(@RequestParam(value = "pageNo", required = false) String no, Model model) {
		//pageNo가 오지 않는다면
		int currentPageNo = 1;
		if(util.str2Int2(no) > 0) { //여기 수정해야해
			currentPageNo = Integer.parseInt(no);
		}
		
		//전체 글 수 뽑아오기 totalCount
		int totalRecordCount = boardService.totalCount();
		//System.out.println("전체 글 수 : " + totalRecordCount);
		
		//pagination
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(currentPageNo); //현재 페이지 번호
		paginationInfo.setRecordCountPerPage(10); //한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(10); //페이징 리스트의 사이즈 , 10페이지씩 보이기
		paginationInfo.setTotalRecordCount(totalRecordCount);//전체 게시물 건수
		
		List<BoardDTO> list = boardService.boardList(paginationInfo.getFirstRecordIndex()); //첫번째 페이지 번호 가져오는 메소드
		model.addAttribute("list", list);
		//페이징 관련 정보가 있는 PaginationInfo객체를 모델에 반드시 넣어준다.
		model.addAttribute("paginationInfo", paginationInfo);
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
			
			//24-02-19  댓글 출력 추가
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
		//세션추가 24-02-20
		int result = boardService.write(dto);  // 1 or 0
		
		//추가로 세션 관련 작업 더 필요함
		//로그인 여부 검사 24-02-21
		if(util.getSession().getAttribute("mid") != null) {
			if (result == 1) {
				return "redirect:/detail?no="+dto.getBoard_no();			
			} else {
				return "redirect:/error";
			}			
		} else {
			return "redirect:/login?error='error'";			
		}
		
	}
	
	//get방식 접근 막기
	@GetMapping("/write")
	public String write() {
		return "redirect:/login?error='2048'";	
	}
	
	
	
	//댓글쓰기 24-02-19 
	@PostMapping("/commentWrite")
	public String commentWrite(CommentDTO comment/* , HttpServletRequest request */) {
		//HttpSession session = request.getSession();
		//comment.setMid((String)session.getAttribute("mid"));
		
		//로그인 여부 검사
		if(util.getSession().getAttribute("mid") != null) {
			int result = boardService.commentWrite(comment);
			if(result ==1) {
				//System.out.println("결과 : " + result);
				return "redirect:/detail?no="+comment.getNo();				
			}
			return "redirect:/error";
		}
		return "redirect:/login";

	}
	
	//글삭제
	@PostMapping("/postDel")
	public String postDel(@RequestParam("no") int no) {
		//System.out.println("no : " + no);
		
		//24-02-21 로그인 여부 검사
		if(util.getSession().getAttribute("mid") != null) {
			//로그인 했을 때
			int result = boardService.postDel(no);
			if(result == 1) {
				return "redirect:/board";				
			}
			return "redirect:/index";
			
		} else {
			return "redirect:/login";			
		}
	}
	
	//댓삭 - 댓글 번호 + 작성자 mid + 글번호
	@GetMapping("/deleteComment")
	public String deleteComment(@RequestParam("no") int no, @RequestParam("cno") int cno) {
		//System.out.println("no : "+no);		
		int result = boardService.deleteComment(no, cno);
		if(util.getSession().getAttribute("mid") != null) {
			if(result == 1) {
				//return "redirect:/board";				
				return "redirect:/detail?no="+no;
			}
			return "redirect:/error";								
		}
		return "redirect:/login";
	}
	
	//24-02-21 요구사항 확인
	@GetMapping("/likeUp")
	public String likeUp(@RequestParam("no") String no, @RequestParam("cno") String cno) {
		//no, cno 숫자인지 검사
		if(util.intCheck(no) && util.intCheck(cno)) {
			CommentDTO dto = new CommentDTO();
			dto.setBoard_no(util.str2Int2(no));
			dto.setNo(util.str2Int2(cno));
			dto.setMid((String) util.getSession().getAttribute("mid"));
			int result = boardService.likeUp(dto);
			return "redirect:/detail?no="+no;
		} else {
			return "redirect:/error";			
		}
		
		
	}
	
	
	
	
	
	
	
}
