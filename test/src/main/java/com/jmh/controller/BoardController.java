package com.jmh.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
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

import com.jmh.mapper.BoardMapper;
import com.jmh.service.BoardService;
import com.jmh.vo.BoardVO;
import com.jmh.vo.Criteria;
import com.jmh.vo.PageDto;

//ResoponseBody , RequestBody ���� , ��� , �� ��� �ϴ� ��
//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
//RequestParam, param, pathVaraiable
//@RequestMapping(value = "createB" , method=RequestMethod.POST)
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
@RequestMapping("/board")
public class BoardController {
	//argument & parameter
	//변수
	//						선언위치		선언타입					특징
	//지역(Local)변수			메서드 안
	//전역(Global)변수			메서드 밖
	//기본(Primitive)변수					Int, String, Boolean	리터럴(Literal)이 저장됨(stack에 실제값이 저장됨)
	//참조형(Reference)변수					new						주소값이 저장됨(heap에 실제값이, stack에 주소값이 저장됨)
	
	
	@Autowired	//�����?
	private BoardService boardService; //��������
	
	@GetMapping("/boardList")
	public String BoardList(Model model, Criteria cri) {
		//System.out.println("cri.numberSearch : " +  cri.getNumberSearch());
		//String getNumberSearch = cri.getNumberSearch();
		System.out.println("도착1");
		List<BoardVO> boardList = boardService.getBoardList(cri); 
		int totalCnt = boardService.getTotalCnt(cri);
		PageDto pageDto = new PageDto(cri, totalCnt);
		//System.out.println("2");
		model.addAttribute("pageDto", pageDto);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("boardList", boardList);
		//System.out.println("3");
		
		model.addAttribute("boardList", boardList);
		return "board/boardList";	//뷰를 반환합니다.(뷰의 위치)
	}
	
	@GetMapping("/boardList2")
	public String BoardList2(Model model, Criteria cri) {
		System.out.println("도착2");
		List<BoardVO> boardList2 = boardService.getBoardList(cri);
		//int totalCnt = boardService.getTotalCnt(cri);
		//PageDto pageDto = new PageDto(cri, totalCnt);
		
		//model.addAttribute("pageDto", pageDto);
		//model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("boardList2", boardList2);
		return "board/boardList";
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
		int deleteCnt = boardService.delete(checkNum);
		
		if(deleteCnt > 0) {
			System.out.println("���� ����");
			return "board/boardList";
		}else {
			System.out.println("���� ����");
			return "";
		}
	}
	
	@GetMapping("/createB")
	public String createB1() {
		return "board/boardWrite";
	}
	
	@PostMapping("/createB")
	//@ResponseBody
	public String insertB(BoardVO datas) {
		System.out.println("�޼��� �������");
		System.out.println("datas : " + datas);
		
		String BType = datas.getBType();
		String BTitle = datas.getBTitle();
		String BContent = datas.getBContent();
		
		//System.out.println("BType : " + BType);
		//System.out.println("BTitle : " + BTitle);
		//System.out.println("BContent : " + BContent);
		
		int insertCnt = boardService.insertB(BType, BTitle, BContent);
		if(insertCnt > 0) {
			System.out.println("���� ����");
			return "board/boardList";
		}else {
			System.out.println("���� ����");
			return "";
		}
	}
	
	@GetMapping("/modifyB")
	public String modifyB(@RequestParam("bno") int bno, Model model) { /*@RequestParam int bno*/
		model.addAttribute("boardList" ,boardService.getModifyList(bno));
		return "board/boardModify";
	}
	
	@PostMapping("/modifyB")
	public String modifyB(BoardVO datas) {
		int BNO = datas.getBNO();
		String BType = datas.getBType();
		String BTitle = datas.getBTitle();
		String BContent = datas.getBContent();
		
		int modifyCnt = boardService.modifyB(BNO, BType, BTitle, BContent);
		if(modifyCnt > 0) {
			return "board/boardList";
		}else {
			return "";
		}
	}
}