package com.jmh.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.jmh.dto.BoardDto;
import com.jmh.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@GetMapping("/home")
	public String home(Model model, HttpSession session) {
		List<BoardDto> getFreeBoardList = boardService.getFreeBoardList();
		//System.out.println("getFreeBoardList : " + getFreeBoardList);
		model.addAttribute("getFreeBoardList" , getFreeBoardList);
		model.addAttribute("member_Id", session.getAttribute("member_Id"));
		return "/board/comunity/home"; 
	}
	
	@PostMapping("/home")
	public String home(@RequestParam String member_Id, Model model, HttpSession session) {
		List<BoardDto> getFreeBoardList = boardService.getFreeBoardList();
		//System.out.println("getFreeBoardList : " + getFreeBoardList);
		model.addAttribute("getFreeBoardList" , getFreeBoardList);
		model.addAttribute("member_Id", session.getAttribute("member_Id"));
		return "/board/comunity/home";
	}
	
	@GetMapping("/comunity/insert")
	public String insert() {
		return "/board/comunity/insert";
	}
	
	
	@PostMapping("/comunity/insert")
	public String insert(Model model, @RequestParam int member_Id, @ModelAttribute BoardDto boardForm) {
		if (boardForm.getBoard_Title() != null || boardForm.getBoard_Content() != null || boardForm.getBoard_Type() != null) {
			System.err.println("null이 아니에요.");
			
			int insertCnt = boardService.insertBoard(boardForm);
			if(insertCnt > 0) {
				System.err.println("글 등록 성공");
				return "redirect:/board/comunity/home";
			} else {
				System.err.println("글 등록 실패");
				//return "/board/comunity/insert";
			}
		}
		
		if (boardForm.getBoard_Title() == null || boardForm.getBoard_Content() == null || boardForm.getBoard_Type() == null) {
			System.err.println("null입니다.");
			return "/board/comunity/insert";
		}

		return "/board/comunity/insert";
	}
	
	@PostMapping("/comunity/read")
	public String read2(Model model, String member_Id, String board_Title, HttpSession session) {
		System.err.println("POST) member_Id : " + member_Id + "/ board_Title : " + board_Title);
		List<BoardDto> selectFreeBoardList = boardService.selectFreeBoardList(board_Title);
		model.addAttribute("selectFreeBoardList" , selectFreeBoardList);
		//	List<BoardDto> selectFreeBoardList = boardService.selectFreeBoardList(board_Title);
		//	model.addAttribute("selectFreeBoardList" , selectFreeBoardList);
		System.err.println("selectFreeBoardList 1 : " + selectFreeBoardList);
		model.addAttribute("member_Id", session.getAttribute("member_Id"));
		return "/board/comunity/read";
	}
	
	@GetMapping("/comunity/read")
	public String read1(Model model, String member_Id, String board_Title, HttpSession session) {
		model.addAttribute("member_Id", session.getAttribute("member_Id"));
		List<BoardDto> selectFreeBoardList = boardService.selectFreeBoardList(board_Title);
		System.err.println("selectFreeBoardList 2 : " + selectFreeBoardList);
		model.addAttribute("selectFreeBoardList" , selectFreeBoardList);
		return "/board/comunity/read";
	}
}
