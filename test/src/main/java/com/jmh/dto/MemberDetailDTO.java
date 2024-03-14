package com.jmh.dto;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberDetailDTO {
	private String memberId;		//memberId				아이디
	private String memberPw;		//memberPassword		비밀번호
	private String memberGn;		//memberGender			성별
	private String memberName;	//memberName			이름
	private String memberEmail;	//memberEmail			이메일
	private String memberTel;		//memberTel				전화번호
	private String memberSt;		//memberStatus			상태
	private String memberPos;	//memberPosition		직급
	private String memberDept;	//memberDepartment	부서
	private String memberTeam;	//memberTeam			팀
	private String memberAuth;	//memberAuthority		권한
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate memberStDay;	//memberStartDay	입사일
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate memberLaDay;	//memberLastDay	퇴사일
}