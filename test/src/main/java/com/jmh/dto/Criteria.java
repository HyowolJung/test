package com.jmh.dto;

import lombok.Data;

@Data
public class Criteria {
	
	private String searchField; 
	private String searchWord;	
	
	private int pageNo = 1;		
	private int amount = 10; 	
	private int startNo = 1;
	private int endNo = 10;
	
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
		if(pageNo>0) {
			endNo = pageNo * amount;
			startNo = pageNo * amount - (amount-1);
		}
	}
}
