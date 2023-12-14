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

}
