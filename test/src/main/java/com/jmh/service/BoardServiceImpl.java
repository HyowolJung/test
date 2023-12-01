package com.jmh.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jmh.mapper.BoardMapper;
import com.jmh.vo.BoardVO;

@Service
public class BoardServiceImpl implements BoardService{

	@Autowired
	BoardMapper boardMapper;
	
	//1. 조회
	@Override
	public List<BoardVO> getBoardList() {
		// TODO Auto-generated method stub
		return boardMapper.getBoardList();
	}

	//2. 삭제
	@Override
	public int delete(int checkNum) {
		// TODO Auto-generated method stub
		return boardMapper.delete(checkNum);
	}

	@Override
	public int insertB(String BType, String BTitle, String BContent) {
		// TODO Auto-generated method stub
		return boardMapper.insertB(BType, BTitle, BContent);
	}

	@Override
	public List<BoardVO> getModifyList(int checkNum) {
		// TODO Auto-generated method stub
		return boardMapper.getModifyList(checkNum);
	}

}
