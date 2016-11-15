package com.hyq.mapper;

import java.util.List;
import java.util.Map;

import com.hyq.domain.Notice;
import com.hyq.domain.Role;
import com.hyq.domain.User;
import com.hyq.domain.UserRole;
import com.hyq.vo.UserRole2;
import com.hyq.vo.User_Role;

public interface RoleMapper {
	
	
	Integer getTotalRecord();
	
	public List<Notice> findByMap(Map<String, Object> map);

	Integer addRole(Role role);

	void deleteById(Integer id);

	Integer updateRole(Role role);
	
	Integer checkIsSetRole(User_Role user_role);
	
	void setUserRole(User_Role user_role);
	
	void updateUserRole(User_Role user_role);
	
	List<Role> findExistRoleList();

	List<User> getAllAdminList();
	
}
