package com.jmh.dto;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Criteria {
	
	private String searchField; 
	private String searchWord;
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate searchStDay;
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate searchLaDay;
	
	private String choiceValue = null;
	private int pageNo = 1;		
	private int amount = 5; 	
	private int startNo = 1;
	private int endNo = 10;
	
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
		if(pageNo>0) {
			endNo = pageNo * amount;
			startNo = pageNo * amount - (amount-1);
		}
	}
	
	public void setAmount(int amount) {
	    this.amount = amount;
	    this.endNo = this.pageNo * amount;
	    this.startNo = this.endNo - amount + 1;
	}
}
