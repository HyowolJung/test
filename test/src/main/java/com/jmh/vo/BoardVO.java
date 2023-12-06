package com.jmh.vo;

import lombok.Data;

//VO, DTO �� ������
//������, OVERRIDE��?
@Data
public class BoardVO {
	private int BNO;
	private String BType;
	private String BTitle;
	private String BContent;
}
