package com.jmh.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jmh.dto.BoardDto;
import com.jmh.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService{

	@Autowired
	BoardMapper boardMapper;
	
	@Override
	public int insertBoard(BoardDto boardForm) {
		// TODO Auto-generated method stub
		return boardMapper.insertBoard(boardForm);
	}

	@Override
	public List<BoardDto> getFreeBoardList() {
		// TODO Auto-generated method stub
		return boardMapper.getFreeBoardList();
	}

}
