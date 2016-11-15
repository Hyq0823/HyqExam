package com.hyq.domain;

/**
 * 基类问题 实体
 * @author HYQ
 *
 */
public class BaseQuestion {
	private Integer id; //题目id
	private String title; //题目标题
	private String level; //难易程度
	private String answerAnalysis; //答案解析
	
	//外键字段
	private String point; //知识点id
	private Integer typeId; //题目类型id
	
	
	
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public Integer getTypeId() {
		return typeId;
	}
	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}
	public String getAnswerAnalysis() {
		return answerAnalysis;
	}
	public void setAnswerAnalysis(String answerAnalysis) {
		this.answerAnalysis = answerAnalysis;
	}
	public String getPoint() {
		return point;
	}
	public void setPoint(String point) {
		this.point = point;
	}
	
	
	
	

}
