package org.nallume.service;

import java.util.List;

import org.nallume.dto.NoticeDTO;

public interface NoticeService {
	
	public List<NoticeDTO> noticeList();

	public NoticeDTO detail(int no);

	public int noticeWrite(NoticeDTO dto);

	public int noticeDel(int no);

	public int noticeUpdate(NoticeDTO dto);
}
