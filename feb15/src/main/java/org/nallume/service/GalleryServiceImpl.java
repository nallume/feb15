package org.nallume.service;

import java.util.List;

import org.nallume.dao.GalleryDAO;
import org.nallume.dto.GalleryDTO;
import org.nallume.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("galleryService")
public class GalleryServiceImpl extends AbstractService implements GalleryService{
	
	@Autowired
	private GalleryDAO galleryDao;
	
	public int galleryInsert(GalleryDTO dto) {
		//세션
		if(util.getSession().getAttribute("mid") != null) {
			dto.setMid((String)util.getSession().getAttribute("mid"));
			return galleryDao.galleryInsert(dto);
									
		} else {
			return 0;
		}
		
		
	}

	public List<GalleryDTO> galleryList() {
		List<GalleryDTO> list = galleryDao.galleryList();
		return list;
	}

	public GalleryDTO galleryDetail(int no) {
		GalleryDTO dto = galleryDao.galleryDetail(no);
		return dto;
	}

	public void galleryDel(int no) {
		galleryDao.galleryDel(no);
		
	}
}
