package org.nallume.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberDTO {
	private int mno, mgrade;
	private String mid, mpw, mname, mdate, memail, mkey;
}
