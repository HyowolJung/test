package com.jmh.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;

import com.jmh.vo.BoardVO;
import com.jmh.vo.Criteria;

@Service
public interface BoardService {

	//1. 조회
	public List<BoardVO> getBoardList(@Param("cri") Criteria cri, @Param("numberSearch") int numberSearch);
	//public List<BoardVO> getBoardList(Criteria cri);
	
	//2. 삭제
	public int delete(int checkNum);

	//3. 삽입
	public int insertB(@Param("BType") String BType, @Param("BTitle") String BTitle, @Param("BContent") String BContent);

	//4. 상세
	public List<BoardVO> getModifyList(int bno);
	
	//5. 수정
	public int modifyB(@Param("BNO") int BNO, @Param("BType") String BType, @Param("BTitle") String BTitle, @Param("BContent") String BContent);

	public int getTotalCnt(Criteria cri);

}
