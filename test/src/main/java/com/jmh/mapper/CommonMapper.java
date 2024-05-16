package com.jmh.mapper;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface CommonMapper {

	public int getMemberPwDB(@Param("memberId") int memberId, @Param("memberPw") String memberPw); 

}
