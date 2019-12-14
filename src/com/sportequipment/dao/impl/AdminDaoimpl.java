package com.sportequipment.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.sportequipment.dao.AdminDao;
import com.sportequipment.domain.Admin;
import com.sportequipment.util.BaseDao;
import com.sportequipment.util.DBUtils;

public class AdminDaoimpl extends BaseDao implements AdminDao {

	@Override
	public Admin findAdmin(String loginName, String loginPassWord)
			throws Exception {
		String sql = "select * from tb_admin where adminAcount = ? and adminPassWord = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Admin admin = null;
		try {
			conn = DBUtils.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setObject(1, loginName);
			pstmt.setObject(2, loginPassWord);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				admin = new Admin();
				admin.setAdminAcount(rs.getString("adminAcount"));
				admin.setAdminPassword(rs.getString("adminPassword"));
				admin.setAdminName(rs.getString("adminName"));
			}
		} catch (Exception e) {

			e.printStackTrace();
		}
		return admin;
	}

	@Override
	public Admin findAdminByName(String loginname) throws Exception {

		return null;
	}
}
