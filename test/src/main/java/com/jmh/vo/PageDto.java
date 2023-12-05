package com.jmh.vo;

import lombok.Data;

@Data
public class PageDto {
	
	private Criteria cri;	// 페이지번호, 페이지당 게시물수
	private int total;		// 총 게시물의 수
	
	private int startNo;	// 페이지 블록의 시작번호
	private int endNo;		// 페이지 블록의 끝번호
	
	private boolean prev, next;	// 이전, 다음 버튼 활성(true)/비활성(false) 
	
	//int realEnd;			// 페이지 끝번호
	
	public PageDto(Criteria cri, int total){
		this.cri = cri;
		this.total = total;
		
		// 페이지 블럭의 끝번호
		this.endNo = (int)(Math.ceil(cri.getPageNo()/5.0) * 5);
		// 페이지 블럭의 시작번호
		this.startNo = this.endNo - 4;
		
		// 총 게시물의 수를 페이지당 보여지는 게시물의 수로 나눠서 실제 끝페이지 번호를 구함
		int realEnd = (int)(Math.ceil((total*1.0)/cri.getAmount()));
		//endNo = endNo>realEnd ? realEnd : endNo;
		
		//prev = startNo > 1 ? true: false;
		//next = endNo == realEnd ? false: true;
	
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
