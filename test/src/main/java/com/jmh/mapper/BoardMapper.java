package com.jmh.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.PathVariable;

import com.jmh.vo.BoardVO;
import com.jmh.vo.Criteria;

@Repository
public interface BoardMapper {

	//1. ��ȸ
	//List<BoardVO> getBoardList(@Param("cri") Criteria cri, @Param("numberSearch") int numberSearch);
	List<BoardVO> getBoardList(Criteria cri);
	
	//2. ����
	int delete(int checkNum);

	//3. ����
	int insertB(@Param("BType") String BType, @Param("BTitle") String BTitle, @Param("BContent") String BContent);

	//4. ��
	List<BoardVO> getModifyList(int bno);

	//5. ����
	int modifyB(@Param("BNO") int BNO, @Param("BType") String BType, @Param("BTitle") String BTitle, @Param("BContent") String BContent);

	//6. 
	int getTotalCnt(Criteria cri);
	
}
