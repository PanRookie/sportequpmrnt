package com.sportequipment.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.sportequipment.dao.UserDao;
import com.sportequipment.domain.User;
import com.sportequipment.util.BaseDao;
import com.sportequipment.util.DBUtils;

public class UserDaoImpl extends BaseDao implements UserDao {
	@Override
	public int addUser(User user) throws Exception {
		Integer result = 1;

		String sql = " INSERT into tb_user(loginName,loginPassword,userName,sex,schoolPosition,deparment,major,phonenumber,email,identityCode) values(?,?,?,?,?,?,?,?,?,?)";

		Object param[] = new Object[] { user.getLoginname(),
				user.getPassword(), user.getUsername(), user.getSex(),
				user.getSchoolposition(), user.getDapartment(),
				user.getMajor(), user.getPhonenumber(), user.getEmail(),
				user.getIdentityCode() };
		result = this.executeUpdate(sql, param);

		return result;
	}

	@Override
	public User findUser(String loginName, String loginPassWord)
			throws Exception {
		String sql = "select * from tb_user where loginName=? and loginPassword=?";
		List<User> list = getUsers(sql, loginName, loginPassWord);
		if (list.isEmpty()) {
			return null;
		} else {
			return list.get(0);
		}
	}

	@Override
	public User findUserByName(String loginname) throws Exception {
		String sql = "select * from tb_user where loginName=?";
		List<User> list = getUsers(sql, loginname);
		if (list.isEmpty()) {
			return null;
		} else {
			return list.get(0);
		}
	}

