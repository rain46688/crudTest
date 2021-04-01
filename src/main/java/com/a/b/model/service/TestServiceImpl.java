package com.a.b.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.a.b.model.dao.TestMapper;
import com.a.b.model.vo.TestVo;

@Service
public class TestServiceImpl implements TestService {

	@Autowired
	private TestMapper mapper;

	@Override
	public List<TestVo> getBoard() {
		// TODO Auto-generated method stub
		return mapper.getBoard();
	}

	@Override
	public int createBoard(TestVo vo) {
		// TODO Auto-generated method stub
		return mapper.createBoard(vo);
	}

	@Override
	public TestVo selectBoardPage(int id) {
		// TODO Auto-generated method stub
		return mapper.selectBoardPage(id);
	}

	@Override
	public int updateBoard(TestVo tv) {
		// TODO Auto-generated method stub
		return mapper.updateBoard(tv);
	}

	@Override
	public int deleteBoard(int id) {
		// TODO Auto-generated method stub
		return mapper.deleteBoard(id);
	}

}
