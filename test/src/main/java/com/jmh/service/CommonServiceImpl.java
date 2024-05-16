package com.jmh.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Service;

import com.jmh.dto.MemberDto;
import com.jmh.mapper.CommonMapper;

@Service
public class CommonServiceImpl implements CommonService{
	@Autowired
	CommonMapper commonMapper;
		
	@Override
	public List<MemberDto> login(int memberId, String memberPw) {
		if(!isValidPw(memberId, memberPw)) {
			
			return null;
		}
		
		// TODO Auto-generated method stub
		return null;
	}
	
	public boolean isValidPw(int memberId, String memberPw) {
		//getMemberPwDB 에 굳이 memberPw 를 전송해줄 필요가 있을까??
		int MemberPwDB = commonMapper.getMemberPwDB(memberId, memberPw);
		System.err.println("MemberPwDBMemberPwDB : " + MemberPwDB);
		if(MemberPwDB > 0) {
			System.err.println("여기는 1");
			System.err.println("if(MemberPwDB == true) : " + MemberPwDB);
			return true;
		} else if(MemberPwDB  < 0) {
			System.err.println("여기는 0");
			System.err.println("if(MemberPwDB == true) : " + MemberPwDB);
			return false;
		}
		//System.err.println("isValidPw(int memberId, String memberPw) : " + memberId + memberPw);
		return false;
		
	}
	
}
