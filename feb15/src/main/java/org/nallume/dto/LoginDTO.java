package org.nallume.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LoginDTO {
	private int count;
	private String id, pw, mname;
}
