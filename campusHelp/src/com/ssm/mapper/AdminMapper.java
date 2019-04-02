package com.ssm.mapper;

import org.apache.ibatis.annotations.Param;

import com.ssm.po.Admin;

public interface AdminMapper {
    int deleteByPrimaryKey(Integer aid);

    int insert(Admin record);

    int insertSelective(Admin record);//判空存入

    Admin selectByPrimaryKey(Integer aid);

    int updateByPrimaryKeySelective(Admin record);//判空修改

    int updateByPrimaryKey(Admin record);
    
    /**
     * 查找账号个数
     * @param account
     * @return
     */
    public int selectAccountCount(@Param("account")String account);
    
    /**
     * 根据账号查找返回admin
     * @param account
     * @return
     */
    public Admin selectAdminByAccount(@Param("account")String account);
}