package org.nallume.dao;

import java.util.List;

import org.nallume.dto.NoticeDTO;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeDAO extends AbstractDAO{

	public List<NoticeDTO> noticeList(int pageNo) {
		return sqlSession.selectList("notice.noticeList", pageNo);
	}

	public NoticeDTO detail(int no) {
		return sqlSession.selectOne("notice.detail", no);
	}

	public int noticeWrite(NoticeDTO dto) {
		return sqlSession.insert("notice.noticeWrite", dto);
	}

	public int noticeDel(int no) {
		return sqlSession.update("notice.noticeDel", no);
	}

	public int noticeUpdate(NoticeDTO dto) {
		return sqlSession.update("notice.noticeUpdate", dto);
	}

	public int totalCount() {
		return sqlSession.selectOne("notice.totalCount");
	}

	
	
}
