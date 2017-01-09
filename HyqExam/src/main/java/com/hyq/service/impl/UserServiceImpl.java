package com.hyq.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hyq.domain.User;
import com.hyq.mapper.UserMapper;
import com.hyq.service.UserService;
import com.hyq.util.StringUtil;
import com.hyq.vo.CountAndUserIdsVo;
import com.hyq.vo.UserRole2;
import com.hyq.vo.User_Role;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper userMapper;

	@Override
	public void saveUser(User user) throws Exception {
		userMapper.insertUser(user);

	}

	@Override
	public User findUser(User user) throws Exception {
		return userMapper.getUserInfo(user);
	}

	@Override
	public boolean isCompleteInfo(User currentUser) {
		User user = userMapper.getUserDetailInfo(currentUser);
		//如果这些信息为空，则说明用户没有完成详细信息填写
		if(StringUtil.isEmpty(user.getEmail()) || StringUtil.isEmpty(user.getPhone()))
		{
			return false;
		}else
		{
			return true;
		}
				
	}

	@Override
	public void saveBaseInfo(User user) {
		userMapper.saveBaseInfo(user);
	}

	@Override
	public User getUserDetailInfo(User currentUser) {
		return userMapper.getUserDetailInfo(currentUser);
	}

	@Override
	public User getUseDetailrById(String userId) {
		return userMapper.getUseDetailrById(userId);
	}

	@Override
	public List<User> findAll() {
		return userMapper.findAll();
	}

	@Override
	public Integer getTotalRecord() {
		return userMapper.getTotalRecord();
	}

	@Override
	public List<User> findByMap(Map<String, Integer> map) {
		return userMapper.findByMap(map);
	}

	@Override
	public void updateUserBaseInfo(User_Role user_role) {
		userMapper.updateUserBaseInfo(user_role);
	}

	@Override
	public List<User> getTotalRecordByRoleVo(UserRole2 role) {
		return userMapper.getTotalRecordByRoleVo(role);
	}

	@Override
	public void saveInfoByAdmin(User user) {
		 userMapper.saveInfoByAdmin(user);
	}

	@Override
	public void deleteById(String id) {
		userMapper.deleteById(id);
	}

	@Override
	public User getUserByOpenId(String openId) {
		return userMapper.getUserByOpenId(openId);
	}

}
