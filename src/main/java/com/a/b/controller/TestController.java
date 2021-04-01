package com.a.b.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.a.b.model.service.TestService;
import com.a.b.model.vo.TestVo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class TestController {

	@Autowired
	private TestService service;

	// 게시판 페이지
	@RequestMapping("/")
	public ModelAndView test() {
		log.info("메인 화면");
		ModelAndView mv = new ModelAndView("index");
		List<TestVo> vo = service.getBoard();

		for (TestVo v : vo) {
			log.info("" + v);
		}
		mv.addObject("boardList", vo);
		return mv;
	}

	// 게시글 작성 페이지
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public ModelAndView writeBoard() {
		log.info("게시글 작성");
		ModelAndView mv = new ModelAndView("write");
		return mv;
	}

	// 게시글 작성 완료페이지
	@ResponseBody
	@RequestMapping(value = "/writeEnd", method = RequestMethod.POST)
	public String writeEndBoard(String title, String content) {
		log.info("게시글 작성 완료");
		log.info("title : " + title + ", content : " + content);
		int result = 0;
		TestVo tv = new TestVo();
		tv.setTitle(title);
		tv.setContent(content);
		result = service.createBoard(tv);

		if (result > 0) {
			return "1";
		}
		return "0";
	}

	// 게시글 상세 페이지
	@RequestMapping(value = "/pageView", method = RequestMethod.GET)
	public ModelAndView pageViewBoard(int id) {
		log.info("게시글 상세 보기");
		log.info("num : " + id);
		ModelAndView mv = new ModelAndView("pageView");
		TestVo bp = service.selectBoardPage(id);
		log.info("bp : " + bp);
		mv.addObject("boardPage", bp);
		return mv;
	}

	// 게시글 수정 완료페이지
	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String updateBoard(String title, String content, int id) {
		log.info("게시글 수정 완료");
		log.info("title : " + title + ", content : " + content);
		int result = 0;
		TestVo tv = new TestVo();
		tv.setTitle(title);
		tv.setContent(content);
		tv.setId(id);
		result = service.updateBoard(tv);

		if (result > 0) {
			return "1";
		}
		return "0";
	}

	// 게시글 삭제 완료페이지
	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String delete(int id) {
		log.info("게시글 삭제 완료");
		log.info("id : " + id);
		int result = 0;
		result = service.deleteBoard(id);

		if (result > 0) {
			return "1";
		}
		return "0";
	}

}
