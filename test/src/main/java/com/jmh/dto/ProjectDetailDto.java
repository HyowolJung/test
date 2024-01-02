package com.jmh.dto;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProjectDetailDto {
	private int member_Id;
	private int project_Id;
	private int project_No;
	private String project_Name;
	private LocalDate pushDate;
	private LocalDate pullDate;
}
