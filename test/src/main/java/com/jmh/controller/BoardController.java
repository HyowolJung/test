package com.jmh.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jmh.service.BoardService;
import com.jmh.vo.BoardVO;

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
	
}