package com.a.b.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.a.b.model.vo.TestVo;

@Mapper
public interface TestMapper {

	// 게시판 불러오기
	@Select("SELECT * FROM NOTICE")
	List<TestVo> getBoard();

	// 게시판 글 작성하기
	@Insert("INSERT INTO NOTICE VALUES(NOTICE_ID_SEQ.nextval,#{title},'CMS',#{content},DEFAULT,DEFAULT,DEFAULT,DEFAULT)")
	int createBoard(TestVo vo);

	// 게시판 상세 페이지 불러오기
	@Select("SELECT * FROM NOTICE WHERE ID = #{id}")
	TestVo selectBoardPage(int id);

	// 게시판 수정
	@Update("UPDATE NOTICE SET TITLE = #{title}, CONTENT = #{content} WHERE ID = #{id}")
	int updateBoard(TestVo tv);

	// 게시판 삭제
	@Delete("DELETE FROM NOTICE WHERE ID = #{id}")
	int deleteBoard(int id);

}
