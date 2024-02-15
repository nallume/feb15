package org.nallume.service;

import java.util.List;

import org.nallume.dao.MemberDAO;
import org.nallume.dto.MemberDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberService {

	@Autowired
	private MemberDAO memberDAO;
	
	public List<MemberDTO> memberList(){
		
		return memberDAO.memberList();
	}

	
}
