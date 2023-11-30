package com.jmh.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.jmh.vo.BoardVO;

@Repository
public interface BoardMapper {

	List<BoardVO> getBoardList();

}
