package org.nallume.service;

import java.util.List;

import org.nallume.dao.AdminDAO;
import org.nallume.dto.BoardDTO;
import org.nallume.dto.SearchDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("adminService")
public class AdminServiceImpl extends AbstractService implements AdminService {
	
	@Autowired
	private AdminDAO adminDAO;

	@Override
	public List<BoardDTO> boardList(SearchDTO searchDTO) {
		List<BoardDTO> list = adminDAO.boardList(searchDTO);
		return list;
	}

	@Override
	public int totalRecordCount(SearchDTO searchDTO) {
		return adminDAO.totalRecordCount(searchDTO);
	}

	@Override
	public int postDel(int no) {
		return adminDAO.postDel(no);
	}

	@Override
	public BoardDTO detail(int no) {
		return adminDAO.detail(no);
	}

}
