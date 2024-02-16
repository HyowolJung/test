package com.jmh.controller;

import java.time.LocalDate;
import java.util.ArrayList;
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
import org.springframework.web.servlet.ModelAndView;

import com.jmh.dto.Criteria;
import com.jmh.dto.MemberDto;
import com.jmh.dto.PageDto;
import com.jmh.dto.ProjectDetailDto;
import com.jmh.dto.ProjectDto;
import com.jmh.service.MemberService;
import com.jmh.service.ProjectService;

import lombok.extern.log4j.Log4j;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/popup")
public class PopUpController {

	@Autowired	//의존성 주입
	private MemberService memberService;
	
	@Autowired
	private ProjectService projectService;
	
	//@GetMapping("/popProject")
	@PostMapping("/popProject")
	public String popProject(Model model, Criteria cri, int member_Id, String member_Name) {
		System.out.println("pop)member_Id : " + member_Id);
		System.out.println("pop)member_Name : " + member_Name);
		int totalCnt = projectService.getTotalCnt(cri);
		PageDto pageDto = new PageDto(cri, totalCnt);
		//model.addAttribute("member_Id", member_Id);
		System.err.println("pageDto : " + pageDto);
		model.addAttribute("pageDto", pageDto);
		model.addAttribute("member_Name", member_Name);
		return "popup/popProject";	
	}
	
	//1. 조회(프로젝트 정보)
	@PostMapping("/popProjectInfo")
	@ResponseBody
	public Map<String, Object> popProject(Model model, Criteria cri, int member_Id) {
		System.out.println("cri.getSearchField() : " + cri.getSearchField());
		System.out.println("cri.getSearchWord() : " + cri.getSearchWord());
		System.out.println("cri.getSearch_startDate() : " + cri.getSearch_startDate());
		System.out.println("cri.getSearch_endDate() : " + cri.getSearch_endDate());
		System.out.println("pop)member_Id : " + member_Id);
		
		Map<String, Object> resultMap = new HashMap<>();
		//1. 검색어 없이 조회 버튼을 클릭한 경우
		System.err.println("popProject 분기점 도착");
		if(cri.getSearchWord().equals("") && cri.getSearch_startDate() == null && cri.getSearch_endDate() == null) {	
			System.err.println("검색어 없는 조회");
			int totalCnt = projectService.getTotalCnt(cri);
			PageDto pageDto = new PageDto(cri, totalCnt);
			//projectList = projectService.getProjectList(cri);
			System.err.println("pa : " + pageDto.cri.getStartNo());
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
		if(!cri.getSearchWord().equals("") || cri.getSearch_startDate() != null || cri.getSearch_endDate() != null) {	
			System.err.println("검색어 있는 조회");
			//System.out.println("POST O) searchWord : " + cri.getSearchWord());
			//System.out.println("POST O) searchDate : " + cri.getSearchDate());
			int totalCnt = projectService.getTotalCntPop(cri, member_Id);
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
	public String projectDetailInsert(@RequestBody List<ProjectDetailDto> selectedRowData) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("selectedRowData", selectedRowData);
		System.out.println("resultMap : " + resultMap);
		int check = 0;
		for(ProjectDetailDto data : selectedRowData) {
			check = data.getCheck();
		}
		
		if(check == 1) {
			System.out.println("p 진입");
			//System.out.println("selectedRowData : " + selectedRowData.getProject_Name());
			//System.out.println("selectedRowData : " + selectedRowData.getPushDate());
			//System.out.println("selectedRowData : " + selectedRowData.getPullDate());
	        int insertCnt = memberService.projectDetailInsert(resultMap);
	        if(insertCnt > 0) {
				System.out.println("등록성공");
				return "popup/popProject";
			}else {
				System.out.println("실패");
				return "";
			}
		}
		
		if(check == 2) {
			System.err.println("check가 2 입니다.");
			int insertCnt = memberService.projectDetailInsert(resultMap);
			
			if(insertCnt > 0) {
				System.out.println("등록성공");
				return "popup/popMember";
			}else {
				System.out.println("실패");
				return "";
			}
		}
		return "";
	}
	
	@GetMapping("/popMember")
	public String popMemberGet(Model model, Criteria cri,
			@RequestParam(value = "project_Id", required = false) int project_Id,
			@RequestParam(value = "project_Name", required = false) String project_Name) {
		System.err.println("project_Name11 : " + project_Name);
		int totalCnt = memberService.getTotalCnt(cri);
		PageDto pageDto = new PageDto(cri, totalCnt);
		model.addAttribute("pageDto", pageDto);
		model.addAttribute("project_Name", project_Name);
		return "popup/popMember";
	}
//	
//	@GetMapping("/popMember")
//	public ResponseEntity<?> popMember(Model model, Criteria cri,
//			@RequestParam(value = "project_Id", required = false) String project_Id,
//			@RequestParam(value = "project_Name", required = false) String project_Name) {
//		System.err.println("project_Name11 : " + project_Name);
//		int totalCnt = memberService.getTotalCnt(cri);
//		PageDto pageDto = new PageDto(cri, totalCnt);
//		model.addAttribute("pageDto", pageDto);
//		model.addAttribute("project_Name", project_Name);
//		return ResponseEntity.ok(project_Name); //"/popup/popMember?pageNo=1&project_Id=" + project_Id
//	}
	
	@PostMapping("/popMember")
	@ResponseBody
	public Map<String, Object> popMemberPost(Model model, Criteria cri, int project_Id, String project_Name) {
		System.out.println("popMember)project_Name : " + project_Name);
		System.out.println("popMember)project_Id : " + project_Id);
		Map<String, Object> resultMap = new HashMap<>();
		
		//1. 검색어 없이 조회 버튼을 클릭한 경우
		if(cri.getSearchWord().equals("") && cri.getSearch_startDate() == null && cri.getSearch_endDate() == null) {	
			System.err.println("검색어 없는 조회");
			int totalCnt = memberService.getTotalCnt(cri);
			PageDto pageDto = new PageDto(cri, totalCnt);
			List<MemberDto> getFilterd_mem_List = memberService.getFilterd_mem_List(cri, project_Id);
			//System.out.println("getFilterd_mem_List : " + getFilterd_mem_List);
			resultMap.put("pageDto", pageDto);
			resultMap.put("memberList", getFilterd_mem_List);
			//System.err.println("popMemberpopMemberpopMember");
			return resultMap;
		}
		
		//2. 검색어 있고 조회 버튼을 클릭한 경우
		if(!cri.getSearchWord().equals("") || cri.getSearch_startDate() != null || cri.getSearch_endDate() != null) {	
			System.err.println("검색어 있는 조회");
			//System.out.println("POST O) searchWord : " + cri.getSearchWord());
			//System.out.println("POST O) searchDate : " + cri.getSearchDate());
			int totalCnt = memberService.getTotalCnt(cri);
			PageDto pageDto = new PageDto(cri, totalCnt);
			List<MemberDto> memberList = memberService.getFilterd_search_mem_List(cri, project_Id); 
			resultMap.put("pageDto", pageDto);
			resultMap.put("memberList", memberList);
			return resultMap;
		}
		return resultMap;	
	}
}
