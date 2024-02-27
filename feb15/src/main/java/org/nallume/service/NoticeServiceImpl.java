package org.nallume.service;

import java.util.List;

import org.nallume.dao.NoticeDAO;
import org.nallume.dto.NoticeDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("NoticeService")
public class NoticeServiceImpl extends AbstractService implements NoticeService{
	
	@Autowired
	private NoticeDAO noticeDao;
	
	public List<NoticeDTO> noticeList(int pageNo) {
		List<NoticeDTO> list = noticeDao.noticeList(pageNo);
		return list;
	}

	public NoticeDTO detail(int no) {
		NoticeDTO dto = noticeDao.detail(no);
		return dto;
	}

	public int noticeWrite(NoticeDTO dto) {
		return noticeDao.noticeWrite(dto);
	}

	public int noticeDel(int no) {
		return noticeDao.noticeDel(no);
	}

	public int noticeUpdate(NoticeDTO dto) {
		return noticeDao.noticeUpdate(dto);
	}

	@Override
	public int totalCount() {
		return noticeDao.totalCount();
	}
	
	

}
