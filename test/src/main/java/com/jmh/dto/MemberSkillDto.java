package com.jmh.dto;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberSkillDto {
	private String memberPL1;	//Programing Languate : 프로그래밍 언어
	private String memberPL2;
	private String memberPL3;
	private String memberDB1;	//DataBase : 데이터베이스
	private String memberDB2;
	private String memberDB3;
	private String memberLic1;	//License : 자격증
	private String memberLic2;
	private String memberLic3;
}
