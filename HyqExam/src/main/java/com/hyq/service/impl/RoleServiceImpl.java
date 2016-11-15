package com.hyq.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hyq.domain.Notice;
import com.hyq.domain.Role;
import com.hyq.domain.User;
import com.hyq.domain.UserRole;
import com.hyq.mapper.RoleMapper;
import com.hyq.service.RoleService;
import com.hyq.vo.User_Role;

@Service
public class RoleServiceImpl implements RoleService
{
	@Autowired
	private RoleMapper roleMapper;

	@Override
	public Integer getTotalRecord() {
		return roleMapper.getTotalRecord();
	}

	@Override
	public List<Notice> findByMap(Map<String, Object> map) {
		return roleMapper.findByMap(map);
	}

	@Override
	public Integer addRole(Role role) {
		return roleMapper.addRole(role);
	}

	@Override
	public void deleteById(Integer id) {
		roleMapper.deleteById(id);
	}

	@Override
	public Integer updateRole(Role role) {
		return roleMapper.updateRole(role);
	}

	@Override
	public Integer checkIsSetRole(User_Role user_role) {
		return roleMapper.checkIsSetRole(user_role);
	}

	@Override
	public void setUserRole(User_Role user_role) {
		roleMapper.setUserRole(user_role);
	}

	@Override
	public void updateUserRole(User_Role user_role) {
		roleMapper.updateUserRole(user_role);
	}

	@Override
	public List<Role> findExistRoleList() {
		return roleMapper.findExistRoleList();
	}

	@Override
	public List<User> getAllAdminList() {
		return roleMapper.getAllAdminList();
	}


}
