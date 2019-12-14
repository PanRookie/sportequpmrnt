package com.sportequipment.dao;

import com.sportequipment.domain.Admin;


public interface AdminDao {

	public abstract Admin findAdmin(String loginName,String loginPassWord) throws Exception;
	public abstract Admin findAdminByName(String loginname) throws Exception;
}
