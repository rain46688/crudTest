package com.a.b.model.vo;

import java.sql.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class TestVo {

	private int id;
	private String title;
	private String writer_id;
	private String content;
	private Date regdate;
	private int hit;

}
