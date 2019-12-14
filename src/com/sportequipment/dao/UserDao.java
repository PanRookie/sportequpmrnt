package com.sportequipment.dao;

import java.util.List;
import com.sportequipment.domain.User;

public interface UserDao {
	/**
	 * 添加用户
	 * 
	 * @param user
	 * @return
	 * @throws Exception
	 */
	public abstract int addUser(User user) throws Exception;

	/**
	 * 根据用户名和密码查询用户
	 * 
	 * @param loginName
	 * @param loginPassWord
	 * @return
	 * @throws Exception
	 */
	public abstract User findUser(String loginName, String loginPassWord)
			throws Exception;

	/**
	 * 根据用户名查询用户
	 * 
	 * @param loginname
	 * @return
	 * @throws Exception
	 */
	public abstract User findUserByName(String loginname) throws Exception;

	public abstract List<User> getUsersByPage(int pageNo, int pageSize,
			String loginName, String userName, String sex,
			String schoolPosition, String deparment, String major,
			String phonenumber, String email, String identityCode)
			throws Exception;

	public abstract int getTotalCount(String loginName, String userName,
			String sex, String schoolPosition, String deparment, String major,
			String phonenumber, String email, String identityCode)
			throws Exception;
	
	public abstract int deleteEquipment(String loginName) throws Exception;
	 
	public abstract int updateUser(String loginName, String userName,
			String sex,String deparment, String major,
			String phonenumber, String email, String identityCode) throws Exception;

}
