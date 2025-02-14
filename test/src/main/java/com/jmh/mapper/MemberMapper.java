package com.jmh.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.jmh.dto.Criteria;
import com.jmh.dto.MemberDto;
//import com.jmh.dto.MemberDto;
import com.jmh.dto.PageDto;
import com.jmh.dto.ProjectDetailDto;
import com.jmh.dto.ProjectDto;
//import com.jmh.security.CustomUserDetails;

@Repository
public interface MemberMapper {
	
	public List<MemberDto> getMemberList(Criteria cri);
	
	public int getTotalCnt(Criteria cri);
	
	public List<MemberDto> searchMemberList(Criteria cri);
	
	public List<MemberDto> getSelectedList(List<String> selectedList);
	
	// 3. 수정
	public int modifyMember(List<MemberDto> memberList); // 수정할지말지 결정
	public int isMyMemberTel(List<MemberDto> memberList); // 수정하려는 번호가 내 번호인가요?
	public int isDupliMemberTel(List<MemberDto> memberList); // 수정하려는 번호가 다른 사람의 번호와 겹치지는 않나요?
	
	//4. 삭제(회원 정보 삭제)
	public int deleteMember(List<String> checkList);
	
	public int insertMember(List<MemberDto> memberList);
	public int isDupliMemberId(List<MemberDto> memberList);
	
	
		
		
		
		
		
	
	//String getDept(String member_Id);
	public MemberDto read(String member_Id);
	
	//0. 로그인
	//public CustomUserDetails loginID(String memberId);
	
	
	
	//2. 등록(아이디 체크)
	boolean checkId(String memberId);
	boolean checkTel(String memberTel);
		
		
	//1. 조회(검색어 O)
	//List<MemberDto> searchmemberList(Criteria cri);
	
	//2. 등록(아이디 체크)
//	boolean checkId(int member_Id);
//	boolean checkTel(String member_Tel);
	
	//2. 등록(회원 등록)
	
	
	
	//public int updateMember(List<MemberDto> modifyList);	//멤버 정보 수정
	
	
	//3. 수정(페이지 이동 + 회원 정보 조회)
	List<MemberDto> getModifyList(int member_Id);
	List<MemberDto> selectModifyList(int memberId);
	
	
	List<MemberDto> getmemberList2();
	//3. 수정(전화번호 중복체크)
	int member_Tel_ck(@Param("member_Tel") String member_Tel, @Param("member_Id") int member_Id);
	List<String> checkedList(List<String> checkList);
	
	//3. 수정(회원 정보 수정)
	int memberModify(MemberDto modifyDatas);
	

	//HashMap<String, Object> getmemberprojectList(int member_Id);
	List<ProjectDto> getmemberprojectList(int member_Id);

	int getmemberId(int member_Id);

	Object projectInmember(int project_Id);

	int memberModify2(Map<String, Object> resultMap);

	int memberDelete2(Map<String, Object> resultMap);

	List<MemberDto> getFilterd_mem_List(@Param("cri") Criteria cri, @Param("project_Id") int project_Id);
	
	List<MemberDto> getFilterd_search_mem_List(@Param("cri") Criteria cri, @Param("project_Id") int project_Id);

	List<MemberDto> loginCk(@Param("member_Id") int member_Id, @Param("member_Pw_ck") String member_Pw_ck);

	

	ArrayList<MemberDto> member_Tel_ck_M(List<MemberDto> modifyList);

	int memberModify_M(Map<String, Object> resultMap);

	ArrayList<String> deleteMemberM_ck(List<String> checkList);
	
	
	//팝업창 관련
	int projectDetailInsert(Map<String, Object> resultMap);

	String getmember_Pw(int member_Id);

	public List<MemberDto> getMemberListt();

	
	
	
	
	
	

	

	
}
