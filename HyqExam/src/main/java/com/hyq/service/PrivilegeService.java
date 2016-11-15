package com.hyq.service;

import java.util.List;

import com.hyq.domain.Privilege;
import com.hyq.vo.Role_Privilege;

public interface PrivilegeService {

	/**
	 * 查找顶级权限
	 * @return
	 */
	List<Privilege> findTopPrivilege();

	List<Privilege> finChildPrivilegeList(Integer parentId);

	/**
	 * 为角色分配权限
	 * @param privilegeId
	 * @param roleId
	 * //要先判断是否已经存在了对应的角色关系
			//如果存在就修改
			//如果不存在就添加
			 * 
			 * 这里偷个懒，直接把已有的关系全部删除，添加本次的就行，这样就只需要做一个添加的动作，而不用判断到底是更新还是添加。
	 */
	void assistPrivilege4Role(Role_Privilege rp);

	void applyPrivilege4Role(String ids, Integer roleId);

	List<Privilege> findPrivilegeListByRoleId(Integer roleId);
	
	void deleteAllByRoleId(Integer roleId);

	/**
	 * 获取所有权限的url
	 * @return
	 */
	List<String> getAllUrl();

	/**
	 * 获取一个用户的所有权限  url
	 * 用户表-角色表-权限表
	 * @param userId
	 * @return
	 */
	List<String> getUsersPrivilegeUrlByUserId(String userId);

}
