package com.hyq.domain;

public class Privilege {
	private Integer id;
	private String name;
	private String url;
	private Integer parentId;
	
	
	
	
	

	
	
//====================================================================================
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public Integer getParentId() {
		return parentId;
	}
	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}
	@Override
	public String toString() {
		return "Privilege [id=" + id + ", name=" + name + ", url=" + url
				+ ", parentId=" + parentId + "]";
	}
	
	
	
	
	
	

}
