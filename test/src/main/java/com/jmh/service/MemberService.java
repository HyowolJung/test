package com.jmh.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.jmh.dto.Criteria;
import com.jmh.dto.MemberDto;
import com.jmh.dto.MemberDto;
import com.jmh.dto.PageDto;
import com.jmh.dto.ProjectDetailDto;
import com.jmh.dto.ProjectDto;

public interface MemberService {
	
	//0. 로그인
	//public List<MemberDto> loginCk(@Param("member_Id") int member_Id, @Param("member_Pw_ck") String member_Pw_ck);
	
	//1. 엑셀 다운로드
	public void exportToExcel(HttpServletResponse response)throws IOException ;
	
	//1. 멤버 목록 조회
	public List<MemberDto> getMemberList(Criteria cri );//,@Param("data") Criteria data
	
	//1. 멤버 정보 숫자	
	public int getTotalCnt(Criteria cri);
	
	// 검색결과 멤버 목록 가져오기
	public List<MemberDto> searchMemberList(Criteria cri);
	
	// 상세화면 멤버 정보 가져오기
	public List<MemberDto> getSelectedList(List<String> selectedList);
	
	//3. 멤버 정보 수정
	public int modifyMember(List<MemberDto> memberList);
	
	//4. 삭제(회원 정보 삭제)
	public int deleteMember(List<String> checkList);
	
	//2. 등록(회원 등록)
	public int insertMember(List<MemberDto> memberList);
	
	
	
	
	
	
	
	
	
	public List<MemberDto> getmemberList2();
	
	//1. 조회(검색어 O)
	//public List<MemberDto> searchmemberList(@Param("cri") Criteria cri , @Param("pageDto") PageDto pageDto);
	//public List<MemberDto> searchmemberList(Criteria cri);
	
	//2. 등록(중복 체크)
	public boolean checkId(String memberId);
	public boolean checkTel(String memberTel);
	
	
	
	//3. 상세화면 조회(memberRead.jsp)
	public List<ProjectDto> getmemberprojectList(int member_Id);
	
	public List<MemberDto> getModifyList(int member_Id);
	public List<MemberDto> selectModifyList(int memberId);
	
	//3. 수정(전화번호 중복체크)
	public int member_Tel_ck(@Param("member_Tel") String member_Tel, @Param("member_Id") int member_Id);
	
	//3. 수정(1건 수정)
	public int memberModify(MemberDto modifyDatas);
	
	//3. 수정(다중 수정)(memberModify.jsp)
	//public int memberModify2( resultMap);
	
	//3. 조회(다중 회원 정보 조회)(memberList.jsp)
	public List<String> checkedList(List<String> checkList);
	
	//3. 수정(memberList.jsp)
	@Transactional
	public int memberModify_M(Map<String, Object> resultMap);
	
	

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



	
	//public void exportToExcel2(@Param("response")HttpServletResponse response, @Param("modifyDatas") List<MemberDto> modifyDatas)throws IOException ;

	//public int modifyMember2(Map<String, Object> resultMap);

	

	//public List<MemberDto> getSelectedList(List<String> selectedList);

}







