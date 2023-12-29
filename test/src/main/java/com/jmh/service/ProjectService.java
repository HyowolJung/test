package com.jmh.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.jmh.dto.Criteria;
import com.jmh.dto.MemberDto;
import com.jmh.dto.ProjectDto;

@Service
public interface ProjectService {
	//1. 조회(검색어 X)
	public List<ProjectDto> getProjectList(Criteria cri);
	
	//1. 조회(페이징 정보)	
	public int getTotalCnt(Criteria cri);
	
	//1. 조회(검색어 O)
	public List<ProjectDto> searchProjectList(Criteria cri);

	//2. 등록(아이디 체크)
	public boolean checkId(int project_Id);
	public boolean checkName(String project_Name);
		
	//2. 등록(회원 등록)
	public int insertProject(ProjectDto insertDatas);

	public List<ProjectDto> getModifyList(int project_Id);

	public int projectModify(ProjectDto modifyDatas);

	public int deleteProject(int project_Id);

	public List<MemberDto> getprojectmemberList(int project_Id);

	//public List<ProjectDto> getProjectListWithId(Criteria cri, int member_Id);
	
	

}
