package com.jmh.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.jmh.dto.Criteria;
import com.jmh.dto.MemberDto;
import com.jmh.dto.ProjectDto;

@Service
public interface ProjectService {
	
	List<ProjectDto> getProjectList(Criteria cri);
	
	int getTotalCnt(Criteria cri);

	List<ProjectDto> searchProjectList(Criteria cri);


}
