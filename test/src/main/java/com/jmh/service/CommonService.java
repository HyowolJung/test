package com.jmh.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import com.jmh.dto.MemberDto;

public interface CommonService {
	//0. 로그인
	public List<MemberDto> login(@Param("memberId") int memberId, @Param("memberPw") String memberPw);
}
