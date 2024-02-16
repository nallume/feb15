package org.nallume.dto;

import lombok.Getter;
import lombok.Setter;

//글쓰기 할 때 사용할 DTO
@Getter
@Setter
public class WriteDTO {
	private String title, content, mid;
	private int board_no;
}
