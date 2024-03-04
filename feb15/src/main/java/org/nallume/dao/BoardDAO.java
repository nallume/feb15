package org.nallume.dao;

import java.util.List;
import java.util.Map;

import org.nallume.dto.BoardDTO;
import org.nallume.dto.CommentDTO;
import org.nallume.dto.SearchDTO;
import org.nallume.dto.WriteDTO;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAO extends AbstractDAO{
	
	public List<BoardDTO> boardList(SearchDTO searchDto){
		return sqlSession.selectList("board.boardList", searchDto);
	}
	
	public Map<String, Object> detail(int no) {
		return sqlSession.selectOne("board.detail", no);
	}
	
	public BoardDTO detail2(int no) {
		return sqlSession.selectOne("board.detail2", no);
	}

	public int write(WriteDTO dto) {
		return sqlSession.insert("board.write", dto);
	}

	public int commentWrite(CommentDTO comment) {
		return sqlSession.insert("board.commentWrite", comment);
	}

	public List<CommentDTO> commentsList(int no) {	
		return sqlSession.selectList("board.commentsList", no);
	}

	public int postDel(WriteDTO dto) {
		return sqlSession.update("board.postDel", dto);
	}

	public int totalCount(String search) {
		return sqlSession.selectOne("board.totalCount", search);
	}

	public int deleteComment(CommentDTO dto) {		
		return sqlSession.update("board.deleteComment", dto);
	}

	public void countUp(BoardDTO dto) {
		sqlSession.insert("board.countUP", dto);
	}

	public int likeUp(CommentDTO dto) {
		return sqlSession.insert("board.likeUp", dto);
	}

	public int detailUpdate(BoardDTO dto) {
		return sqlSession.update("board.update", dto);
	}

/*	public int readCheck(BoardDTO dto) {
		return sqlSession.selectOne("board.readCheck", dto);
	}*/
	
}
