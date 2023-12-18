package com.jmh.controller;

import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.javassist.expr.NewArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jmh.dto.Criteria;
import com.jmh.dto.MemberDto;
import com.jmh.dto.PageDto;
import com.jmh.dto.ProjectDto;
import com.jmh.mapper.MemberMapper;
import com.jmh.service.MemberService;

//ResoponseBody , RequestBody 
//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
//RequestParam, param, pathVaraiable
//엑셀 깔자
//★유효성 검사 구현에 집중★
//1. sql 쿼리문 줄 조정 + 대문자로
//2. 다양하게
//3. 타일즈?
//권한번호(관리자, 사원)에 따라 보여줘야 하는 사이드바에 있는 메뉴(바디)가 다를때, 
//1. 세션에 저장해서 동적쿼리(권한아이디=#{01})를 이용하거나, 
//2. jsp 페이지에 jstl(c:if when)을 이용하지말고 
//다른 방법을 찾아 구현해보세요.
@Controller
@RequestMapping("/member")
public class MemberController {
	//변수
	//						선언위치		선언타입					특징
	//지역(Local)변수			메서드 안
	//전역(Global)변수			메서드 밖
	//기본(Primitive)변수					Int, String, Boolean	리터럴(Literal)이 저장됨(stack에 실제값이 저장됨)
	//참조형(Reference)변수				new						주소값이 저장됨(heap에 실제값이, stack에 주소값이 저장됨)
	
	//기본형(primitive) 변수
	//int number = 1;
		
	//참조형(reference) 변수
	//BoardVO vo = new BoardVO();
	//vo.setB_NO(1);
	//int bno = vo.getB_NO();
	//System.out.println("bno : " + bno);
	
	@Autowired	//의존성 주입
	private MemberService memberService;
	
	//1. 조회(페이징 정보)
	@GetMapping("/memberList")	//parameter 와 argument의 차이
	public String memberList1(Model model, Criteria cri) {
		int totalCnt = memberService.getTotalCnt(cri);
		PageDto pageDto = new PageDto(cri, totalCnt);
		System.out.println("GET)pageDto.cri.searchWord : " + pageDto.cri.getSearchWord());
		System.out.println("GET)pageDto : " + pageDto);
		model.addAttribute("pageDto", pageDto);
		return "member/memberList";	//뷰를 반환합니다.(뷰의 위치) - 메서드 타입이 String 이므로.
	}
	
	//1. 조회(회원 정보)
	@PostMapping("/memberList")
	@ResponseBody
	public List<MemberDto> memberList2(Model model, Criteria cri, String search_ck) {
		System.out.println("도착1");
		System.out.println("POST) searchWord : " + cri.getSearchWord());
		List<MemberDto> memberList = memberService.getmemberList(cri); 
		//1. 검색어 없이 조회 버튼을 클릭한 경우
		if(search_ck != null && cri.getSearchWord() == null || cri.getSearchWord().equals("")) {	//조건 없이 조회 버튼만 누른 경우.
			System.err.println("검색어 없는 조회");
			int totalCnt = memberService.getTotalCnt(cri);
			PageDto pageDto = new PageDto(cri, totalCnt);
			memberList = memberService.getmemberList(cri);
			//model.addAttribute("memberList", memberList);
			model.addAttribute("totalCnt" , totalCnt);
			model.addAttribute("pageDto" , pageDto);
			return memberList;
		}
		//2. 검색어 있고 조회 버튼을 클릭한 경우
		else if(search_ck != null && cri.getSearchWord() != null) {
//			System.err.println("검색어 있는 조회");
//			memberList = memberService.searchmemberList(cri);
			System.err.println("검색어 있는 조회");
			int totalCnt = memberService.getTotalCnt(cri);
			PageDto pageDto = new PageDto(cri, totalCnt);
			memberList = memberService.searchmemberList(cri);
			//model.addAttribute("memberList", memberList);
			model.addAttribute("totalCnt" , totalCnt);
			model.addAttribute("pageDto" , pageDto);
			return memberList;
		}
		return memberList;	
	}
	
	//2. 등록(페이지 이동)
	@GetMapping("/memberInsert")
	public String memberInsert() {
				
		return "member/memberInsert";
	}
	
