package org.nallume.util;

import org.springframework.stereotype.Component;

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
	
}
