package com.jmh.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jmh.dto.Criteria;
import com.jmh.dto.MemberDto;
import com.jmh.dto.PageDto;
import com.jmh.dto.ProjectDto;
import com.jmh.service.ProjectService;

@Controller
@RequestMapping("/project")
public class ProjectController {

	@Autowired
	ProjectService projectService;
	
	@GetMapping("/projectList")
	public String projectList1(Model model, Criteria cri) {
		int totalCnt = projectService.getTotalCnt(cri);
		PageDto pageDto = new PageDto(cri, totalCnt);
		System.out.println("pageDto.cri.searchWord : " + pageDto.cri.getSearchWord());
		model.addAttribute("pageDto", pageDto);
		return "project/projectList";	
	}
	
	//1. 조회(회원 정보)
	@PostMapping("/projectList")
	@ResponseBody
	public List<ProjectDto> projectList2(Model model, Criteria cri, String search_ck) {
		System.out.println("도착1");
		System.out.println("searchWord : " + cri.getSearchWord());
		List<ProjectDto> projectList = projectService.getProjectList(cri); 
		//1. 검색어 없이 조회 버튼을 클릭한 경우
		if(search_ck != null && cri.getSearchWord() == null) {	//조건 없이 조회 버튼만 누른 경우.
			System.err.println("검색어 없는 조회");
			int totalCnt = projectService.getTotalCnt(cri);
			PageDto pageDto = new PageDto(cri, totalCnt);
			projectList = projectService.getProjectList(cri); 
			return projectList;
		}
		//2. 검색어 있고 조회 버튼을 클릭한 경우
//		else if(search_ck != null && cri.getSearchWord() != null) {
//			System.err.println("검색어 있는 조회");
//			int totalCnt = projectService.getTotalCnt(cri);
//			System.out.println("totalCnt : " + totalCnt);
//			PageDto pageDto = new PageDto(cri, totalCnt);
//			memberList = projectService.searchmemberList(cri);
//			System.out.println("memberList : " + memberList);
//			return memberList;
//		}
		return projectList;	
		
	}
}
