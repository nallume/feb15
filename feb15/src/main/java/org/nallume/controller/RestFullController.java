package org.nallume.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.mail.EmailException;
import org.apache.ibatis.annotations.Param;
import org.json.JSONObject;
import org.nallume.dto.BoardDTO;
import org.nallume.dto.SearchDTO;
import org.nallume.service.BoardService;
import org.nallume.service.RestService;
import org.nallume.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RestController
public class RestFullController{
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private RestService restService;
	
	@Autowired
	private Util util;
	
	@PostMapping("/restDetail")
	public BoardDTO restDetail(@Param("no") int no) {
		System.out.println("restDetail : " + no);
		BoardDTO detail =  boardService.detail2(no);
		System.out.println(detail.getBoard_title());
		System.out.println(detail.getBoard_content());
		
		return detail;
	}
	
	@PostMapping("/emailAuth")
	public int emailAuth() throws EmailException {			
		return restService.sendEmail();
	}
	
	/*
	@PostMapping("/idCheck")
	public String idCheck(HttpServletRequest request) {
	System.out.println(request.getParameter("id")); 
	return "redirect:/join"; 
	}
	 */

/*	ajax
	@PostMapping("/idCheck")
	public @ResponseBody String idCheck(@RequestParam("id") String id) {
	System.out.println(id);
	return "0"; 
	}
	*/ 

	//컨트롤러에 rest를 찍어줌으로써 body어쩌구를 안써줘도 된다고
	@PostMapping("/idCheck")
	public String idCheck(@RequestParam("id") String id) {
		int result = restService.idCheck(id);
		//return result + "";
		
		//{key : value, key2 : value, key3 : value}
		//{key : value, key2 : {a:b}}		
		//json = result : {count : 1 or 0 } 이렇게 찍힘
		
		//맵 사용시
		//Map<String, Object> resultMap = new HashMap<String, Object>();
		//resultMap.put("count", result);
		//return resultMap;
		
		//JsonObject 사용시
		JSONObject json = new JSONObject();
		json.put("count", result);

		return json.toString();
	}
	
	
	//게시판을 json으로 출력해주는 api
	@GetMapping("/jsonBoard")
	public String jsonBoard(@RequestParam(value = "pageNo", required = false) String no, 
			@RequestParam(value = "search", required = false) String search
			) {
		
		int currentPageNo = 1;
		if(util.str2Int2(no) > 0) {
			currentPageNo = Integer.parseInt(no);
		}
		
		//전체 글 수 뽑아오기 totalCount
		int totalRecordCount = boardService.totalCount(search);
		//System.out.println("전체 글 수 : " + totalRecordCount);
		
		//pagination
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(currentPageNo); //현재 페이지 번호
		paginationInfo.setRecordCountPerPage(10); //한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(10); //페이징 리스트의 사이즈 , 10페이지씩 보이기
		paginationInfo.setTotalRecordCount(totalRecordCount);//전체 게시물 건수
		
		SearchDTO searchDto = new SearchDTO();
		searchDto.setPageNo(paginationInfo.getFirstRecordIndex());
		searchDto.setSearch(search);
		
		List<BoardDTO> list = boardService.boardList(searchDto);
		
		//Json
		JSONObject jsonList = new JSONObject();
		jsonList.put("list", list);
		jsonList.put("paginationInfo", paginationInfo);
		jsonList.put("pageNo", no);
		
		return jsonList.toString();
	}
	
	
}
