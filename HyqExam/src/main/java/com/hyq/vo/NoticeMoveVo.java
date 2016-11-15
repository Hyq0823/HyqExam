package com.hyq.vo;

/**
 * 用于公告移动的VO
 * @author HYQ
 *
 */
public class NoticeMoveVo {
	private Integer id;
	private Integer position;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getPosition() {
		return position;
	}
	public void setPosition(Integer position) {
		this.position = position;
	}
	public NoticeMoveVo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public NoticeMoveVo(Integer id, Integer position) {
		super();
		this.id = id;
		this.position = position;
	}
	
	
	
	
}
