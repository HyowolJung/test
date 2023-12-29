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
	ProjectService projectService;
	
//	@GetMapping("/popProject")	//parameter 와 argument의 차이
//	public ResponseEntity<String> popProject(Model model, Criteria cri) {
//		//System.out.println("GET / popProject : " + member_Id);
//		int totalCnt = projectService.getTotalCnt(cri);
//		PageDto pageDto = new PageDto(cri, totalCnt);
//		//model.addAttribute("member_Id", member_Id);
//		model.addAttribute("pageDto", pageDto);
//		return ResponseEntity.ok("Success");	
//	}
	
	@GetMapping("/popProject")
	public String popProject(Model model, Criteria cri) {
		//System.out.println("GET / popProject : " + member_Id);
		//List<ProjectDto> projectList = projectService.getProjectList(cri);
		//model.addAttribute("projectList" , projectList);
		int totalCnt = projectService.getTotalCnt(cri);
		PageDto pageDto = new PageDto(cri, totalCnt);
		//model.addAttribute("member_Id", member_Id);
		model.addAttribute("pageDto", pageDto);
		return "popup/popProject";	
	}
	
	//1. 조회(프로젝트 정보)
	@PostMapping("/popProject")
	@ResponseBody
	public Map<String, Object> popProject(Model model, Criteria cri, String search_ck) {
		//System.out.println("POST / popProject");
		//System.out.println("member_Id : " + member_Id);
		Map<String, Object> resultMap = new HashMap<>();

		List<ProjectDto> projectList = projectService.getProjectList(cri); 
		//System.out.println("여기까지왔어");
		//1. 검색어 없이 조회 버튼을 클릭한 경우
		if(search_ck != null && (cri.getSearchWord().equals("") && cri.getSearchDate() == null)) {	
			//System.err.println("검색어 없는 조회");
			int totalCnt = projectService.getTotalCnt(cri);
			PageDto pageDto = new PageDto(cri, totalCnt);
			projectList = projectService.getProjectList(cri);
			//System.out.println("POST X) searchWord : " + cri.getSearchWord());
			//System.out.println("POST X) searchDate : " + cri.getSearchDate());
			//System.out.println("POST X) totalCnt : " + totalCnt);
			//System.out.println("projectList : " + projectList);
			resultMap.put("pageDto", pageDto);
			resultMap.put("projectList", projectList);
			return resultMap;
		}
		
		//2. 검색어 있고 조회 버튼을 클릭한 경우
		if(search_ck != null && (!cri.getSearchWord().equals("") || cri.getSearchDate() != null)) {	
			//System.err.println("검색어 있는 조회");
			//System.out.println("POST O) searchWord : " + cri.getSearchWord());
			//System.out.println("POST O) searchDate : " + cri.getSearchDate());
			int totalCnt = projectService.getTotalCnt(cri);
			//System.out.println("POST O) totalCnt : " + totalCnt);
			PageDto pageDto = new PageDto(cri, totalCnt);
			projectList = projectService.searchProjectList(cri);
			resultMap.put("pageDto", pageDto);
			resultMap.put("projectList", projectList);
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
	
	@PostMapping("/memberInmember")
	public String memberInproject(@RequestBody List<?> selectedRowData, ProjectDto projectDto, ProjectDetailDto projectDetailDto, MemberDto memberDto) {//, 
		System.out.println("여기왔어요.");
        System.out.println("memberDto.getMember_Id() : " + memberDto.getMember_Id());
        System.out.println("projectDto.getProject_Id(); : " + projectDto.getProject_Id());
        System.out.println("projectDto.getProject_Name(); : " + projectDto.getProject_Name());
        //System.out.println("projectDto.getProject_Name(); : " + projectDto.getCustom_company_id());
        //System.out.println("projectDto.getProject_Name(); : " + projectDto.getProject_Skill_Language());
        //System.out.println("projectDto.getProject_Name(); : " + projectDto.getProject_Skill_DB());
        //System.out.println("projectDto.getProject_Name(); : " + projectDto.getProject_startDate());
        System.out.println("ProjectDetailDto.pushDate(); : " + projectDetailDto.getPushDate());
        System.out.println("ProjectDetailDto.pullDate(); : " + projectDetailDto.getPullDate());
        
        int project_Id = projectDto.getProject_Id();
        System.out.println("project_Id : " + project_Id);
        
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("member_Id", memberDto.getMember_Id());
        resultMap.put("project_Id", projectDto.getProject_Id());
        resultMap.put("project_Name", projectDto.getProject_Name());
        //resultMap.put("custom_company_id", projectDto.getCustom_company_id());
        resultMap.put("pushDate", projectDetailDto.getPushDate());
        resultMap.put("pullDate", projectDetailDto.getPullDate());
        
        System.out.println("resultMap : " + resultMap);
        //int insertCnt = memberService.memberInmember(resultMap);
        
		return "popup/popProject";
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
