package com.jmh.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jmh.dto.Criteria;
import com.jmh.dto.MemberDto;
import com.jmh.dto.ProjectDto;
import com.jmh.mapper.ProjectMapper;

@Service
public class ProjectServiceImpl implements ProjectService{

	@Autowired
	ProjectMapper projectMapper;
	
	@Override
	public List<ProjectDto> getProjectList(Criteria cri) {
		// TODO Auto-generated method stub
		return projectMapper.getProjectList(cri);
	}

	@Override
	public int getTotalCnt(Criteria cri) {
		// TODO Auto-generated method stub
		return projectMapper.getTotalCnt(cri);
	}

	@Override
	public List<ProjectDto> searchProjectList(Criteria cri) {
		// TODO Auto-generated method stub
		return projectMapper.searchProjectList(cri);
	}

	@Override
	public boolean checkId(int project_Id) {
		// TODO Auto-generated method stub
		return projectMapper.checkId(project_Id);
	}

	@Override
	public boolean checkName(String project_Name) {
		// TODO Auto-generated method stub
		return projectMapper.checkName(project_Name);
	}

	@Override
	public int insertProject(ProjectDto insertDatas) {
		// TODO Auto-generated method stub
		return projectMapper.insertProject(insertDatas);
	}

	@Override
	public List<ProjectDto> getModifyList(int project_Id) {
		// TODO Auto-generated method stub
		return projectMapper.getModifyList(project_Id);
	}

	@Override
	public int projectModify(ProjectDto modifyDatas) {
		// TODO Auto-generated method stub
		return projectMapper.projectModify(modifyDatas);
	}

	@Override
	public int deleteProject(int project_Id) {
		// TODO Auto-generated method stub
		return projectMapper.deleteProject(project_Id);
	}

	@Override
	public List<MemberDto> getprojectmemberList(int project_Id) {
		// TODO Auto-generated method stub
		return projectMapper.getprojectmemberList(project_Id);
	}

}
