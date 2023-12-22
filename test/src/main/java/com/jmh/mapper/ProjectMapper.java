package com.jmh.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.jmh.dto.Criteria;
import com.jmh.dto.MemberDto;
import com.jmh.dto.ProjectDto;

@Repository
public interface ProjectMapper {

	List<ProjectDto> getProjectList(Criteria cri);

	int getTotalCnt(Criteria cri);

	List<ProjectDto> searchProjectList(Criteria cri);

	boolean checkId(int project_Id);

	boolean checkName(String project_Name);

	int insertProject(ProjectDto insertDatas);

	List<ProjectDto> getModifyList(int project_Id);

	int projectModify(ProjectDto modifyDatas);

	int deleteProject(int project_Id);

	List<MemberDto> getprojectmemberList(int project_Id);

}
