package com.sportequipment.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.sportequipment.dao.ApplyDao;
import com.sportequipment.domain.Apply;
import com.sportequipment.util.BaseDao;
import com.sportequipment.util.DBUtils;

public class ApplyDaoImpl extends BaseDao implements ApplyDao{

	@Override
	public int addApply(Apply apply) throws Exception {
		// TODO Auto-generated method stub
		String sql = "insert into tb_apply(loginName,equipmentId,equipmentAmount,applyDate,applyRemark) value(?,?,?,?,?)";
		Object[] params = {apply.getLoginName(),apply.getEquipmentId(),apply.getBorrowAmount(),new Date(),apply.getApplyRemark() };
		return this.executeUpdate(sql, params);
	}

	@Override
	public int updateApply(Connection conn, String loginName,
			String equipmentId, int num) throws Exception {
		String sql = "update tb_apply set equipmentAmount=equipmentAmount+? where equipmentId=? and loginName=?";
		return this.executeUpdate(conn, sql, num, loginName,equipmentId);
	}

	@Override
	public int deleteApply(Connection conn, String loginName,String equipmentId)
			throws Exception {
		String sql = "delete from tb_apply where loginName=? and equipmentId=?";
		return this.executeUpdate(conn, sql,loginName,equipmentId);
	}

	@Override
	public List<Apply> getApplysByPage(int pageNo, int pageSize,
			String equipmentId, String loginName,int num,Date applyDate) throws Exception {
		String sql = "select * from tb_apply where 1=1";

		// 保存参数的集合
		List<Object> params = new ArrayList<Object>();

		if (equipmentId != "") {
			sql += " and equipmentId like ?";
			params.add("%" + equipmentId + "%");
		}
		if (loginName != "") {
			sql += " and loginName like ?";
			params.add("%" + loginName + "%");
		}
		if (num != 0) {
			sql += " and equipmentAmount=?";
			params.add(num);
		}
		if (applyDate != null) {
			sql += " and applyDate=?";
			params.add(applyDate);
		}
		sql += " order by equipmentId desc limit ?,?";

		params.add((pageNo - 1) * pageSize);
		params.add(pageSize);

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Apply> list = new ArrayList<Apply>();

		try {
			conn = DBUtils.getConnection();
			pstmt = conn.prepareStatement(sql);

			if (params.size() > 0) {
				for (int i = 0; i < params.size(); i++) {
					pstmt.setObject(i + 1, params.get(i));
				}
			}
			// equipmentId,equipmentName,equipmentType,equipmentPrice,equipmentAmount,equipmentSpecification,putTime,operatPersonnel
			rs = pstmt.executeQuery();
			Apply apply = null;
			while (rs.next()) {
				apply = new Apply();
				apply.setEquipmentId(rs.getString("equipmentId"));
				apply.setLoginName(rs.getString("loginName"));
				apply.setBorrowAmount(rs.getInt("equipmentAmount"));
				apply.setApplyRemark(rs.getString("applyRemark"));
				apply.setApplyDate(rs.getDate("applyDate"));
				list.add(apply);
			}
		} finally {
			DBUtils.closeAll(rs, pstmt, conn);
		}
		return list;
	}

	@Override
	public int getTotalCount(String equipmentId, String loginName,int num,Date applyDate)
			throws Exception {
		String sql = "select * from tb_apply where 1=1";

		// 保存参数的集合
		List<Object> params = new ArrayList<Object>();

		if (equipmentId != "") {
			sql += " and equipmentId like ?";
			params.add("%" + equipmentId + "%");
		}
		if (loginName != "") {
			sql += " and loginName like ?";
			params.add("%" + loginName + "%");
		}
		if (num != 0) {
			sql += " and equipmentAmount=?";
			params.add(num);
		}
		if (applyDate != null) {
			sql += " and applyDate=?";
			params.add(applyDate);
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
			// equipmentId,equipmentName,equipmentType,equipmentPrice,equipmentAmount,equipmentSpecification,putTime,operatPersonnel
			rs = pstmt.executeQuery();
			while (rs.next()) {
				result = result + 1; // 索引或者列名来获得查询结果集中的某一列的值。记录数
			}
		} finally {
			DBUtils.closeAll(rs, pstmt, conn);
		}
		return result;
	}

}
