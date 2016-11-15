package com.hyq.domain;

/**
 * 知识点 实体
 * @author HYQ
 *
 */
public class KnowLegePoint {
	private Integer id;
	
	private String text;
	private String description;
	
	
	private Integer parentId;
	
	
	
	
	
	
	
	public KnowLegePoint() {
		super();
	}
	public KnowLegePoint(Integer id, String text, String description) {
		super();
		this.id = id;
		this.text = text;
		this.description = description;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public Integer getParentId() {
		return parentId;
	}
	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	
	
}
