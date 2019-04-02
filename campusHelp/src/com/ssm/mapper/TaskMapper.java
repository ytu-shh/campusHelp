package com.ssm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ssm.po.Task;

public interface TaskMapper {
    int deleteByPrimaryKey(Integer taskid);

    int insert(Task record);

    int insertSelective(Task record);

    Task selectByPrimaryKey(Integer taskid);

    int updateByPrimaryKeySelective(Task record);

    int updateByPrimaryKey(Task record);
    
    /**
	 * 读取全部任务
	 * @return
	 */
	public List<Task> selectAllTask();
	
	/**
	 * 读取某用户发布的任务
	 * @return
	 */
	public List<Task> selectUserTask(Integer stuid);
	
	/**
	 * 读取某用户接受任务
	 * @return
	 */
	public List<Task> selectUserATask(Integer stuid);
	
	/**
     * selectTaskByKeys
     * @param 
     * @return
     */
    public List<Task> selectTaskByKeys(@Param("words")String words,@Param("schoolid")Integer schoolid);
    
    /**
     * selectTaskByKeysNoState
     * @param 
     * @return
     */
    public List<Task> selectTaskByKeysNoState(@Param("words")String words,@Param("schoolid")Integer schoolid);
}