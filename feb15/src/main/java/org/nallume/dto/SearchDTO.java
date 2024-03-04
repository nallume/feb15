package org.nallume.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SearchDTO {
	private int pageNo, recordCountPerPage, searchTitle;
	private String search;
}
