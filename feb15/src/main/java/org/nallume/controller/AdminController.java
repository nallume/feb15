package org.nallume.controller;

import java.util.List;

import javax.annotation.Resource;

import org.nallume.dto.BoardDTO;
import org.nallume.dto.SearchDTO;
import org.nallume.service.AdminService;
import org.nallume.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestMapping("/admin")
public class AdminController {
//administrator = admin
//root
	
	@Resource(name="adminService")
	private AdminService adminService;
	
	@Autowired
	Util util;

	
	@GetMapping("/") //얘는 경로  localhost/admin
	public String index() {
		return "admin/index";  //얘는 폴더
	}

	@GetMapping("/index") //얘는 경로  localhost/admin
	public String index2() {
		return "admin/index";  //얘는 폴더
	}
	
	@GetMapping("/login") //localhost/admin/login
	public String login() {
		return "admin/login";
	}

	@GetMapping("/join") //localhost/admin/join
	public String join() {
		return "admin/join";
	}
	
	@GetMapping("/board")
	public String board(@RequestParam(name = "pageNo", defaultValue = "1") String pageNo, 
			@RequestParam(name = "search", required = false) String search, 
			@RequestParam(name = "perPage", defaultValue = "1", required = false) String perPage, 
			@RequestParam(name = "searchTitle", required = false) String searchTitle, 
			Model model) {
		//페이징 + 검색 + 한 화면에 보이는 게시글 수 변경
		
		//검색
		SearchDTO searchDTO = new SearchDTO();
		searchDTO.setSearch(search);
		searchDTO.setSearchTitle(util.str2Int2(searchTitle));
		
		//전체 글 수 뽑기
		int totalRecordCount = adminService.totalRecordCount(searchDTO);
		
		//페이징
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(util.str2Int2(pageNo));
		paginationInfo.setPageSize(10);
		paginationInfo.setRecordCountPerPage(util.str2Int2(perPage) * 10); // 1 -> 10
		paginationInfo.setTotalRecordCount(totalRecordCount);
		
		//검색 페이징 설정
		searchDTO.setPageNo(paginationInfo.getFirstRecordIndex());
		searchDTO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		
		List<BoardDTO> list = adminService.boardList(searchDTO);
		model.addAttribute("list", list);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("perPage", perPage);
		model.addAttribute("search", search);
		model.addAttribute("searchTitle", searchTitle);
		model.addAttribute("active", "board");
		return "admin/board";
	}
	
	
	
	
	@GetMapping("/comment")
	public String comment(Model model) {
		model.addAttribute("active", "board");
		return "admin/comment";
	}

	@GetMapping("/member")
	public String member(Model model) {
		model.addAttribute("active", "member");
		return "admin/member";
	}
	
	
	@GetMapping("/postDel")
	public String postDel(@RequestParam("no") String no, 
			@RequestParam(name = "pageNo", defaultValue = "1") String pageNo, 
			@RequestParam(name = "search", required = false) String search, 
			@RequestParam(name = "perPage", defaultValue = "1", required = false) String perPage, 
			@RequestParam(name = "searchTitle", required = false) String searchTitle ) {
		int result = adminService.postDel(util.str2Int2(no));
		//검색어 (search)가 한글이면 오류난당 --ajax로 하는 수밖에...
		//return "redirect:/admin/board?pageNo="+pageNo+"&perPage="+perPage+"&searchTitle="+searchTitle+"&search="+search;
		return "redirect:/admin/board";
	}
	
	@PostMapping("/postDel")
	public @ResponseBody String postDel(@RequestParam("no") String no) {
		int result = adminService.postDel(util.str2Int2(no));
		
		if (result == 1) {
			return "1"; // 삭제 성공 시 "1" 반환
		} else {
		    return "0"; // 삭제 실패 시 "0" 반환
		}
	}
	
	@GetMapping("/detail")
	public String detail(@RequestParam("no") String no, Model model) {
		BoardDTO dto = adminService.detail(util.str2Int2(no));
		model.addAttribute("detail", dto);
		return "admin/detail";
	}
	
}
