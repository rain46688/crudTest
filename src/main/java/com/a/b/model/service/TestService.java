package com.a.b.model.service;

import java.util.List;

import com.a.b.model.vo.TestVo;

public interface TestService {

	List<TestVo> getBoard();

	int createBoard(TestVo tv);

	TestVo selectBoardPage(int id);

	int updateBoard(TestVo tv);

	int deleteBoard(int id);

}
