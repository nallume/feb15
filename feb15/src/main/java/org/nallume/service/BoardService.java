package org.nallume.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.nallume.dao.BoardDAO;
import org.nallume.dto.BoardDTO;
import org.nallume.dto.CommentDTO;
import org.nallume.dto.WriteDTO;
import org.nallume.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardService {

	@Autowired
	private BoardDAO boardDAO;
	
	@Autowired
	private Util util;
	
	public List<BoardDTO> boardList(int PageNo){		
		return boardDAO.boardList(PageNo);
	}
	
	public Map<String, Object> detail(int no) {
		return boardDAO.detail(no);
	}

	public BoardDTO detail2(int no) {
		//24-02-21 로그인 여부 검사 => 읽음 수 올리기
		if(util.getSession().getAttribute("mid") != null ) {
			//DTO 객체 만들기 = 번호 + 아이디
			BoardDTO dto = new BoardDTO();
			dto.setBoard_no(no);
			dto.setMid((String) util.getSession().getAttribute("mid"));
			//int result = boardDAO.readCheck(dto);
			//if(result == 0) { //읽은 적 있는지 묻기
				boardDAO.countUp(dto);				
			//}
		}		
		return boardDAO.detail2(no);
	}
	
	

	public int write(WriteDTO dto) {
		//HttpServletRequest request = util.req();
		HttpSession session = util.getSession();
		dto.setMid((String)session.getAttribute("mid"));
		//dto.setMid((String)util.getSession().getAttribute("mid")); 한줄 버전
		dto.setIp(util.getIP());
		//줄바꿈 적용
		dto.setContent(dto.getContent().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "<br>"));
		return boardDAO.write(dto);
	}

	public int commentWrite(CommentDTO comment) {
		// 댓글 내용 + 글번호에 mid 추가
		comment.setMid((String) util.getSession().getAttribute("mid"));
		comment.setCip(util.getIP());
		return boardDAO.commentWrite(comment);
	}

	public List<CommentDTO> commentsList(int no) {
		return boardDAO.commentsList(no);
	}

	public int postDel(int no) { //글번호 + mid = 자신의 글만 삭제하게 하기 위해서
		WriteDTO dto = new WriteDTO();
		dto.setBoard_no(no);
		dto.setMid((String) util.getSession().getAttribute("mid"));
		return boardDAO.postDel(dto);
	}

	public int totalCount() {
		return boardDAO.totalCount();
	}

	public int deleteComment(int no, int cno) {
		CommentDTO dto = new CommentDTO();
		dto.setBoard_no(no);
		dto.setNo(cno);
		dto.setMid((String) util.getSession().getAttribute("mid"));
		return boardDAO.deleteComment(dto);
	}

	public int likeUp(CommentDTO dto) {
		return boardDAO.likeUp(dto);
	}


	
}
