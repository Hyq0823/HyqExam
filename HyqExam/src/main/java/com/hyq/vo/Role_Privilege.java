package com.hyq.vo;

public class Role_Privilege {
	private Integer roleId;
	private Integer privilegeId;
	
	
	
	
	
	
	
	
	
	public Role_Privilege() {
		super();
	}
	public Role_Privilege(Integer roleId, Integer privilegeId) {
		super();
		this.roleId = roleId;
		this.privilegeId = privilegeId;
	}
	public Integer getRoleId() {
		return roleId;
	}
	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}
	public Integer getPrivilegeId() {
		return privilegeId;
	}
	public void setPrivilegeId(Integer privilegeId) {
		this.privilegeId = privilegeId;
	}
	
	
	
	

}
