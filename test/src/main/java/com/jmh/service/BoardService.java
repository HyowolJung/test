package com.jmh.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;

import com.jmh.vo.BoardVO;

@Service
public interface BoardService {

	//1. 조회
	public List<BoardVO> getBoardList();
	
	//2. 삭제
	public int delete(int checkNum);

	//3. 삽입
	public int insertB(@Param("BType") String BType, @Param("BTitle") String BTitle, @Param("BContent") String BContent);

	//4. 수정
	public List<BoardVO> getModifyList(int checkNum);

}
