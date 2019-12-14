package com.sportequipment.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.sportequipment.dao.CollectDao;
import com.sportequipment.domain.Collect;
import com.sportequipment.util.BaseDao;
import com.sportequipment.util.DBUtils;

public class CollectDaoImpl extends BaseDao implements CollectDao {

	@Override
	public int addCollect(String loginName, String equipmentId)
			throws Exception {
		// TODO Auto-generated method stub
		String sql = " INSERT into tb_collect(loginName,equipmentId) values(?,?)";
		Object[] params = {loginName, equipmentId};
		return this.executeUpdate(sql, params);
	}

	@Override
	public int deleteCollect(String loginName, String equipmentId)
			throws Exception {
		String sql = "delete from  tb_collect where equipmentId=? and loginName=?";
		return this.executeUpdate(sql, equipmentId,loginName);
	}

	@Override
	public List<Collect> getBorrowsByPage(String loginName) throws Exception {
		String sql = "select * from tb_collect where loginName=?";
		// 保存参数的集合
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Collect> list = new ArrayList<Collect>();
		try {
			conn = DBUtils.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setObject(1,loginName);
			rs = pstmt.executeQuery();
			Collect collect = null;
			while (rs.next()) {
				collect = new Collect();
				collect.setEquipmentId(rs.getString("equipmentId"));
				collect.setLoginName(rs.getString("loginName"));
				collect.setCollectId(rs.getInt("collectId"));
				list.add(collect);
			}
		} finally {
			DBUtils.closeAll(rs, pstmt, conn);
		}
		return list;
	}
}
