package com.sportequipment.service.impl;

import java.util.List;

import com.sportequipment.dao.CollectDao;
import com.sportequipment.dao.UserDao;
import com.sportequipment.dao.impl.CollectDaoImpl;
import com.sportequipment.dao.impl.UserDaoImpl;
import com.sportequipment.domain.User;
import com.sportequipment.service.UserService;

public class UserServiceImpl implements UserService {
	private UserDao userdao = new UserDaoImpl();
    
	@Override
	public int userRegister(User user) throws Exception {
		if (userdao.addUser(user) > 0) {
			return 1;
		} else {
			return 0;
		}
	}

	@Override
	public User userLogin(String loginname, String password) throws Exception {
		return userdao.findUser(loginname, password);
	}

	@Override
	public User getUserByLoginName(String loginname) throws Exception {
		return userdao.findUserByName(loginname);

	}

	@Override
	public List<User> getUsersByPage(int pageNo, int pageSize,
			String loginName, String userName, String sex,
			String schoolPosition, String deparment, String major,
			String phonenumber, String email, String identityCode)
			throws Exception {
		return userdao.getUsersByPage(pageNo, pageSize, loginName, userName,
				sex, schoolPosition, deparment, major, phonenumber, email,
				identityCode);
	}

	@Override
	public int updateUserData(String loginName, String userName, String sex,
			String deparment, String major, String phonenumber, String email,
			String identityCode) throws Exception {

		 return userdao.updateUser(loginName, userName, sex, deparment, major,
		 phonenumber, email, identityCode);

	}

	@Override
	public int collectEquipment(String loginName, String equipmentId)
			throws Exception {
		CollectDao collectdao = new CollectDaoImpl(); 
		return collectdao.addCollect(loginName, equipmentId);
	}

	@Override
	public int deleteCollect(String loginName, String equipmentId)
			throws Exception {
		CollectDao collectdao = new CollectDaoImpl(); 
		// TODO Auto-generated method stub
		return collectdao.deleteCollect(loginName, equipmentId);

	}

}
