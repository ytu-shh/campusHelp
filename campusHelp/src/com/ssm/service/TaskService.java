package com.ssm.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ssm.po.Task;

public interface TaskService {
	
	/**
	 * 读取全部任务
	 * @return
	 */
	public List<Task> getAllTask();
	
	/**
	 * 添加新任务
	 * @param task
	 * @return
	 */
	public int setNewTask(Task task);
	
	/**
	 * 读取某用户全部任务
	 * @return
	 */
	public List<Task> getUserTask(Integer stuid);
	
	/**
	 * 读取某用户接受任务
	 * @return
	 */
	public List<Task> getUserATask(Integer stuid);
	
	/**
	 * 读取1个任务
	 * @return
	 */
	public Task getTask(Integer tid);
	
	/**
	 * 更新任务
	 * @param task
	 * @return
	 */
	public int updateTask(Task task);
	
	/**
     * selectTaskByKeys
     * @param 
     * @return
     */
    public List<Task> getTaskByKeys(String words,Integer schoolid);
    
    /**
     * selectTaskByKeysNoState
     * @param 
     * @return
     */
    public List<Task> getTaskByKeysNoState(@Param("words")String words,@Param("schoolid")Integer schoolid);
	
}
