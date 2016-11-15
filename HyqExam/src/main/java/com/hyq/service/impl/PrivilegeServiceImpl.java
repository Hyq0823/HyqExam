package com.hyq.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hyq.domain.Privilege;
import com.hyq.mapper.PrivilegeMapper;
import com.hyq.service.PrivilegeService;
import com.hyq.vo.Role_Privilege;

@Service
public class PrivilegeServiceImpl implements PrivilegeService 
{
	@Autowired
	PrivilegeMapper privilegeMapper;

	@Override
	public List<Privilege> findTopPrivilege() {
		return privilegeMapper.findTopPrivilege();
	}

	@Override
	public List<Privilege> finChildPrivilegeList(Integer parentId) {
		return privilegeMapper.finChildPrivilegeList(parentId);
	}

	@Override
	public void assistPrivilege4Role(Role_Privilege rp) {
		privilegeMapper.assistPrivilege4Role(rp);
	}

	@Override
	public void applyPrivilege4Role(String ids, Integer roleId) {
		
		//首先删除原有的  角色下的所有权限数据
		this.deleteAllByRoleId(roleId);
		
		//每次都重新分配
		String[] idArr = ids.split(",");
		Role_Privilege rp = null;
		for(int i=0;i<idArr.length;i++)
		{
			rp = new Role_Privilege(roleId, Integer.parseInt(idArr[i]));
			this.assistPrivilege4Role(rp);
		}
		
	}

	@Override
	public List<Privilege> findPrivilegeListByRoleId(Integer roleId) {
		return privilegeMapper.findPrivilegeListByRoleId(roleId);
	}

	@Override
	public void deleteAllByRoleId(Integer roleId) {
		 privilegeMapper.deleteAllByRoleId(roleId);
	}

	@Override
	public List<String> getAllUrl() {
		return privilegeMapper.getAllUrl();
	}

	@Override
	public List<String> getUsersPrivilegeUrlByUserId(String userId) {
		return privilegeMapper.getUsersPrivilegeUrlByUserId(userId);
	}

}
