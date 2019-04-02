package com.ssm.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ssm.mapper.UserMapper;
import com.ssm.po.User;
import com.ssm.service.UserService;

/**
 * @Service  默认bean名称userServiceImpl
 * @author Administrator
 */
@Service("userService")
public class UserServiceImpl implements UserService{
	
	@Resource(name="userMapper")
	private UserMapper userMapper;
	
	@Override
	public int setUser(User record) {
		int result = 0;
		try {
			result = userMapper.insert(record);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public int getAccountCount(String account) {
		int result = 0;
		result = userMapper.selectAccountCount(account);
		return result;
	}

	@Override
	public User login(String account) {
		User user = null;
		user = userMapper.selectUserByAccount(account);
		return user;
	}

	@Override
	public int updateUserInfo(User user) {
		int result = 0;
		try {
			result = userMapper.updateByPrimaryKeySelective(user);
		} catch (Exception e) {
			
		}
		return result;
	}

	@Override
	public List<User> getByLikeNameAccount(String words) {
		List<User> list = null;
		list = userMapper.selectByLikeNameAccount(words);
		return list;
	}

	@Override
	public User getByUid(Integer uid) {
		User user = null;
		user = userMapper.selectByPrimaryKey(uid);
		return user;
	}
	
}
