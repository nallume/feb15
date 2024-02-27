package org.nallume.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.nallume.dto.NoticeDTO;
import org.nallume.service.NoticeService;
import org.nallume.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class NoticeController {
	
	@Autowired
	private Util util;
	
	@Resource(name="NoticeService")
	private NoticeService noticeService;
	
	//24-02-27 요구사항 확인
	@GetMapping("/notice")
	public String notice(@RequestParam(value = "pageNo", required = false) String no, Model model) {
		//페이징
		int currentPageNo = 1;
		if(util.str2Int2(no) > 0) {
			currentPageNo = Integer.parseInt(no);
		}
		int totalRecordCount = noticeService.totalCount();
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(currentPageNo);
		paginationInfo.setRecordCountPerPage(10);
		paginationInfo.setPageSize(10);
		paginationInfo.setTotalRecordCount(totalRecordCount);		
		
		List<NoticeDTO> list = noticeService.noticeList(paginationInfo.getFirstRecordIndex());
		model.addAttribute("list", list);
		model.addAttribute("paginationInfo", paginationInfo);
		return "notice";
	}	
	
	@GetMapping("/noticeDetail")
	public String ndetail(@RequestParam(value = "no", defaultValue = "0", required = true) int no, Model model) {
		if(no == 0) { // 들어오는 파라미터를 검사
			return "redirect:/error";
		} else {
			NoticeDTO dto = noticeService.detail(no);
			//나갈 데이터를 검사
			if(dto.getNno() == 0) {
				return "redirect:/error";				
			} else {
				dto.setMname("farmer");
				model.addAttribute("detail", dto);
				return "noticeDetail";				
			}
		}
	}
	
	//공지 글쓰기 -> admin관리자 화면에서
	@GetMapping("/admin/noticeWrite")
	public String noticeWrite() {
		return "admin/noticeWrite"; //  /views/admin/noticeWrite.jsp
	}
	
	@PostMapping("/admin/noticeWrite")
	public String noticeWrite(NoticeDTO dto) {
		
		 if(util.getSession().getAttribute("mid") == null) { 
			 return "redirect:/login";
		 } 
		 dto.setMid("farmer");
		 
		 if(util.getSession().getAttribute("mid").equals(dto.getMid())) { 
			 int result = noticeService.noticeWrite(dto);
			 if(result == 1) { 
				 return "redirect:/notice"; 
			 } 
			 return "redirect:/error"; 
		}
		return "redirect:/error";
				
	}
	
	@GetMapping("/noticeDel@{no}")
	public String noticeDel(@PathVariable("no") int no) {
		System.out.println("parthVariable : " + no);
		noticeService.noticeDel(no);
		return "redirect:/notice";
	}
	
	@PostMapping("/noticeDel")
	public String noticeDel(@RequestParam("no") String no) {
		noticeService.noticeDel(util.str2Int2(no));
		return "redirect:/notice";
	}
	
	@PostMapping("/noticeUpdate")
	public String noticeUpdate(NoticeDTO dto) {
		int result = noticeService.noticeUpdate(dto);
		if(result == 1) {
			return "redirect:/noticeDetail?no=" + dto.getNno();			
		}
		return "redirect:/error";			
	}
	
	
}
