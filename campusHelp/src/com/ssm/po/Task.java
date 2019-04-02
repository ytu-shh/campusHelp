package com.ssm.po;

import java.util.Date;

public class Task {
    private Integer taskid;

    private String publishUserId;

    private String publishUserName;

    private Integer publishSchoolId;

    private Integer acceptUserId;

    private Double reward;

    private Date addtime;

    private Date endtime;

    private String taskname;

    private String taskcontext;

    private Integer state;

    public Task() {
		super();
	}

	public Task(Integer taskid, String publishUserId, String publishUserName, Integer publishSchoolId,
			Integer acceptUserId, Double reward, Date addtime, Date endtime, String taskname, String taskcontext,
			Integer state) {
		super();
		this.taskid = taskid;
		this.publishUserId = publishUserId;
		this.publishUserName = publishUserName;
		this.publishSchoolId = publishSchoolId;
		this.acceptUserId = acceptUserId;
		this.reward = reward;
		this.addtime = addtime;
		this.endtime = endtime;
		this.taskname = taskname;
		this.taskcontext = taskcontext;
		this.state = state;
	}

	public Integer getTaskid() {
        return taskid;
    }

    public void setTaskid(Integer taskid) {
        this.taskid = taskid;
    }

    public String getPublishUserId() {
        return publishUserId;
    }

    public void setPublishUserId(String publishUserId) {
        this.publishUserId = publishUserId;
    }

    public String getPublishUserName() {
        return publishUserName;
    }

    public void setPublishUserName(String publishUserName) {
        this.publishUserName = publishUserName;
    }

    public Integer getPublishSchoolId() {
        return publishSchoolId;
    }

    public void setPublishSchoolId(Integer publishSchoolId) {
        this.publishSchoolId = publishSchoolId;
    }

    public Integer getAcceptUserId() {
        return acceptUserId;
    }

    public void setAcceptUserId(Integer acceptUserId) {
        this.acceptUserId = acceptUserId;
    }

    public Double getReward() {
        return reward;
    }

    public void setReward(Double reward) {
        this.reward = reward;
    }

    public Date getAddtime() {
        return addtime;
    }

    public void setAddtime(Date addtime) {
        this.addtime = addtime;
    }

    public Date getEndtime() {
        return endtime;
    }

    public void setEndtime(Date endtime) {
        this.endtime = endtime;
    }

    public String getTaskname() {
        return taskname;
    }

    public void setTaskname(String taskname) {
        this.taskname = taskname;
    }

    public String getTaskcontext() {
        return taskcontext;
    }

    public void setTaskcontext(String taskcontext) {
        this.taskcontext = taskcontext;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

	@Override
	public String toString() {
		return "Task [taskid=" + taskid + ", publishUserId=" + publishUserId + ", publishUserName=" + publishUserName
				+ ", publishSchoolId=" + publishSchoolId + ", acceptUserId=" + acceptUserId + ", reward=" + reward
				+ ", addtime=" + addtime + ", endtime=" + endtime + ", taskname=" + taskname + ", taskcontext="
				+ taskcontext + ", state=" + state + "]";
	}
    
    
}