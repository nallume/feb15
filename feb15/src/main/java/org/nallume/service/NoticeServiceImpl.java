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
	
	public List<NoticeDTO> noticeList() {
		List<NoticeDTO> list = noticeDao.noticeList();
		return list;
	}

	public NoticeDTO detail(int no) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int noticeWrite(NoticeDTO dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int noticeDel(int no) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int noticeUpdate(NoticeDTO dto) {
		// TODO Auto-generated method stub
		return 0;
	}

}
