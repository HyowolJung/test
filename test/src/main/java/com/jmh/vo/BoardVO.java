package com.jmh.vo;

import lombok.Data;

//VO, DTO 의 차이점
//생성자, OVERRIDE란?
@Data
public class BoardVO {
	private int BNO;
	private String BType;
	private String BTitle;
	private String BContent;
	private int numberSearch;
	
}
