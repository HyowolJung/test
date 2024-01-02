package com.jmh.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.PathVariable;

import com.jmh.dto.Criteria;
import com.jmh.dto.MemberDto;
import com.jmh.dto.PageDto;
import com.jmh.dto.ProjectDetailDto;
import com.jmh.dto.ProjectDto;

@Repository
public interface MemberMapper {

	//1. 조회(검색어 X)
	List<MemberDto> getmemberList(Criteria cri);
	
	//1. 조회(검색어 O)
	List<MemberDto> searchmemberList(Criteria cri);

	//1. 조회(페이징 정보)
	int getTotalCnt(Criteria cri);
	
	//2. 등록(아이디 체크)
	boolean checkId(int member_Id);
	boolean checkTel(String member_Tel);
	
	//2. 등록(회원 등록)
	int insertMember(MemberDto insertDatas);
	
	//3. 수정(페이지 이동 + 회원 정보 조회)
	List<MemberDto> getModifyList(int member_Id);
	
	//3. 수정(전화번호 중복체크)
	int member_Tel_ck(@Param("member_Tel") String member_Tel, @Param("member_Id") int member_Id);
	
	//3. 수정(회원 정보 수정)
	int memberModify(MemberDto modifyDatas);
	
	//4. 삭제(회원 정보 삭제)
	int deleteMember(int member_Id);

	//HashMap<String, Object> getmemberprojectList(int member_Id);
	List<ProjectDto> getmemberprojectList(int member_Id);

	int getmemberId(int member_Id);

	Object projectInmember(int project_Id);

	int projectDetailInsert(ProjectDetailDto selectedRowData);
	
}
