package org.nallume.service;

import java.util.List;

import org.nallume.dao.AdminDAO;
import org.nallume.dto.BoardDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminService extends AbstractService{
	
	@Autowired
	AdminDAO adminDao;
	
	public List<BoardDTO> boardList() {
		return adminDao.boardList();
	}

}
