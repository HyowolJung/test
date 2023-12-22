package com.jmh.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
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
import com.jmh.dto.ProjectDto;
import com.jmh.service.ProjectService;

@Controller
@RequestMapping("/project")
public class ProjectController {

	@Autowired
	ProjectService projectService;
	
	@GetMapping("/projectList")
	public String projectList1(Model model, Criteria cri, @RequestParam int pageNo) {
		int totalCnt = projectService.getTotalCnt(cri);
		PageDto pageDto = new PageDto(cri, totalCnt);
		model.addAttribute("pageDto", pageDto);
		return "project/projectList";	
	}
	
	//1. 조회(회원 정보)
	@PostMapping("/projectList")
	@ResponseBody
	public Map<String, Object> projectList2(Model model, Criteria cri, String search_ck) {
		System.out.println("도착1");
		//System.out.println("POST) searchWord : " + cri.getSearchWord());
		System.out.println("POST) searchDate : " + cri.getSearchDate());
		Map<String, Object> resultMap = new HashMap<>();
		List<ProjectDto> projectList = projectService.getProjectList(cri); 
		
		//1. 검색어 없이 조회 버튼을 클릭한 경우
		//if(search_ck != null && cri.getSearchWord() == null && cri.getSearchWord().equals("") && cri.getSearchDate() == null && cri.getSearchWord().length() == 0 && cri.getSearchWord().trim().isEmpty()) {	//조건 없이 조회 버튼만 누른 경우.
		if(search_ck != null && cri.getSearchWord().trim().isEmpty() && cri.getSearchDate() == null) {
			System.err.println("검색어 없는 조회");
			int totalCnt = projectService.getTotalCnt(cri);
			System.out.println("totalCnt : " + totalCnt);
			PageDto pageDto = new PageDto(cri, totalCnt);
			projectList = projectService.getProjectList(cri);
			System.out.println("projectList : " + projectList);
			resultMap.put("pageDto", pageDto);
			resultMap.put("projectList", projectList);
			return resultMap;
		}
		
		//2. 검색어 있고 조회 버튼을 클릭한 경우
		else if(search_ck != null && cri.getSearchWord() != null || cri.getSearchDate() != null || !cri.getSearchWord().trim().isEmpty()) {
		//else if (search_ck != null && (cri.getSearchWord() != null || cri.getSearchDate() != null)) {
			System.err.println("검색어 있는 조회");
			System.out.println("POST) searchWord : " + cri.getSearchWord());
			int totalCnt = projectService.getTotalCnt(cri);
			PageDto pageDto = new PageDto(cri, totalCnt);
			projectList = projectService.searchProjectList(cri);
			resultMap.put("pageDto", pageDto);
			resultMap.put("projectList", projectList);
			return resultMap;
		}
		//System.out.println("resultMap : " + resultMap);
		return resultMap;	
	}
	
	//2. 등록(페이지 이동)
	@GetMapping("/projectInsert")
	public String projectInsert() {
				
		return "project/projectInsert";
	}
	
	//2. 등록(아이디 체크)
	@GetMapping("/projectInsert_ck")
	@ResponseBody
	public ResponseEntity<Boolean> insertProject_ck(String project_Name, Integer project_Id) {
		boolean result = true;
		System.out.println("project_Id : " + project_Id);
		System.out.println("project_Name : " + project_Name);
		
		if(project_Id != null) {
			if(projectService.checkId(project_Id)) {
				System.out.println("projectService.checkId1(project_Id : " + projectService.checkId(project_Id));
				result = false;
				
			}else {
				System.out.println("projectService.checkId2(project_Id : " + projectService.checkId(project_Id));
				result = true;
			}
		}
		
		//if(!member_Tel.trim().isEmpty()) {
		if(project_Name != null) {
			if(projectService.checkName(project_Name)) {
				System.out.println("projectService.checkName1(project_Id : " + projectService.checkName(project_Name));
				result = false;
			
			}else {
				System.out.println("projectService.checkName1((project_Id : " + projectService.checkName(project_Name));
				result = true;
			}
		}
		
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	//2. 등록(회원 등록)
	@PostMapping("/projectInsert")
	public String insertProject(@RequestBody ProjectDto insertDatas) {
		//System.out.println("insertDatas.getMember_startDate : " + insertDatas.getMember_Name());
		//System.out.println("insertDatas.getMember_startDate : " + insertDatas.getMember_startDate());
		
		int insertCnt = projectService.insertProject(insertDatas);
		if(insertCnt > 0) {
			System.out.println("등록성공");
			return "project/projectList";
		}else {
			System.out.println("실패");
			return "";
		}
	}
	
	//3. 수정(페이지 이동 + 회원 정보 조회)
	@GetMapping("/projectModify")
	public String modifyMember(@RequestParam("project_Id") int project_Id, Model model, @RequestParam int pageNo) { /* , @RequestParam int pageNo */
		System.out.println("수정 화면 작동");
		model.addAttribute("projectList" ,projectService.getModifyList(project_Id));
		model.addAttribute("pageNo" , pageNo);
		return "project/projectModify";
	}
		
	//3. 수정(회원 정보 수정)
	@PostMapping("/projectModify")
	public ResponseEntity<Boolean> modifyProject(@RequestBody ProjectDto modifyDatas) {
		//int project_Id = modifyDatas.getProject_Id();		//jsp 에서 보내온 아이디
		//int member_Id_ck = memberService.getmemberId(member_Id);
		
		boolean result = false;
		
		int modifyCnt = projectService.projectModify(modifyDatas);
		if(modifyCnt > 0) {
			System.out.println("수정 성공1");
			result = true;
		}else if(modifyCnt < 0 ) {
			System.out.println("수정 실패1");
			result = false;
		}
			
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	//4. 삭제(회원 정보 삭제)
	@GetMapping("/projectDelete")
	public String projectDelete(@RequestParam int project_Id) {
		int deleteCnt = projectService.deleteProject(project_Id);
		
		if(deleteCnt > 0) {
			return "project/projectList";
		}else {
			return "";
		}
	}
	
	@GetMapping("/projectRead")
	public List<MemberDto> projectRead(Model model, @RequestParam int project_Id, Criteria cri, @RequestParam int pageNo) {
		List<MemberDto> projectmemberList = projectService.getprojectmemberList(project_Id);
		System.out.println("pageNo : " + pageNo);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("projectmemberList" , projectmemberList);
		model.addAttribute("projectList" ,projectService.getModifyList(project_Id));
		return projectmemberList;
	}
}
