package org.nallume.service;

import org.apache.commons.mail.EmailException;
import org.nallume.dao.RestDAO;
import org.nallume.dto.MemberDTO;
import org.nallume.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RestService extends AbstractService{
	
	@Autowired
	RestDAO restDao;
	
	public int sendEmail() throws EmailException {
		if(util.getSession().getAttribute("mid") != null) {
			//메일 발송 + key 데이터에 저장
			String mname = (String) util.getSession().getAttribute("mname");
			String email = getEmail((String)util.getSession().getAttribute("mid"));
			String key = util.randomKey();
			MemberDTO dto = new MemberDTO();
			dto.setMid((String) util.getSession().getAttribute("mid"));
			dto.setMemail(email);
			dto.setMkey(key);
			restDao.setKey(dto); //db에 키 저장
			//util.sendEmail(mname, email, key);	
			return 1;
		} else {
			return 0;			
		}
	}
	
	public String getEmail(String id) {
		return restDao.getEmail(id);
	}

	public int idCheck(String id) {
		return restDao.idCheck(id);
	}
	
}
