package com.jmh.controller;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jmh.dto.Criteria;
import com.jmh.dto.MemberDto;
import com.jmh.dto.PageDto;
import com.jmh.dto.ProjectDetailDto;
import com.jmh.dto.ProjectDto;
import com.jmh.service.MemberService;
import com.jmh.service.ProjectService;

@Controller
@RequestMapping("/popup")
public class PopUpController {

	@Autowired	//의존성 주입
	private MemberService memberService;
	
	@Autowired
	private ProjectService projectService;
	
	@GetMapping("/popProject")
	public String popProject(Model model, Criteria cri) {
		int totalCnt = projectService.getTotalCnt(cri);
		PageDto pageDto = new PageDto(cri, totalCnt);
		//model.addAttribute("member_Id", member_Id);
		model.addAttribute("pageDto", pageDto);
		return "popup/popProject";	
	}
	
	//1. 조회(프로젝트 정보)
	@PostMapping("/popProject")
	@ResponseBody
	public Map<String, Object> popProject(Model model, Criteria cri, int member_Id) {
		System.out.println("cri.getsearchWord() : " + cri.getSearchWord());
		System.out.println("cri.getsearchField() : " + cri.getSearchField());
		System.out.println("member_Id : " + member_Id);
		Map<String, Object> resultMap = new HashMap<>();
		//List<ProjectDto> projectList = projectService.getProjectList(cri);
		 //Filterd_pro_List = projectService.getFilterd_pro_List(cri,member_Id); 
		// Filterd_search_pro_List = projectService.getFilterd_search_pro_List(cri,member_Id); 
		//1. 검색어 없이 조회 버튼을 클릭한 경우
		if(cri.getSearchWord().equals("") && cri.getSearchDate() == null) {	
			System.err.println("검색어 없는 조회");
			int totalCnt = projectService.getTotalCnt(cri);
			PageDto pageDto = new PageDto(cri, totalCnt);
			//projectList = projectService.getProjectList(cri);
			List<ProjectDto> Filterd_pro_List = projectService.getFilterd_pro_List(cri,member_Id); 
			//System.out.println("POST X) searchWord : " + cri.getSearchWord());
			//System.out.println("POST X) searchDate : " + cri.getSearchDate());
			//System.out.println("POST X) totalCnt : " + totalCnt);
			//System.out.println("projectList : " + projectList);
			resultMap.put("pageDto", pageDto);
			//resultMap.put("projectList", projectList);
			resultMap.put("projectList", Filterd_pro_List);
			return resultMap;
		}
		
		//2. 검색어 있고 조회 버튼을 클릭한 경우
		if(!cri.getSearchWord().equals("") || cri.getSearchDate() != null) {	
			System.err.println("검색어 있는 조회");
			//System.out.println("POST O) searchWord : " + cri.getSearchWord());
			//System.out.println("POST O) searchDate : " + cri.getSearchDate());
			int totalCnt = projectService.getTotalCnt(cri);
			//System.out.println("POST O) totalCnt : " + totalCnt);
			PageDto pageDto = new PageDto(cri, totalCnt);
			//projectList = projectService.searchProjectList(cri);
			List<ProjectDto> Filterd_search_pro_List = projectService.getFilterd_search_pro_List(cri,member_Id); 
			resultMap.put("pageDto", pageDto);
			resultMap.put("projectList", Filterd_search_pro_List);
			return resultMap;
		}
		return resultMap;	
	}
	
	@GetMapping("/memberInmember")
	public String memberInproject(Model model, @RequestParam int member_Id) {
		System.out.println("member_Id : " + member_Id);
		//model.addAttribute("member_Id" , member_Id);
		return "popup/popProject";
	}
	
	@PostMapping("/projectDetailInsert")
	public String projectDetailInsert(@RequestBody ProjectDetailDto selectedRowData) {
		System.out.println("selectedRowData : " + selectedRowData.getProject_Name());
		System.out.println("selectedRowData : " + selectedRowData.getPushDate());
		System.out.println("selectedRowData : " + selectedRowData.getPullDate());
        int insertCnt = memberService.projectDetailInsert(selectedRowData);
        if(insertCnt > 0) {
			System.out.println("등록성공");
			return "popup/popProject";
		}else {
			System.out.println("실패");
			return "";
		}
	}
	
//	@PostMapping("/projectDetailUpdate")
//	public String projectDetailUPDATE(@RequestBody ProjectDetailDto selectedRowData) {
//		System.out.println("selectedRowData : " + selectedRowData.getProject_Name());
//		System.out.println("selectedRowData : " + selectedRowData.getPushDate());
//		System.out.println("selectedRowData : " + selectedRowData.getPullDate());
//        int insertCnt = memberService.projectDetailInsert(selectedRowData);
//        if(insertCnt > 0) {
//			System.out.println("등록성공");
//			return "popup/popProject";
//		}else {
//			System.out.println("실패");
//			return "";
//		}
//	}
	
	
	
	
	
	
	
	
	
	
}
