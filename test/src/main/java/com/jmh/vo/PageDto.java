package com.jmh.vo;

import lombok.Data;

@Data
public class PageDto {
	
	private Criteria cri;	
	private int total;		
	
	private int startNo;	
	private int endNo;		
	
	private boolean prev, next;	
	
	public PageDto(Criteria cri, int total){
		this.cri = cri;
		this.total = total;
		
		this.endNo = (int)(Math.ceil(cri.getPageNo()/5.0) * 5);
		this.startNo = this.endNo - 4;
		
		int realEnd = (int)(Math.ceil((total*1.0)/cri.getAmount()));
	
		if(realEnd < this.endNo) {
			this.endNo = realEnd;
		}
		
		this.prev = this.startNo > 1;
		this.next = this.endNo < realEnd;
	}

	@Override
	public String toString() {
		return "PageDTO [startNo=" + startNo + ", endNo=" + endNo + ", prev=" + prev + ", endNo=" + endNo + ", next="
				+ next + ", total=" + total + "]";
	}

	
}
