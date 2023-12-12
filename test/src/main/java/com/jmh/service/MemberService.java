package com.jmh.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;

import com.jmh.vo.memberVO;
import com.jmh.vo.Criteria;

@Service
public interface MemberService {

	//public List<BoardVO> getBoardList(@Param("cri") Criteria cri, @Param("numberSearch") int numberSearch);
	public List<memberVO> getmemberList(Criteria cri);
	public int insertMember(memberVO insertDatas);
	
	public int deleteMember(String member_Id);

	//public int insertB(@Param("BType") String BType, @Param("BTitle") String BTitle, @Param("BContent") String BContent);

	public List<memberVO> getModifyList(String member_Id);
	
	public int memberModify(memberVO modifyDatas);

	public int getTotalCnt(Criteria cri);
	
	public boolean selectId(String member_Tel);
	public int member_Tel_ck(String member_Tel);

}
