package com.jmh.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jmh.service.BoardService;
import com.jmh.vo.BoardVO;

//ResoponseBody , RequestBody 언제 , 어떻게 , 왜 써야 하는 가
//RequestParam, param, pathVaraiable
//@RequestMapping(value = "createB" , method=RequestMethod.POST)
//엑셀 넣으면 자동적용
@Controller
@RequestMapping("/board")
public class BoardController {
	//argument & parameter
	
	//변수
	//						선언위치		선언타입					특징
	//지역(Local)변수			메서드 안
	//전역(Global)변수			메서드 밖
	//기본(Primitive)변수					Int, String, Boolean	리터럴(Literal)이 저장됨(stack에 실제값이 저장됨)
	//참조형(Reference)변수					new						주소값이 저장됨(heap에 실제값이, stack에 주소값이 저장됨)
	
	
	@Autowired	//뭘까요?
	private BoardService boardService; //전역변수
	
	//@RequestMapping("/board")
	@GetMapping("/boardList")
	public String BoardList(Model model) {
		System.out.println("실행");
		List<BoardVO> boardList = boardService.getBoardList(); //지역변수 / List, LinkedList, ArrayList 
		model.addAttribute("boardList", boardList);
		
		return "board/boardList";	//뷰를 반환합니다.(뷰의 위치)
	}
	
	//기본형(primitive) 변수
	//int number = 1;
	
	//참조형(reference) 변수
	//BoardVO vo = new BoardVO();
	//vo.setB_NO(1);
	//int bno = vo.getB_NO();
	//System.out.println("bno : " + bno);
	
	@GetMapping("/deleteB")
	public String deleteB(@RequestParam int checkNum) {
		System.out.println("checkNum 의 값은?! = " + checkNum);
		int deleteCnt = boardService.delete(checkNum);
		
		if(deleteCnt > 0) {
			System.out.println("삭제 성공");
			return "board/boardList";
		}else {
			System.out.println("삭제 실패");
			return "";
		}
	}
	
	@GetMapping("/createB")
	public String createB1() {
		return "board/boardWrite";
	}
	
	@PostMapping("/createB")
	@ResponseBody
	public String createB(BoardVO datas) {
		System.out.println("메서드 실행시작");
		System.out.println("datas : " + datas);
		
		String BType = datas.getBType();
		String BTitle = datas.getBTitle();
		String BContent = datas.getBContent();
		
		System.out.println("BType : " + BType);
		System.out.println("BTitle : " + BTitle);
		System.out.println("BContent : " + BContent);
		
		int insertCnt = boardService.insertB(BType, BTitle, BContent);
		if(insertCnt > 0) {
			System.out.println("삽입 성공");
			return "board/boardList";
		}else {
			System.out.println("삽입 실패");
			return "";
		}
	}
	
	@GetMapping("/modifyB")
	//@ResponseBody //리턴에 의한 페이지 이동 무효화
	public String modifyB(@RequestParam int checkNum, Model model) {
		System.out.println("메서드 실행시작");
		System.out.println("checkNum : " + checkNum);
		//int checkNum = 1;
		List<BoardVO> boardList = boardService.getModifyList(checkNum);
		System.out.println("여기!");
		model.addAttribute("boardList" , boardList);
		System.out.println("여기!2");
		//response.setContentType("text/html");
		
		return "board/boardModify";
	}
	
//	@GetMapping("/modifyB")
//	//@ResponseBody 리턴에 의한 페이지 이동 무효화
//	public String modifyB(@RequestParam int checkNum,  Model model) {
//		System.out.println("메서드 실행시작");
//		System.out.println("checkNum : " + checkNum);
//	
//		List<BoardVO> boardList = boardService.getModifyList(checkNum);
//		model.addAttribute("boardList" , boardList);
//		
//		return "board/boardModify";
//	}
	
	@PostMapping("/modifyB")
	public String modifyB() {
		
		return "board/boardList";
	}
}