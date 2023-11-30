package com.jmh.vo;

//VO, DTO 의 차이점
//생성자, OVERRIDE란?
public class BoardVO {
	private int BNO;
	private String BType;
	private String BTitle;
	private String BContent;
	
	@Override
	public String toString() {
		return "BoardVO [BNO=" + BNO + ", BType=" + BType + ", BTitle=" + BTitle + ", BContent=" + BContent + "]";
	}
	
	public BoardVO() {
		super();
	}
	
	public BoardVO(int bNO, String bType, String bTitle, String bContent) {
		super();
		BNO = bNO;
		BType = bType;
		BTitle = bTitle;
		BContent = bContent;
	}
	
	public int getBNO() {
		return BNO;
	}
	public void setBNO(int bNO) {
		BNO = bNO;
	}
	public String getBType() {
		return BType;
	}
	public void setBType(String bType) {
		BType = bType;
	}
	public String getBTitle() {
		return BTitle;
	}
	public void setBTitle(String bTitle) {
		BTitle = bTitle;
	}
	public String getBContent() {
		return BContent;
	}
	public void setBContent(String bContent) {
		BContent = bContent;
	}
	
	
	
	
}
