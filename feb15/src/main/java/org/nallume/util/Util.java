package org.nallume.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@Component
public class Util {
	public int str2Int(String str) {
		int num = 0;
		String strChange;	
		strChange = str.replaceAll("[^0-9]", "");
		num = Integer.parseInt(strChange);
		
		return num; 
	}
	
	public int str2Int2(String str) {
		try {
			return Integer.parseInt(str);
		} catch (Exception e) {
			return 0;
		}
	}
	
	//2024-02-21 psd 웹표준
	//서블릿리퀘스트
	public HttpServletRequest req() {
		ServletRequestAttributes sra = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpServletRequest request = sra.getRequest();
		return request;
	}
	//세션
	public HttpSession getSession() {
		HttpSession session = req().getSession();
		return session;
		//return req().getSession();
	}
	
	//ip
	public String getIP() {
		HttpServletRequest request = req();
		String ip = request.getHeader("X-FORWARDED-FOR");
        if(ip == null) {
           ip = request.getHeader("Proxy-Client-IP");
        }
        if(ip == null) {
           ip = request.getHeader("WL-Proxy-Client-IP");   
        }
        if(ip == null) {
           ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if(ip == null) {
           ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if(ip == null) {
           ip = request.getRemoteAddr();
        }
        return ip;
	}
	
	// html태그를 특수기호로 변경하기 < &lt > &gt
	public static String removeTag(String str) {

		str = str.replaceAll("<", "&lt");
		str = str.replaceAll(">", "&gt");

		return str;
	}

}
