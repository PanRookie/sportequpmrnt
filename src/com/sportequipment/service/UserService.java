package com.sportequipment.service;

import java.util.List;

import com.sportequipment.domain.User;

public interface UserService {
	/**
	 * 注册业务
	 * @param user
	 * @return
	 * @throws Exception
	 */
	public abstract int userRegister(User user) throws Exception;
	/**
	 * 登录业务
	 * @param loginname
	 * @param password
	 * @return
	 * @throws Exception
	 */
	public abstract User userLogin(String loginname,String password) throws Exception;
	/**
	 * 判断是否存在该用户
	 * @param loginname
	 * @return
	 * @throws Exception
	 */
	public abstract User getUserByLoginName(String loginname) throws Exception;
	
	public abstract List<User> getUsersByPage(int pageNo, int pageSize,
			String loginName, String userName, String sex,
			String schoolPosition, String deparment, String major,
			String phonenumber, String email, String identityCode)
			throws Exception;
	
	public abstract int updateUserData(String loginName, String userName,
			String sex,String deparment, String major,
			String phonenumber, String email, String identityCode) throws Exception;
	
	public abstract int collectEquipment(String loginName, String equipmentId) throws Exception;
	public abstract int deleteCollect(String loginName, String equipmentId) throws Exception;
}
