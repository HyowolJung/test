package com.jmh.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import com.jmh.dto.Criteria;
import com.jmh.dto.MemberDto;
import com.jmh.dto.ProjectDetailDto;
import com.jmh.dto.ProjectDto;

@Service
public interface ProjectService {
	//1. 조회(검색어 X)
	
	public int insertTest1(String data1);
	public int insertTest2(String data2);
	
	
	public List<ProjectDto> getProjectList(Criteria cri);
	
	//1. 조회(페이지 번호 출력에 필요한 총 게시물 갯수)	
	public int getTotalCntPop(@Param("cri") Criteria cri, @Param("member_Id") int member_Id);
	public int getTotalCnt(Criteria cri);
	
	//1. 조회(검색어 O)
	public List<ProjectDto> searchProjectList(Criteria cri);

	//2. 등록(아이디 체크)
	public boolean checkId(int project_Id);
	public boolean checkName(String project_Name);
		
	//2. 등록(프로젝트 등록)
	public int insertProject(ProjectDto insertDatas);

	//3. 수정(프로젝트 수정정보 조회)
	public List<ProjectDto> getModifyList(int project_Id);

	//3. 수정(프로젝트 수정)
	public int projectModify(ProjectDto modifyDatas);

	//4. 삭제(프로젝트 삭제)
	//public int deleteProject(int project_Id);

	//
	public List<MemberDto> getprojectmemberList(int project_Id);

	public List<ProjectDto> getFilterd_pro_List(@Param("cri") Criteria cri, @Param("member_Id") int member_Id);

	public List<ProjectDto> getFilterd_search_pro_List(@Param("cri") Criteria cri, @Param("member_Id") int member_Id);

	public int projectModify2(Map<String, Object> resultMap);

	public int projectDelete2(Map<String, Object> resultMap);
	
	
	
	
	
	
	public int deleteProject(List<String> checkList);

	public ArrayList<String> deleteProjectCheck(List<String> checkList);

	
	//public List<ProjectDto> getProjectListWithId(Criteria cri, int member_Id);
	
	

}
