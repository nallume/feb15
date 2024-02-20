package org.nallume.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.nallume.dao.BoardDAO;
import org.nallume.dto.BoardDTO;
import org.nallume.dto.CommentDTO;
import org.nallume.dto.WriteDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardService {

	@Autowired
	private BoardDAO boardDAO;
	
	public List<BoardDTO> boardList(int PageNo){		
		return boardDAO.boardList(PageNo);
	}
	
	public Map<String, Object> detail(int no) {
		return boardDAO.detail(no);
	}

	public BoardDTO detail2(int no) {
		return boardDAO.detail2(no);
	}

	public int write(WriteDTO dto, HttpServletRequest request) {
		HttpSession session = request.getSession();
		dto.setMid((String)session.getAttribute("mid"));
		return boardDAO.write(dto);
	}

	public int commentWrite(CommentDTO comment) {
		//comment.setMid("newbe");
		return boardDAO.commentWrite(comment);
	}

	public List<CommentDTO> commentsList(int no) {
		return boardDAO.commentsList(no);
	}

	public int postDel(int no) {
		return boardDAO.postDel(no);
	}

	public int totalCount() {
		return boardDAO.totalCount();
	}

	
}
