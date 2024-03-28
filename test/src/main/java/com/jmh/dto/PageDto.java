package com.jmh.dto;

import lombok.Data;

@Data
public class PageDto {
	
	public Criteria cri;	
	public int total;		
	
	public int startNo;	
	public int endNo;		
	
	public boolean prev, next;	
	
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