	//2. 등록(아이디 체크)
	@GetMapping("/memberInsert_ck")
	@ResponseBody
	public ResponseEntity<Boolean> insertMember_ck(String member_Tel) {
		boolean result = true;
		System.out.println("result : " + result);
		
		if(member_Tel.trim().isEmpty()) {
			result = false;
			System.out.println("result : " + result);
		}else {
			if(memberService.selectId(member_Tel)) {
				System.out.println("memberService.selectId1(member_Tel : " + memberService.selectId(member_Tel));
				result = true;
				
			}else {
				System.out.println("memberService.selectId2(member_Tel : " + memberService.selectId(member_Tel));
				result = false;
			}
		}
		
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	//2. 등록(회원 등록)
	@PostMapping("/memberInsert")
	public String insertMember(@RequestBody MemberDto insertDatas) {
		System.out.println("insertDatas.getMember_startDate : " + insertDatas.getMember_Name());
		System.out.println("insertDatas.getMember_startDate : " + insertDatas.getMember_startDate());
		
		int insertCnt = memberService.insertMember(insertDatas);
		if(insertCnt > 0) {
			System.out.println("등록성공");
			return "member/memberList";
		}else {
			System.out.println("실패");
			return "";
		}
	}
	
	//3. 수정(페이지 이동 + 회원 정보 조회)
	@GetMapping("/memberModify")
	public String modifyMember(@RequestParam("member_Id") int member_Id, Model model) { /*@RequestParam int bno*/
		System.out.println("수정 화면 작동");
		model.addAttribute("memberList" ,memberService.getModifyList(member_Id));
		return "member/memberModify";
	}
	
	//3. 수정(회원 정보 수정)
	@PostMapping("/memberModify")
	public ResponseEntity<Boolean> memberModify(@RequestBody MemberDto modifyDatas) {
		String member_Tel = modifyDatas.getMember_Tel();	//jsp 에서 보내온 전화번호
		int member_Id = modifyDatas.getMember_Id();		//jsp 에서 보내온 아이디
		//int member_Id_ck = memberService.getmemberId(member_Id);
		
//		if(member_Id == member_Id_ck && member_Tel == ) {
//			
//		}
	
		
		//1. 원래 내 번호가 아닌데 바꾸고자 하는 번호가 중복되지 않은 경우
		//2. 원래 내 번호가 아닌데 바꾸고자 하는 번호가 중복된 경우
			//예외적 허용: 내 번호인데 바꾸고자 하는 번호가 내 번호일 경우
		int member_Tel_ck = memberService.member_Tel_ck(member_Tel, member_Id);	//바꾸고자 하는 번호가 원래 내 번호인지 아닌지
		boolean result = false;
		
		System.out.println("member_Tel_ck : " + member_Tel_ck);
		if(member_Tel_ck > 0) {  //수정하고자 하는 번호가 내 번호야.
			System.out.println("내 번호가 맞아");
			int modifyCnt = memberService.memberModify(modifyDatas);
			if(modifyCnt > 0) {
				System.out.println("수정 성공1");
				result = true;
			}else if(modifyCnt < 0 ) {
				System.out.println("수정 실패1");
				result = false;
			}
		}else if(member_Tel_ck <= 0) {	//수정하고자 하는 번호가 내 번호가 아니야.
			System.out.println("내 번호가 아니야");
			int modifyCnt = memberService.memberModify(modifyDatas);
			if(modifyCnt > 0) {
				System.out.println("수정 성공2");
				result = true;
			}else if(modifyCnt < 0) {
				System.out.println("수정 실패2");
				result = false;
			}
		}
		
		
		
		//1-1. member_Tel_ck 가 1 이면 수정하고자 하는 사람이 가진 원래 번호이므로 중복되는 번호여도 수정이 되야함(원래 내가 가진 번호니까)
//		if(member_Tel_ck <= 0) {
//			System.out.println("2");
//			int modifyCnt = memberService.memberModify(modifyDatas);
//			if(modifyCnt > 0) {
//				System.out.println("3");
//				result = true;
//			}
//		}
//		//1-2. member_Tel_ck 가 0 이면 수정하고자 하는 사람이 가지지 않은 번호이므로 중복되면 수정이 되지 말아야함(원래 내 번호와 다른데 바꾸고자 하는 번호가 겹치면 다른사람번호니까)
//		System.out.println("member_Tel_ck : " + member_Tel_ck);
//		
//		if(member_Tel_ck >= 0) {
//			System.out.println("1");
//			result = false;
//		}
		
//		if(member_Tel_ck <= 0) {
//			System.out.println("2");
//			int modifyCnt = memberService.memberModify(modifyDatas);
//			if(modifyCnt > 0) {
//				System.out.println("3");
//				result = true;
//			}
//		}
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	//4. 삭제(회원 정보 삭제)
	@GetMapping("/memberDelete")
	public String memberDelete(@RequestParam int member_Id) {
		int deleteCnt = memberService.deleteMember(member_Id);
		
		if(deleteCnt > 0) {
			return "member/memberList";
		}else {
			return "";
		}
	}
	
	@GetMapping("/memberRead")
	public List<ProjectDto> memberRead(Model model, @RequestParam int member_Id) {
		//HashMap<String, Object> member_projectList = memberService.getmemberprojectList(member_Id);
		List<ProjectDto> member_projectList = memberService.getmemberprojectList(member_Id);
		System.out.println("member_projectList : " + member_projectList);
		System.out.println("memberService.getModifyList(member_Id) : " + memberService.getModifyList(member_Id));
		//model.addAttribute("member_projectList", memberService.getmemberprojectList(member_Id));
		model.addAttribute("memberprojectList" , member_projectList);
		model.addAttribute("memberList" ,memberService.getModifyList(member_Id));
		return member_projectList;
	}

}