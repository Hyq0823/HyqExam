package com.hyq.service;

import java.util.List;
import java.util.Map;

import com.hyq.domain.Notice;
import com.hyq.domain.Role;
import com.hyq.domain.User;
import com.hyq.vo.User_Role;
public interface RoleService{

	Integer getTotalRecord();

	List<Notice> findByMap(Map<String, Object> map);

	Integer addRole(Role role);

	void deleteById(Integer idArr);

	Integer updateRole(Role role);


	Integer checkIsSetRole(User_Role user_role);

	void setUserRole(User_Role user_role);

	void updateUserRole(User_Role user_role);

	/**
	 * 用于后台填充combox的搜索框
	 * @return
	 */
	List<Role> findExistRoleList();

	/**
	 * 获取所有的管理员
	 * @return
	 */
	List<User> getAllAdminList();

}
