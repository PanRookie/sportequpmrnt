package com.sportequipment.service;

import com.sportequipment.domain.Admin;

public interface AdminService {
	public abstract Admin adminLogin(String loginname,String password) throws Exception;
}