	/**
	 * 查询用户集合的方法
	 * 
	 * @param sql
	 *            传入sql
	 * @param params
	 *            传入参数数组
	 * @return 用户对象
	 * @throws Exception
	 */
	public List<User> getUsers(String sql, Object... params) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<User> list = new ArrayList<User>();
		try {
			conn = DBUtils.getConnection();
			pstmt = conn.prepareStatement(sql);

			for (int i = 0; i < params.length; i++) {
				pstmt.setObject(i + 1, params[i]);
			}
			rs = pstmt.executeQuery();
			User user = null;
			while (rs.next()) {
				user = new User();
				user.setLoginname(rs.getString("loginName"));
				user.setPassword(rs.getString("loginPassword"));
				user.setUsername(rs.getString("userName"));
				user.setSex(rs.getString("sex"));
				user.setSchoolposition(rs.getString("schoolPosition"));
				user.setDapartment(rs.getString("deparment"));
				user.setMajor(rs.getString("major"));
				user.setEmail(rs.getString("email"));
				user.setPhonenumber(rs.getString("phonenumber"));
				user.setIdentityCode(rs.getString("identityCode"));
				user.setUserid(rs.getInt("userId"));
				list.add(user);
			}

		} finally {
			DBUtils.closeAll(rs, pstmt, conn);
		}
		return list;
	}

	@Override
	public List<User> getUsersByPage(int pageNo, int pageSize,
			String loginName, String userName, String sex,
			String schoolPosition, String deparment, String major,
			String phonenumber, String email, String identityCode)
			throws Exception {
		// INSERT into
		// tb_user(loginName,loginPassword,userName,sex,schoolPosition,deparment,major,phonenumber,email,identityCode)
		// values(?,?,?,?,?,?,?,?,?,?)";
		String sql = "select * from tb_user where 1=1";

		// 保存参数的集合
		List<Object> params = new ArrayList<Object>();

		if (loginName != "") {
			sql += " and loginName like ?";
			params.add("%" + loginName + "%");
		}
		if (userName != "") {
			sql += " and userName like ?";
			params.add("%" + userName + "%");
		}
		if (sex != "") {
			sql += " and sex=?";
			params.add(sex);
		}
		if (schoolPosition != "") {
			sql += " and schoolPosition=?";
			params.add(schoolPosition);
		}
		if (deparment != "") {
			sql += " and deparment=?";
			params.add(deparment);
		}

		if (major != "") {
			sql += " and major=?";
			params.add(major);
		}

		if (phonenumber != "") {
			sql += " and phonenumber like ?";
			params.add("%" + phonenumber + "%");
		}
		if (email != "") {
			sql += " and email like ?";
			params.add("%" + email + "%");
		}
		if (identityCode != "") {
			sql += " and identityCode like ?";
			params.add("%" + identityCode + "%");
		}

		sql += " order by loginName desc limit ?,?";

		params.add((pageNo - 1) * pageSize);
		params.add(pageSize);

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<User> list = new ArrayList<User>();

		try {
			conn = DBUtils.getConnection();
			pstmt = conn.prepareStatement(sql);

			if (params.size() > 0) {
				for (int i = 0; i < params.size(); i++) {
					pstmt.setObject(i + 1, params.get(i));
				}
			}
			rs = pstmt.executeQuery();
			User user = null;
			while (rs.next()) {
				user = new User();
				user.setLoginname(rs.getString("loginName"));
				user.setPassword(rs.getString("loginPassword"));
				user.setUsername(rs.getString("userName"));
				user.setSex(rs.getString("sex"));
				user.setSchoolposition(rs.getString("schoolPosition"));
				user.setDapartment(rs.getString("deparment"));
				user.setMajor(rs.getString("major"));
				user.setEmail(rs.getString("email"));
				user.setPhonenumber(rs.getString("phonenumber"));
				user.setIdentityCode(rs.getString("identityCode"));
				user.setUserid(rs.getInt("userId"));
				list.add(user);
			}
		} finally {
			DBUtils.closeAll(rs, pstmt, conn);
		}
		return list;
	}

	@Override
	public int getTotalCount(String loginName, String userName, String sex,
			String schoolPosition, String deparment, String major,
			String phonenumber, String email, String identityCode)
			throws Exception {
		String sql = "select * from tb_user where 1=1";

		// 保存参数的集合
		List<Object> params = new ArrayList<Object>();

		if (loginName != "") {
			sql += " and loginName like ?";
			params.add("%" + loginName + "%");
		}
		if (userName != "") {
			sql += " and userName like ?";
			params.add("%" + userName + "%");
		}
		if (sex != "") {
			sql += " and sex=?";
			params.add(sex);
		}
		if (schoolPosition != "") {
			sql += " and schoolPosition=?";
			params.add(schoolPosition);
		}
		if (deparment != "") {
			sql += " and deparment=?";
			params.add(deparment);
		}

		if (major != "") {
			sql += " and major=?";
			params.add(major);
		}

		if (phonenumber != "") {
			sql += " and phonenumber like ?";
			params.add("%" + phonenumber + "%");
		}
		if (email != "") {
			sql += " and email like ?";
			params.add("%" + email + "%");
		}
		if (identityCode != "") {
			sql += " and identityCode like ?";
			params.add("%" + identityCode + "%");
		}

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		try {
			conn = DBUtils.getConnection();
			pstmt = conn.prepareStatement(sql);

			if (params.size() > 0) {
				for (int i = 0; i < params.size(); i++) {
					pstmt.setObject(i + 1, params.get(i));
				}
			}

			rs = pstmt.executeQuery();

			while (rs.next()) {
				result = result + 1; // 索引或者列名来获得查询结果集中的某一列的值。记录数
			}
		} finally {
			DBUtils.closeAll(rs, pstmt, conn);
		}
		return result;
	}

	@Override
	public int deleteEquipment(String loginName) throws Exception {
		// TODO Auto-generated method stub
		String sql = "delete from tb_user where loginName=?";
		return this.executeUpdate(sql,loginName);
	}

	@Override
	public int updateUser(String loginName, String userName, String sex,
			String deparment, String major, String phonenumber, String email,
			String identityCode) throws Exception {
		// TODO Auto-generated method stub
		String sql = "update tb_user set userName=?,sex=?,deparment=?,major=?,phonenumber=?,email=?,identityCode=? where loginName=?";
		return this.executeUpdate(sql,userName,sex,deparment,major,phonenumber,email,identityCode,loginName);
	}

}
