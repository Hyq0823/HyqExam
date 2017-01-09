package com.hyq.service;

import java.util.List;
import java.util.Map;

import com.hyq.domain.User;
import com.hyq.vo.CountAndUserIdsVo;
import com.hyq.vo.UserRole2;
import com.hyq.vo.User_Role;


public interface UserService {
	/**
	 * 保存一个用户
	 * @param user
	 * @throws Exception
	 */
	public void saveUser(User user)throws Exception;

	/**
	 * 登录用户
	 * @param user
	 * @return
	 * @throws Exception
	 */
	public User findUser(User user)throws Exception;

	/**
	 * 检测用户是否填写了详细信息
	 * @param currentUser
	 * @return
	 */
	public boolean isCompleteInfo(User currentUser);

	/**
	 * 保存用户的基本信息
	 * @param user
	 */
	public void saveBaseInfo(User user);
	
	
	/**
	 * 获取用户的详细信息
	 * @param currentUser   含username和password
	 * @return
	 */
	public User getUserDetailInfo(User currentUser);

	/**
	 * 获取用户的简历--即是所有信息
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
