package org.nallume.dao;

import java.util.List;
import org.nallume.dto.BoardDTO;
import org.nallume.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminDAO extends AbstractDAO {
	
	public List<BoardDTO> boardList() {
		return sqlSession.selectList("admin.boardList");
	}

}
