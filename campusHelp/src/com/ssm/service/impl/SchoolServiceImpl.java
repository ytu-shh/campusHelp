package com.ssm.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ssm.mapper.SchoolMapper;
import com.ssm.po.School;
import com.ssm.service.SchoolService;


@Service("schoolService")
public class SchoolServiceImpl implements SchoolService{
	
	@Resource(name="schoolMapper")
	private SchoolMapper schoolMapper;

	@Override
	public List<School> getAllSchools() {
		
		return schoolMapper.selectAllSchools();
	}

	@Override
	public School getSchoolByID(Integer schoolid) {
		return schoolMapper.selectByPrimaryKey(schoolid);
	}

	@Override
	public int updateSchool(School school) {
		return schoolMapper.updateByPrimaryKeySelective(school);
	}

	@Override
	public List<School> getAllSchoolsNoState() {
		return schoolMapper.selectAllSchoolsNoState();
	}

	@Override
	public int setSchool(School school) {
		
		return schoolMapper.insert(school);
	}
	
	
}
