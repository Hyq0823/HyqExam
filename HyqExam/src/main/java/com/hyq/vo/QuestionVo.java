package com.hyq.vo;

public class QuestionVo {
	private Integer id;
	private Integer typeId;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getTypeId() {
		return typeId;
	}
	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}
	public QuestionVo() {
		super();
	}
	public QuestionVo(Integer id, Integer typeId) {
		super();
		this.id = id;
		this.typeId = typeId;
	}
	
	
	
	
	

}
