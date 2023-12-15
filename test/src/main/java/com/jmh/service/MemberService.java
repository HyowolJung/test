package com.jmh.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;

import com.jmh.dto.Criteria;
import com.jmh.dto.MemberDto;

@Service
public interface MemberService {

	//1. 조회(검색어 X)
	public List<MemberDto> getmemberList(Criteria cri);
	
	//1. 조회(검색어 O)
	public List<MemberDto> searchmemberList(Criteria cri);

	//1. 조회(페이징 정보)	
	public int getTotalCnt(Criteria cri);
	
	//2. 등록(아이디 체크)
	public boolean selectId(String member_Tel);
	
	//2. 등록(회원 등록)
	public int insertMember(MemberDto insertDatas);
	
	//3. 수정(페이지 이동 + 회원 정보 조회)
	public List<MemberDto> getModifyList(int member_Id);
	
	//3. 수정(전화번호 중복체크)
	public int member_Tel_ck(String member_Tel);
	
	//3. 수정(회원 정보 수정)
	public int memberModify(MemberDto modifyDatas);
	
	//4. 삭제(회원 정보 삭제)
	public int deleteMember(int member_Id);

	public HashMap<String, Object> getmemberprojectList(int member_Id);

}