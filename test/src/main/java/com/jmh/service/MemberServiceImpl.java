package com.jmh.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
		String pwd = insertDatas.getMember_Pw();
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String encodedPwd = encoder.encode(pwd);
		
		insertDatas.setMember_Pw(encodedPwd);
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
	public int deleteMember(List<String> member_Id) {
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
	public int memberModify2(Map<String, Object> resultMap) {
		// TODO Auto-generated method stub
		return memberMapper.memberModify2(resultMap);
	}

	@Override
	public int memberDelete2(Map<String, Object> resultMap) {
		// TODO Auto-generated method stub
		return memberMapper.memberDelete2(resultMap);
	}

	@Override
	public List<MemberDto> getFilterd_search_mem_List(@Param("cri") Criteria cri, @Param("project_Id") int project_Id) {
		System.out.println("Service) cri.getStartNo() : " + cri.getStartNo());
		return memberMapper.getFilterd_search_mem_List(cri, project_Id);
	}

	@Override
	public List<MemberDto> getFilterd_mem_List(@Param("cri") Criteria cri, @Param("project_Id") int project_Id) {
		// TODO Auto-generated method stub
		return memberMapper.getFilterd_mem_List(cri, project_Id);
	}

	@Override
	public List<MemberDto> loginCk(@Param("member_Id") int member_Id, @Param("member_Pw_ck") String member_Pw_ck) {
		// TODO Auto-generated method stub
		
		return memberMapper.loginCk(member_Id, member_Pw_ck);
	}

	@Override
	public List<String> getmemberListM(List<String> checkList) {
		// TODO Auto-generated method stub
		return memberMapper.getmemberListM(checkList);
	}

	@Override
	public int memberModify_M(Map<String, Object> resultMap) {
		// TODO Auto-generated method stub
		return memberMapper.memberModify_M(resultMap);
	}

	@Override
	public ArrayList<String> deleteMemberM_ck(List<String> checkList) {
		// TODO Auto-generated method stub
		return memberMapper.deleteMemberM_ck(checkList);
	}

	@Override
	public ArrayList<MemberDto> member_Tel_ck_m(List<MemberDto> modifyList) {
		// TODO Auto-generated method stub
		return memberMapper.member_Tel_ck_M(modifyList);
	}
	
	//팝업창 관련
	@Override
	public int projectDetailInsert(Map<String, Object> resultMap) {
		// TODO Auto-generated method stub
		return memberMapper.projectDetailInsert(resultMap);
	}

	@Override
	public String getmember_Pw(int member_Id) {
		// TODO Auto-generated method stub
		return memberMapper.getmember_Pw(member_Id);
	}
}
