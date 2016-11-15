package com.hyq.mapper;

import java.util.List;

import com.hyq.domain.Privilege;
import com.hyq.vo.Role_Privilege;

public interface PrivilegeMapper {

	List<Privilege> findTopPrivilege();

	List<Privilege> finChildPrivilegeList(Integer id);
	
	void assistPrivilege4Role(Role_Privilege rp);
	
	List<Privilege> findPrivilegeListByRoleId(Integer roleId);

	void deleteAllByRoleId(Integer roleId);

	List<String> getAllUrl();
	
	List<String> getUsersPrivilegeUrlByUserId(String userId);
	

}
