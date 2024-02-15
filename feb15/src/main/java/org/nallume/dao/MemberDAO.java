package org.nallume.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.nallume.dto.MemberDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<MemberDTO> memberList() {		
		return sqlSession.selectList("member.memberList");
	}
	
}
