package org.nallume.dao;
//24-02-26
//부모형태로 존재하게 하겠습니다.
//@없어요

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

public class AbstractDAO {
	
	@Autowired
	SqlSession sqlSession;
}
