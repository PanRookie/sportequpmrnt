package com.sportequipment.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.sportequipment.dao.BorrowDao;
import com.sportequipment.domain.Borrow;	
import com.sportequipment.util.BaseDao;
import com.sportequipment.util.DBUtils;

public class BorrowDaoImpl extends BaseDao implements BorrowDao {

	@Override
	public int addBorrow(Connection conn, String loginName, String equipmentId,
			String operatperson, int num) throws Exception {
		String sql = "insert into tb_equipmentborrow(loginName,equipmentId,lendDate,willDate,operatperson,equipmentcount) values(?,?,?,?,?,?)";
		Date date = new Date();
		date = new Date((date.getTime() / 1000 + 30 * 24 * 60 * 60) * 1000); // 获得当前时间距离1970年以来的全部毫秒数
		Object[] params = { loginName, equipmentId, new Date(), date,
				operatperson, num };
		return this.executeUpdate(conn, sql, params);

	}

	@Override
	public Borrow findBorrow(String loginname, String equipmentId)
			throws Exception {
		String sql = "select * from tb_equipmentborrow where loginName=? and equipmentId=?";
		if(getBorrows(sql, loginname, equipmentId).isEmpty()){
			return null;
		}else{
			return getBorrows(sql, loginname, equipmentId).get(0);
		}
		
	}

	/**
	 * @param sql
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Borrow> getBorrows(String sql, Object... params)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Borrow> list = new ArrayList<Borrow>();
		try {
			conn = DBUtils.getConnection();
			pstmt = conn.prepareStatement(sql);

			for (int i = 0; i < params.length; i++) {
				pstmt.setObject(i + 1, params[i]);
			}
			rs = pstmt.executeQuery();
			Borrow borrow = null;
			while (rs.next()) {
				borrow = new Borrow();
				borrow.setBorrowId(rs.getInt("borrowId"));
				borrow.setLoginName(rs.getString("loginName"));
				borrow.setEquipmentId(rs.getString("equipmentId"));
				borrow.setLendDate(rs.getDate("lendDate"));
				borrow.setWillDate(rs.getDate("willDate"));
				borrow.setOperatperson(rs.getString("operatperson"));
				borrow.setEquipmentcount(rs.getInt("equipmentcount"));
				list.add(borrow);
			}
		} finally {
			DBUtils.closeAll(rs, pstmt, conn);
		}
		return list;
	}

	@Override
	public int updateBorrow(Connection conn, String loginName,
			String equipmentId, int num) throws Exception {
		String sql = "update tb_equipmentborrow set equipmentcount=equipmentcount+? where equipmentId=? and loginName=?";
		return this.executeUpdate(conn, sql, num, equipmentId, loginName);
	}

	@Override
	public List<Borrow> getBorrowsByPage(int pageNo, int pageSize,
			String equipmentId, String loginName) throws Exception {
		String sql = "select * from tb_equipmentborrow where 1=1";
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
		sql += " order by equipmentId desc limit ?,?";

		params.add((pageNo - 1) * pageSize);
		params.add(pageSize);

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Borrow> list = new ArrayList<Borrow>();

		try {
			conn = DBUtils.getConnection();
			pstmt = conn.prepareStatement(sql);

			if (params.size() > 0) {
				for (int i = 0; i < params.size(); i++) {
					pstmt.setObject(i + 1, params.get(i));
				}
			}
			rs = pstmt.executeQuery();
			Borrow borrow = null;
			while (rs.next()) {
				borrow = new Borrow();
				borrow.setBorrowId(rs.getInt("borrowId"));
				borrow.setLoginName(rs.getString("loginName"));
				borrow.setEquipmentId(rs.getString("equipmentId"));
				borrow.setLendDate(rs.getDate("lendDate"));
				borrow.setWillDate(rs.getDate("willDate"));
				borrow.setOperatperson(rs.getString("operatperson"));
				borrow.setEquipmentcount(rs.getInt("equipmentcount"));
				list.add(borrow);
			}
		} finally {
			DBUtils.closeAll(rs, pstmt, conn);
		}
		return list;
	}

	@Override
	public int deleteBorrow(Connection conn, String equipmentId,
			String loginName) throws Exception {
		String sql = "delete from tb_equipmentborrow where equipmentId=? and loginName=?";
		return this.executeUpdate(conn, sql, equipmentId, loginName);
	}

	@Override
	public int getTotalCount(String equipmentId, String loginName)
			throws Exception {
		String sql = "select * from tb_equipmentborrow where 1=1";
		List<Object> params = new ArrayList<Object>();

		if (equipmentId != "") {
			sql += " and equipmentId like ?";
			params.add("%" + equipmentId + "%");
		}
		if (loginName != "") {
			sql += " and loginName like ?";
			params.add("%" + loginName + "%");
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
}
