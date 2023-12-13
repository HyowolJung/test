package com.jmh.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jmh.mapper.MemberMapper;
import com.jmh.vo.memberVO;
import com.jmh.vo.Criteria;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	MemberMapper memberMapper;
	
	//1. ��ȸ
//	@Override
//	public List<BoardVO> getBoardList(Criteria cri, int numberSearch) {
//		// TODO Auto-generated method stub
//		return boardMapper.getBoardList(cri, numberSearch);
//	}
	
	@Override
	public List<memberVO> getmemberList(Criteria cri) {
		// TODO Auto-generated method stub
		return memberMapper.getmemberList(cri);
	}

	//2. ����
	@Override
	public int deleteMember(int member_Id) {
		// TODO Auto-generated method stub
		return memberMapper.deleteMember(member_Id);
	}

	@Override
	public int insertMember(memberVO insertDatas) {
		// TODO Auto-generated method stub
		return memberMapper.insertMember(insertDatas);
	}

	@Override
	public List<memberVO> getModifyList(int member_Id) {
		// TODO Auto-generated method stub
		return memberMapper.getModifyList(member_Id);
	}

	@Override
	public int memberModify(memberVO modifyDatas) {
		// TODO Auto-generated method stub
		return memberMapper.memberModify(modifyDatas);
	}

	@Override
	public int getTotalCnt(Criteria cri) {
		// TODO Auto-generated method stub
		return memberMapper.getTotalCnt(cri);
	}

	@Override
	public boolean selectId(String member_Tel) {
		// TODO Auto-generated method stub
		return memberMapper.selectId(member_Tel);
	}

	@Override
	public int member_Tel_ck(String member_Tel) {
		// TODO Auto-generated method stub
		return memberMapper.member_Tel_ck(member_Tel);
	}

	@Override
	public List<memberVO> searchmemberList(Criteria cri) {
		// TODO Auto-generated method stub
		return memberMapper.searchmemberList(cri);
	}

}
