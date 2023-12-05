package com.jmh.vo;

import lombok.Data;

@Data
public class Criteria {
	
	//private String searchField; // 검색조건
	//private String searchWord;	// 검색어
	
	private int pageNo = 1;		// 요청 페이지 번호
	private int amount = 10; 	// 한페이지당 게시물수
	private int startNo = 1;
	private int endNo = 10;
	
	
//	public Criteria(int pageNo, int amount) {
//		this.pageNo = pageNo;
//		this.amount = amount;
//	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
		if(pageNo>0) {
			endNo = pageNo * amount;
			startNo = pageNo * amount - (amount-1);
		}
	}
	
//	@Override
//	public String toString() {
//		return "Criteria [pageNo=" + pageNo + ", amount=" + amount + "]";
//	}
	
}
