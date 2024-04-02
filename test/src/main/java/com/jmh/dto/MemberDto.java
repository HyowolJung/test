package com.jmh.dto;


import java.time.LocalDate;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

//VO, DTO 의 차이점
//VO : 
//1. Read-Only(getter)
//2. equals() + hashCode() 를 overriding
//3. 도메인의 복잡성과 불변성 

//DTO : Client <-> Controller <-> Service <-> Repository
//1. getter/setter , 
//2. 데이터의 전달과 변환
@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberDto {
	private String memberPL1;	//Programing Languate : 프로그래밍 언어
	private String memberPL2;
	private String memberPL3;
	private String memberDB1;	//DataBase : 데이터베이스
	private String memberDB2;
	private String memberDB3;
	private String memberLic1;	//License : 자격증
	private String memberLic2;
	private String memberLic3;
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
	private String memberRo;		//memberResponsibilities of office					직책
	
	//private String memberStDay;
	//private String memberLaDay;
	@JsonFormat(pattern = "yyyy-MM-dd")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate memberStDay;	//memberStartDay	입사일
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate memberLaDay;	//memberLastDay	퇴사일
	
//	private int pageNo;
//	private int searchCnt;
//	private String memberStatus;
//	private String choiceValue;
//	private int member_No;
//	private String member_Pw;
//	private int member_Id;
//	private String member_Name;
//	private String member_Sex;
//	private String member_Position;
//	private String member_Img;
//	private String member_Tel;
//	private String member_Skill_Language;
//	private String member_Skill_DB;
//	private ProjectDetailDto projectDetail;
//	private String member_Department;
//	private String member_Authority; 
//	private String member_Enabled;
//	
//	//@DateTimeFormat(pattern = "yy/MM/dd")
//	//@PastOrPresent
//	//RequestBody로 Json을 바인딩 받을때는 @JsonFormat을 사용한다!
//	@JsonFormat(pattern = "yyyy-MM-dd")
//	@DateTimeFormat(pattern = "yyyy-MM-dd")
//	private LocalDate member_startDate;
//	
//	@JsonFormat(pattern = "yyyy-MM-dd")
//	@DateTimeFormat(pattern = "yyyy-MM-dd")
//	private LocalDate member_endDate;
//	
//	private String member_status;
//	
//	private int member_endDate_ck;
	//Date : 자바 8 이전에 다루던 날짜 관련 타입이다. (+Calenar) 
	//따라서 해당 타입은 deprecated 이다. (+java.util.Date)
	//LocalDateTime, LocalDate, LocalTime : 자바 8 이후에 등장한 날짜 관련 타입이다. 	
	//★★어떤 경우에 HH:MM:SS 생략할 수 있는지 확인해야함!!
	
	//LocalDateTime : yyyy-MM-dd HH:mm:ss
	//LocalDate : yyyy-MM-dd
}
