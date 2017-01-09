package com.hyq.mapper;

import java.util.List;
import java.util.Map;

import com.hyq.domain.User;
import com.hyq.vo.CountAndUserIdsVo;
import com.hyq.vo.UserRole2;
import com.hyq.vo.User_Role;



public interface UserMapper {
	
	/**
	 * 插入一条记录
	 * @param user
	 * @throws Exception
	 */
	public void insertUser(User user)throws Exception;

	/**
	 * 登录用户
	 * @param user
	 * @return
	 * @throws Exception
	 */
	public User getUserInfo(User user)throws Exception;

	
	/**
	 * 获取用户的详细信息
	 * @param currentUser   含username和password
	 * @return
	 */
	public User getUserDetailInfo(User currentUser);

	/**
	 * 保存用户基本信息
	 * @param user
	 */
	public void saveBaseInfo(User user);

	/**
	 * 通过userID获取这个user的简历（全部信息）
	 * @param userId
	 * @return
	 */
	public User getUseDetailrById(String userId);
	
	
	public List<User> findAll();

	public Integer getTotalRecord();
	public List<User> findByMap(Map<String, Integer> map);
	

	public void updateUserBaseInfo(User_Role user_role);
	
	public List<User> getTotalRecordByRoleVo(UserRole2 role);
	
	public void saveInfoByAdmin(User user);
	
	public void deleteById(String id);

	public User getUserByOpenId(String openId);
	

}
