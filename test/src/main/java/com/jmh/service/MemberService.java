package com.jmh.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;

import com.jmh.dto.Criteria;
import com.jmh.dto.MemberDto;
import com.jmh.dto.PageDto;
import com.jmh.dto.ProjectDetailDto;
import com.jmh.dto.ProjectDto;

public interface MemberService {

	//1. 조회(검색어 X)
	public List<MemberDto> getmemberList(Criteria cri);
	
	//1. 조회(검색어 O)
	//public List<MemberDto> searchmemberList(@Param("cri") Criteria cri , @Param("pageDto") PageDto pageDto);
	public List<MemberDto> searchmemberList(Criteria cri);
	
	//1. 조회(페이징 정보)	
	public int getTotalCnt(Criteria cri);
	
	//2. 등록(아이디 체크)
	public boolean checkId(int member_Id);
	public boolean checkTel(String member_Tel);
	
	//2. 등록(회원 등록)
	public int insertMember(MemberDto insertDatas);
	
	//3. 수정(페이지 이동 + 회원 정보 조회)
	public List<MemberDto> getModifyList(int member_Id);
	
	//3. 수정(전화번호 중복체크)
	public int member_Tel_ck(@Param("member_Tel") String member_Tel, @Param("member_Id") int member_Id);
	
	//3. 수정(회원 정보 수정)
	public int memberModify(MemberDto modifyDatas);
	
	//4. 삭제(회원 정보 삭제)
	public int deleteMember(List<String> member_Id);

	//public HashMap<String, Object> getmemberprojectList(int member_Id);
	public List<ProjectDto> getmemberprojectList(int member_Id);

	public int getmemberId(int member_Id);

	public int memberModify2(Map<String, Object> resultMap);

	public int memberDelete2(Map<String, Object> resultMap);

	public List<MemberDto> getFilterd_mem_List(@Param("cri") Criteria cri, @Param("project_Id") int project_Id);
	
	public List<MemberDto> getFilterd_search_mem_List(@Param("cri") Criteria cri, @Param("project_Id") int project_Id);
	//public void projectInmember(int project_Id);
	public List<MemberDto> loginCk(@Param("member_Id") int member_Id, @Param("member_Pw") String member_Pw);

	public List<String> getmemberListM(List<String> checkList);

	//public int member_Tel_ck_M(@Param("member_Id")int member_Id, @Param("member_Tel")String member_Tel);

	@Transactional
	public int memberModify_M(Map<String, Object> resultMap);

	public ArrayList<String> deleteMemberM_ck(List<String> checkList);

	//public int member_Tel_ck_m(@Param("member_Tel")String member_Tel, @Param("member_Id")int member_Id);
	public ArrayList<MemberDto> member_Tel_ck_m(List<MemberDto> modifyList);

	
	
	//팝업창 관련
	public int projectDetailInsert(Map<String, Object> resultMap);

	public String getmember_Pw(int member_Id);
}