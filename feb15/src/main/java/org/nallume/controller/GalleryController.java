package org.nallume.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.nallume.dto.GalleryDTO;
import org.nallume.service.GalleryService;
import org.nallume.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ImportResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class GalleryController {
	
	@Resource(name="galleryService")
	private GalleryService galleryService;
	
	@Autowired
	private Util util;
	
	@GetMapping("/gallery")
	public String gallery(Model model) {
		List<GalleryDTO> list = galleryService.galleryList();
		model.addAttribute("list", list);
		return "gallery";
	}
	
	@GetMapping("/galleryInsert")
	public String galleryInsert() {		
		if(util.getSession().getAttribute("mid") != null) {
			return "galleryInsert";			
		}
		return "redirect:/login";
	}

	@PostMapping("/galleryInsert")
	public String galleryInsert(@RequestParam("file1") MultipartFile file, GalleryDTO dto) {
		//dto.setGtitle(title);
		//dto.setGcontent(content); 
		//dto랑 jsp의 name값을 일치시키면 알아서 dto가 잡아옴
		
		System.out.println(dto.getGtitle());
		System.out.println(dto.getGcontent());
		System.out.println(file.getOriginalFilename());
		
		if(util.getSession().getAttribute("mid") != null) {
			//파일 업로드 -> util		
			String newFileName = util.fileUpload(file);
			dto.setGfile(newFileName);
			int result = galleryService.galleryInsert(dto);
			return "redirect:/gallery";	
		}
		return "redirect:/error";
		
	}
	
	//24-02-26 요구사항 확인
	@GetMapping("/galleryDetail@{no}")
	public String galleryDetail(@PathVariable("no") String no, Model model) {
		int gno = util.str2Int2(no);
		GalleryDTO detail = new GalleryDTO();
		detail = galleryService.galleryDetail(gno);
		model.addAttribute("detail", detail);
		return "galleryDetail";
	}
	
	//갤러리 글지우기
	@PostMapping("/galleryDel")
	public String galleryDel(@RequestParam("no") String no){
		galleryService.galleryDel(util.str2Int2(no));
		return "redirect:/gallery";
	}
	
	//좋아요
	@PostMapping("/galleryLike@{no}")
	public String galleryLike(@PathVariable("no") String no) {
		return "redirect:/galleryDetail@"+no;
	}
	
}
