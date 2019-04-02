package com.ssm.po;

import java.util.Date;

public class User {
    private Integer stuid;

    private String studentid;

    private String password;

    private Integer schoolid;

    private Integer sex;

    private String name;

    private Date registertime;

    private Double money;

    private Integer state;

    public User() {
		super();
	}

	public User(Integer stuid, String studentid, String password, Integer schoolid, Integer sex, String name,
			Date registertime, Double money, Integer state) {
		super();
		this.stuid = stuid;
		this.studentid = studentid;
		this.password = password;
		this.schoolid = schoolid;
		this.sex = sex;
		this.name = name;
		this.registertime = registertime;
		this.money = money;
		this.state = state;
	}

	public Integer getStuid() {
        return stuid;
    }

    public void setStuid(Integer stuid) {
        this.stuid = stuid;
    }

    public String getStudentid() {
        return studentid;
    }

    public void setStudentid(String studentid) {
        this.studentid = studentid;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Integer getSchoolid() {
        return schoolid;
    }

    public void setSchoolid(Integer schoolid) {
        this.schoolid = schoolid;
    }

    public Integer getSex() {
        return sex;
    }

    public void setSex(Integer sex) {
        this.sex = sex;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getRegistertime() {
        return registertime;
    }

    public void setRegistertime(Date registertime) {
        this.registertime = registertime;
    }

    public Double getMoney() {
        return money;
    }

    public void setMoney(Double money) {
        this.money = money;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

	@Override
	public String toString() {
		return "User [stuid=" + stuid + ", studentid=" + studentid + ", password=" + password + ", schoolid=" + schoolid
				+ ", sex=" + sex + ", name=" + name + ", registertime=" + registertime + ", money=" + money + ", state="
				+ state + "]";
	}
    
    
}