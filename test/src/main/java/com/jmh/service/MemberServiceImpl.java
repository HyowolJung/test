package com.jmh.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jmh.dto.Criteria;
import com.jmh.dto.MemberDto;
import com.jmh.dto.PageDto;
import com.jmh.dto.ProjectDetailDto;
import com.jmh.dto.ProjectDto;
import com.jmh.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	MemberMapper memberMapper;
	
	//1. 조회(검색어 X)
	@Override
	public List<MemberDto> getmemberList(Criteria cri) {
		// TODO Auto-generated method stub
		return memberMapper.getmemberList(cri);
	}
	
	//1. 조회(검색어 O)
	@Override
	public List<MemberDto> searchmemberList(Criteria cri) {
		// TODO Auto-generated method stub
		return memberMapper.searchmemberList(cri);
	}
	
	//1. 조회(페이징 정보)
	@Override
	public int getTotalCnt(Criteria cri) {
		// TODO Auto-generated method stub
		return memberMapper.getTotalCnt(cri);
	}
	
	//2. 등록(아이디 체크)
	@Override
	public boolean checkId(int member_Id) {
		// TODO Auto-generated method stub
		return memberMapper.checkId(member_Id);
	}
	
	//2. 등록(아이디 체크)
	@Override
	public boolean checkTel(String member_Tel) {
		// TODO Auto-generated method stub
		return memberMapper.checkTel(member_Tel);
	}
	
	//2. 등록(회원 등록)
	@Override
	public int insertMember(MemberDto insertDatas) {
		// TODO Auto-generated method stub
		return memberMapper.insertMember(insertDatas);
	}
	
	//3. 수정(페이지 이동 + 회원 정보 조회)
	@Override
	public List<MemberDto> getModifyList(int member_Id) {
		// TODO Auto-generated method stub
		return memberMapper.getModifyList(member_Id);
	}
	
	//3. 수정(전화번호 중복체크) - 수정하려는 전화번호가 다른 회원의 전화번호와 겹치는지
	@Override
	public int member_Tel_ck(@Param("member_Tel") String member_Tel, @Param("member_Id") int member_Id) {
		// TODO Auto-generated method stub
		return memberMapper.member_Tel_ck(member_Tel, member_Id);
	}
	
	//3. 수정(회원 정보 수정)
	@Override
	public int memberModify(MemberDto modifyDatas) {
		// TODO Auto-generated method stub
		return memberMapper.memberModify(modifyDatas);
	}
	
	//4. 삭제(회원 정보 삭제)
	@Override
	public int deleteMember(int member_Id) {
		// TODO Auto-generated method stub
		return memberMapper.deleteMember(member_Id);
	}

	@Override
	public List<ProjectDto> getmemberprojectList(int member_Id) {
		// TODO Auto-generated method stub
		return memberMapper.getmemberprojectList(member_Id);
	}

	@Override
	public int getmemberId(int member_Id) {
		// TODO Auto-generated method stub
		return memberMapper.getmemberId(member_Id);
	}

	@Override
	public int projectDetailInsert(ProjectDetailDto selectedRowData) {
		// TODO Auto-generated method stub
		return memberMapper.projectDetailInsert(selectedRowData);
	}

//	@Override
//	public void projectInmember(int project_Id) {
//		return memberMapper.projectInmember(project_Id);
//		
//	}
	
	

	

	

	
	
}
