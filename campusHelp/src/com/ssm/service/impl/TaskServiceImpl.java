package com.ssm.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ssm.mapper.TaskMapper;
import com.ssm.po.Task;
import com.ssm.service.TaskService;


@Service("taskService")
public class TaskServiceImpl implements TaskService{
	
	@Resource(name="taskMapper")
	private TaskMapper taskMapper;

	@Override
	public List<Task> getAllTask() {
		
		return taskMapper.selectAllTask();
	}

	@Override
	public int setNewTask(Task task) {
		return taskMapper.insert(task);
	}

	@Override
	public List<Task> getUserTask(Integer stuid) {
		return taskMapper.selectUserTask(stuid);
	}

	@Override
	public Task getTask(Integer tid) {
		return taskMapper.selectByPrimaryKey(tid);
	}

	@Override
	public int updateTask(Task task) {
		return taskMapper.updateByPrimaryKeySelective(task);
	}

	@Override
	public List<Task> getUserATask(Integer stuid) {
		return taskMapper.selectUserATask(stuid);
	}

	@Override
	public List<Task> getTaskByKeys(String words, Integer schoolid) {
		// TODO Auto-generated method stub
		return taskMapper.selectTaskByKeys(words, schoolid);
	}

	@Override
	public List<Task> getTaskByKeysNoState(String words, Integer schoolid) {
		// TODO Auto-generated method stub
		return taskMapper.selectTaskByKeysNoState(words, schoolid);
	}
	
	
}
