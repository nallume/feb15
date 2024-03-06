package org.nallume.service;

import java.util.List;

import org.nallume.dto.BoardDTO;
import org.nallume.dto.SearchDTO;

public interface AdminService {

	List<BoardDTO> boardList(SearchDTO searchDTO);

	int totalRecordCount(SearchDTO searchDTO);

	int postDel(int no);

	BoardDTO detail(int str2Int2);

}
