package org.nallume.service;

import org.nallume.dao.LoginDAO;
import org.nallume.dto.LoginDTO;
import org.nallume.dto.MemberDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginService {
	
	@Autowired
	private LoginDAO loginDao;
	
	public LoginDTO login(LoginDTO dto) {
		return loginDao.login(dto);
	}

	public void mcountUp(LoginDTO dto) {
		loginDao.mcountUp(dto);
	}

	public void mcountReset(LoginDTO loginDTO) {
		loginDao.mcountReset(loginDTO);
	}

	public int join(MemberDTO dto) {
		return loginDao.join(dto);
	}

	
}
