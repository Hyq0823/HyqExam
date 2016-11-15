package com.hyq.vo;

/**
 * 用户封装后台 两个不同类的参数查询
 * @author HYQ
 *
 */
public class UserRole2 {
	private Integer roleId;
	private String truename;
	
	
	
	
	
	public UserRole2(Integer roleId, String truename) {
		super();
		this.roleId = roleId;
		this.truename = truename;
	}
	public UserRole2() {
		super();
	}
	public Integer getRoleId() {
		return roleId;
	}
	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}
	public String getTruename() {
		return truename;
	}
	public void setTruename(String truename) {
		this.truename = truename;
	}
	
	

}
