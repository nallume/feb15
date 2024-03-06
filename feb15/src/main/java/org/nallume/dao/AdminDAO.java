package org.nallume.dao;

import java.util.List;
import org.nallume.dto.BoardDTO;
import org.nallume.dto.SearchDTO;
import org.nallume.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminDAO extends AbstractDAO {
	
	public List<BoardDTO> boardList(SearchDTO searchDTO) {
		return sqlSession.selectList("admin.boardList", searchDTO);
	}

	public int totalRecordCount(SearchDTO searchDTO) {
		return sqlSession.selectOne("admin.totalRecordCount", searchDTO);
	}

	public int postDel(int no) {
		return sqlSession.update("admin.postDel", no);
	}

	public BoardDTO detail(int no) {
		return sqlSession.selectOne("admin.detail", no);
	}

}
