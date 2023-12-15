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

}
