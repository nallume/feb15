package org.nallume.service;

import java.util.List;

import org.nallume.dto.GalleryDTO;

public interface GalleryService {
	
	public int galleryInsert(GalleryDTO dto);
	
	public List<GalleryDTO> galleryList();
	
	public GalleryDTO galleryDetail(int no);
	
	public void galleryDel(int no);
	
}
