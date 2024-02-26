package org.nallume.dao;

import java.util.List;

import org.nallume.dto.NoticeDTO;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeDAO extends AbstractDAO{

	public List<NoticeDTO> noticeList() {
		return sqlSession.selectList("notice.noticeList");
	}

}
