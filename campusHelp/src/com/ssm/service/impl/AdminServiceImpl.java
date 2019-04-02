package com.ssm.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ssm.mapper.AdminMapper;
import com.ssm.po.Admin;
import com.ssm.service.AdminService;


@Service("adminService")
public class AdminServiceImpl implements AdminService{
	
	@Resource(name="adminMapper")
	private AdminMapper adminMapper;

	@Override
	public int getAccountCount(String account) {
		return adminMapper.selectAccountCount(account);
	}

	@Override
	public Admin getAdminByAccount(String account) {
		return adminMapper.selectAdminByAccount(account);
	}

	@Override
	public int updateAdminInfo(Admin admin) {
		int result = 0;
		try {
			result = adminMapper.updateByPrimaryKeySelective(admin);
		} catch (Exception e) {
			
		}
		return result;
	}

	@Override
	public Admin login(String account) {
		Admin admin = null;
		admin = adminMapper.selectAdminByAccount(account);
		return admin;
	}

	@Override
	public int setAdmin(Admin admin) {
		int result = 0;
		try {
			result = adminMapper.insert(admin);
		} catch (Exception e) {
		}
		return result;
	}

	
	
	
	
}
