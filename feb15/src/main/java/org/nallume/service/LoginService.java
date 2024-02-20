package org.nallume.service;

import org.nallume.dao.LoginDAO;
import org.nallume.dto.LoginDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginService {
	
	@Autowired
	private LoginDAO loginDao;
	
	public LoginDTO login(LoginDTO dto) {
		return loginDao.login(dto);
	}
	
}