package com.jmh.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.jmh.vo.BoardVO;

@Service
public interface BoardService {

	public List<BoardVO> getBoardList();

	
}
