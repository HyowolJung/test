package com.jmh.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.PathVariable;

import com.jmh.vo.BoardVO;

@Repository
public interface BoardMapper {

	//1. 조회
	List<BoardVO> getBoardList();

	//2. 삭제
	int delete(int checkNum);

	//3. 삽입
	int insertB(@Param("BType") String BType, @Param("BTitle") String BTitle, @Param("BContent") String BContent);

	//4. 수정
	List<BoardVO> getModifyList(int checkNum);

}
