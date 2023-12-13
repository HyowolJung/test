package com.jmh.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.PathVariable;

import com.jmh.vo.memberVO;
import com.jmh.vo.Criteria;

@Repository
public interface MemberMapper {

	//1. 
	//List<BoardVO> getBoardList(@Param("cri") Criteria cri, @Param("numberSearch") int numberSearch);
	List<memberVO> getmemberList(Criteria cri);
	
	//2. ����
	int deleteMember(int member_Id);

	//3. ����
	int insertMember(memberVO insertDatas);

	//4. ��
	List<memberVO> getModifyList(int member_Id);

	//5. ����
	int memberModify(memberVO modifyDatas);

	//6. 
	int getTotalCnt(Criteria cri);

	boolean selectId(String member_Tel);

	int member_Tel_ck(String member_Tel);

	List<memberVO> searchmemberList(Criteria cri);
	
}
