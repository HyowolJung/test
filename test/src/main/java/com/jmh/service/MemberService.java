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

/*public interface CreateService {
	public List<BoardVO> insertBoard();
	public List<MemberVO> createMember();
}*/

public interface MemberService {
	//0. 로그인
	public List<MemberDto> loginCk(@Param("member_Id") int member_Id, @Param("member_Pw_ck") String member_Pw_ck);
	
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
	
	//3. 상세화면 조회(memberRead.jsp)
	public List<ProjectDto> getmemberprojectList(int member_Id);
	
	//3. 수정(페이지 이동 + 회원 정보 조회)(memberRead.jsp)
	public List<MemberDto> getModifyList(int member_Id);
	
	//3. 수정(전화번호 중복체크)
	public int member_Tel_ck(@Param("member_Tel") String member_Tel, @Param("member_Id") int member_Id);
	
	//3. 수정(1건 수정)
	public int memberModify(MemberDto modifyDatas);
	
	//3. 수정(다중 수정)(memberModify.jsp)
	public int memberModify2(Map<String, Object> resultMap);
	
	//3. 조회(다중 회원 정보 조회)(memberList.jsp)
	public List<String> getmemberListM(List<String> checkList);
	
	//3. 수정(memberList.jsp)
	@Transactional
	public int memberModify_M(Map<String, Object> resultMap);
	
	//4. 삭제(회원 정보 삭제)
	public int deleteMember(List<String> member_Id);

	//4. 삭제(다중 회원 정보 삭제)
	public ArrayList<String> deleteMemberM_ck(List<String> checkList);
	
	//public HashMap<String, Object> getmemberprojectList(int member_Id);

	public int getmemberId(int member_Id);

	public int memberDelete2(Map<String, Object> resultMap);

	public List<MemberDto> getFilterd_mem_List(@Param("cri") Criteria cri, @Param("project_Id") int project_Id);
	
	public List<MemberDto> getFilterd_search_mem_List(@Param("cri") Criteria cri, @Param("project_Id") int project_Id);
	
	public ArrayList<MemberDto> member_Tel_ck_m(List<MemberDto> modifyList);
	
	//팝업창 관련
	public int projectDetailInsert(Map<String, Object> resultMap);

	public String getmember_Pw(int member_Id);
}