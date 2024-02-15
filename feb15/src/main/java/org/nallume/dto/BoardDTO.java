package org.nallume.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardDTO {
	private int board_no, board_count, comment, board_del;
	private String board_title, mname, board_content, board_date, board_ip;
}
