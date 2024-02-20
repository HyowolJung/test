package com.jmh.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.jmh.dto.BoardDto;
import com.jmh.service.BoardService;

@Controller
@RequestMapping("/board/comunity")
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@PostMapping("/home")
	public String home(@RequestParam int member_Id, Model model) {
		//System.out.println("community 도착 : " + member_Id);
		List<BoardDto> getFreeBoardList = boardService.getFreeBoardList();
		System.out.println("getFreeBoardList : " + getFreeBoardList);
		model.addAttribute("getFreeBoardList" , getFreeBoardList);
		model.addAttribute("member_Id" , member_Id);
		return "/board/comunity/home";
	}
	
	@PostMapping("/insert")
	public String insert(Model model, @RequestParam int member_Id, @ModelAttribute BoardDto boardForm) {
		//System.err.println("insert member_Id 도착 : " + member_Id);
		//System.out.println("Board_Title: " + boardForm.getBoard_Title());
        //System.out.println("Board_Content: " + boardForm.getBoard_Content());
        //System.out.println("Board_Type : " + boardForm.getBoard_Type());
        
		if(boardForm != null) {
			System.err.println("null이 아니에요.");
			
			int insertCnt = boardService.insertBoard(boardForm);
			if(insertCnt > 0) {
				System.err.println("글 등록 성공");
				return "/board/comunity/home";
			} else {
				System.err.println("글 등록 실패");
				return "/board/comunity/insert";
			}
			
		}
		
		if(boardForm == null) {
			return "";
		}
		
//		if (boardForm.getBoard_Title() != null || boardForm.getBoard_Content() != null || boardForm.getBoard_Type() != null) {
//			System.err.println("null이 아니에요.");
//			
//			int insertCnt = boardService.insertBoard(boardForm);
//			if(insertCnt > 0) {
//				System.err.println("글 등록 성공");
//				return "/board/comunity/home";
//			} else {
//				System.err.println("글 등록 실패");
//				return "/board/comunity/insert";
//			}
//		} 

		return "/board/comunity/insert";
	}
	
	@PostMapping("/boardList")
	public String boardList(Model model) {
		
		return "";
	}
}
