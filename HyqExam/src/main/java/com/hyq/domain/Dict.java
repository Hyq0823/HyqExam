package com.hyq.domain;
/**
 * 字典
 * @author hyq
 *
 */
public class Dict {
	private String id;
	private String name;//名称（博士  研究生）
	private String value;//值(1  2)
	private String description;//描述(学历)
	private String type; //类型（edu_type）
	
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	
	

}
