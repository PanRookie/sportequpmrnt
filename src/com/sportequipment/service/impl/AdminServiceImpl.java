package com.sportequipment.service.impl;

import com.sportequipment.dao.AdminDao;
import com.sportequipment.dao.impl.AdminDaoimpl;
import com.sportequipment.domain.Admin;
import com.sportequipment.service.AdminService;

public class AdminServiceImpl implements AdminService {
	private AdminDao admindao = new AdminDaoimpl();
	@Override
	public Admin adminLogin(String loginname, String password) throws Exception {
		return admindao.findAdmin(loginname, password);
	}
}
