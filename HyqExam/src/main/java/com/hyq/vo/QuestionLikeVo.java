package com.hyq.vo;

public class QuestionLikeVo {
	private Integer typeId;
	private String level;
	private String point ;
	
	
	
	
	
	public QuestionLikeVo(String level, String point) {
		super();
		this.level = level;
		this.point = point;
	}
	public QuestionLikeVo(Integer typeId, String level, String point) {
		super();
		this.typeId = typeId;
		this.level = level;
		this.point = point;
	}
	public QuestionLikeVo() {
		super();
	}
	public Integer getTypeId() {
		return typeId;
	}
	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getPoint() {
		return point;
	}
	public void setPoint(String point) {
		this.point = point;
	}
	
	
	

}
