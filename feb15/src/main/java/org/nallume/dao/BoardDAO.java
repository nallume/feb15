package org.nallume.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.nallume.dto.BoardDTO;
import org.nallume.dto.CommentDTO;
import org.nallume.dto.WriteDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<BoardDTO> boardList(int pageNo){
		return sqlSession.selectList("board.boardList", pageNo);
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

	public int postDel(int no) {
		return sqlSession.update("board.postDel", no);
	}

	public int totalCount() {
		return sqlSession.selectOne("board.totalCount");
	}
	
}
