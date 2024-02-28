package org.nallume.dao;

import org.apache.ibatis.session.SqlSession;
import org.nallume.dto.LoginDTO;
import org.nallume.dto.MemberDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LoginDAO extends AbstractDAO {
	
	public LoginDTO login(LoginDTO dto) {
		return sqlSession.selectOne("login.login", dto);
	}

	public void mcountUp(LoginDTO dto) {
		sqlSession.update("login.mcountUp", dto);
	}

	public void mcountReset(LoginDTO loginDTO) {
		sqlSession.update("login.mcountReset", loginDTO);		
	}

	public int join(MemberDTO dto) {
		return sqlSession.insert("login.join", dto);
	}

}
