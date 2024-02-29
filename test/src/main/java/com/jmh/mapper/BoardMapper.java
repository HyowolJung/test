package com.jmh.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.jmh.dto.BoardDto;

@Repository
public interface BoardMapper {

	//1. 게시글 등록
	int insertBoard(BoardDto boardForm);

	//2. 자유게시글 목록 불러오기
	List<BoardDto> getFreeBoardList();

	List<BoardDto> selectFreeBoardList(String board_Title);

}
