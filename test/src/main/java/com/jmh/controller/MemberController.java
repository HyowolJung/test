package com.jmh.controller;

import java.sql.Date;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;
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

import com.jmh.mapper.MemberMapper;
import com.jmh.service.MemberService;
import com.jmh.vo.memberVO;
import com.jmh.vo.Criteria;
import com.jmh.vo.PageDto;

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
	//argument & parameter
	//변수
	//						선언위치		선언타입					특징
	//지역(Local)변수			메서드 안
	//전역(Global)변수			메서드 밖
	//기본(Primitive)변수					Int, String, Boolean	리터럴(Literal)이 저장됨(stack에 실제값이 저장됨)
	//참조형(Reference)변수					new						주소값이 저장됨(heap에 실제값이, stack에 주소값이 저장됨)
	
	
	@Autowired	//의존성 주입
	private MemberService memberService;
	
	
	//1. 조회
	@GetMapping("/memberList")
	public String memberList1(Model model, Criteria cri, String search_ck, String searchWord) {
		System.out.println("도착1");
		if(search_ck != null) {	//조건 없이 조회 버튼만 누른 경우.
			//System.err.println("검색어 없는 조회");
			List<memberVO> memberList = memberService.getmemberList(cri); 
			//System.out.println("뭐지");
			int totalCnt = memberService.getTotalCnt(cri);
			PageDto pageDto = new PageDto(cri, totalCnt);
			//System.out.println("왜 반응이 없어");
			model.addAttribute("pageDto", pageDto);
			model.addAttribute("totalCnt", totalCnt);
			model.addAttribute("memberList", memberList);
			System.out.println(memberList.size());
			//System.out.println("제발좀..");
			return "member/memberList";
		}else if(searchWord != null) {
			System.err.println("검색어 있는 조회");
		}
		return "member/memberList";	//뷰를 반환합니다.(뷰의 위치)
	}
	
	@PostMapping("/memberList")
	public String memberList2(Model model, Criteria cri, String search_ck, String searchWord) {
		System.out.println("도착1");
		if(search_ck != null) {	//조건 없이 조회 버튼만 누른 경우.
			System.err.println("검색어 없는 조회");
			List<memberVO> memberList = memberService.getmemberList(cri); 
			System.out.println("뭐지");
			int totalCnt = memberService.getTotalCnt(cri);
			PageDto pageDto = new PageDto(cri, totalCnt);
			System.out.println("왜 반응이 없어");
			model.addAttribute("pageDto", pageDto);
			model.addAttribute("totalCnt", totalCnt);
			model.addAttribute("memberList", memberList);
			System.out.println(memberList.size());
			System.out.println("제발좀..");
			return "member/memberList";
		}else if(searchWord != null) {
			System.err.println("검색어 있는 조회");
		}
		return "member/memberList";	//뷰를 반환합니다.(뷰의 위치)
	}
	
	//2. 등록
	@GetMapping("/memberInsert")
	public String memberInsert() {
				
		return "member/memberInsert";
	}
	
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
	
//	@GetMapping("/insertMember_ck")
//	public String insertMember_ck() {
//		
//		return "memeber/insertMember";
//	}
	
	@PostMapping("/memberInsert")
	public String insertMember(@RequestBody memberVO insertDatas) {
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
	
	@GetMapping("/memberDelete")
	public String memberDelete(@RequestParam String member_Id) {
		int deleteCnt = memberService.deleteMember(member_Id);
		
		if(deleteCnt > 0) {
			return "member/memberList";
		}else {
			return "";
		}
	}
	
	@GetMapping("/memberModify")
	public String modifyMember(@RequestParam("member_Id") String member_Id, Model model) { /*@RequestParam int bno*/
		model.addAttribute("memberList" ,memberService.getModifyList(member_Id));
		return "member/memberModify";
	}
	
	@PostMapping("/memberModify")
	public ResponseEntity<Boolean> memberModify(@RequestBody memberVO modifyDatas) {
		String member_Tel = modifyDatas.getMember_Tel();
		System.out.println("member_Tel : " + member_Tel);
		
		int member_Tel_ck = memberService.member_Tel_ck(member_Tel);
		System.out.println("member_Tel_ck : " + member_Tel_ck);
		
		boolean result = false;
		if(member_Tel_ck >= 0) {
			System.out.println("1");
			result = false;
		}
		
		if(member_Tel_ck <= 0) {
			System.out.println("2");
			int modifyCnt = memberService.memberModify(modifyDatas);
			if(modifyCnt > 0) {
				System.out.println("3");
				result = true;
			}
		}
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	//기본형(primitive) 변수
	//int number = 1;
	
	//참조형(reference) 변수
	//BoardVO vo = new BoardVO();
	//vo.setB_NO(1);
	//int bno = vo.getB_NO();
	//System.out.println("bno : " + bno);
	
//	@GetMapping("/deleteB")
//	public String deleteB(@RequestParam int checkNum) {
//		int deleteCnt = boardService.delete(checkNum);
//		
//		if(deleteCnt > 0) {
//			System.out.println("���� ����");
//			return "board/boardList";
//		}else {
//			System.out.println("���� ����");
//			return "";
//		}
//	}

}