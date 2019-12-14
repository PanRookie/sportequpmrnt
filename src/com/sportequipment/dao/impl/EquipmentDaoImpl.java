package com.sportequipment.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.sportequipment.dao.EquipmentDao;
import com.sportequipment.domain.Equipment;
import com.sportequipment.util.BaseDao;
import com.sportequipment.util.DBUtils;

public class EquipmentDaoImpl extends BaseDao implements EquipmentDao {

	@Override
	public int addEquipment(Equipment equipment) throws Exception {
		String sql = "insert into tb_equipment(equipmentId,equipmentName,equipmentType,equipmentPrice,equipmentAmount,equipmentSpecification,putTime,operatPersonnel) value(?,?,?,?,?,?,?,?)";
		Object[] params = { equipment.getEquipmentId(),
				equipment.getEquipmentName(), equipment.getEquipmentType(),
				equipment.getEquipmentPrice(), equipment.getEquipmentAmount(),
				equipment.getEquipmentspecification(), equipment.getPutime(),
				equipment.getOperatPerson() };
		return this.executeUpdate(sql, params);
	}

	@Override
	public int getTotalCount(String equipmentId, String equipmentName,
			String equipmentType, String operatPerson,
			String equipmentspecification) throws Exception {
		String sql = "select count(*) from tb_equipment where 1=1";
		// 保存参数的集合
		List<Object> params = new ArrayList<Object>();

		if (equipmentId != "") {
			sql += " and equipmentId like ?";
			params.add("%" + equipmentId + "%");
		}
		if (equipmentName != "") {
			sql += " and equipmentName like ?";
			params.add("%" + equipmentName + "%");
		}
		if (equipmentType != "") {
			sql += " and equipmentType=?";
			params.add(equipmentType);
		}
		if (operatPerson != "") {
			sql += " and operatPersonnel=?";
			params.add(operatPerson);
		}
		if (equipmentspecification != "") {
			sql += " and equipmentSpecification like ?";
			params.add("%" + equipmentspecification + "%");
		}

		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DBUtils.getConnection();
			pstmt = conn.prepareStatement(sql);
			if (params.size() > 0) {
				for (int i = 0; i < params.size(); i++) {
					pstmt.setObject(i + 1, params.get(i));
				}
			}
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1); // 索引或者列名来获得查询结果集中的某一列的值。记录数
			}
		} finally {
			DBUtils.closeAll(rs, pstmt, conn);
		}
		return result;
	}

	@Override
	public List<Equipment> getEquipmentsByPage(int pageNo, int pageSize,
			String equipmentId, String equipmentName, String equipmentType,
			String operatPerson, String equipmentspecification)
			throws Exception {
		String sql = "select * from tb_equipment where 1=1";

		// 保存参数的集合
		List<Object> params = new ArrayList<Object>();

		if (equipmentId != "") {
			sql += " and equipmentId like ?";
			params.add("%" + equipmentId + "%");
		}
		if (equipmentName != "") {
			sql += " and equipmentName like ?";
			params.add("%" + equipmentName + "%");
		}
		if (equipmentType != "") {
			sql += " and equipmentType=?";
			params.add(equipmentType);
		}
		if (operatPerson != "") {
			sql += " and operatPersonnel=?";
			params.add(operatPerson);
		}
		if (equipmentspecification != "") {
			sql += " and equipmentSpecification like ?";
			params.add("%" + equipmentspecification + "%");
		}

		sql += " order by equipmentId desc limit ?,?";

		params.add((pageNo - 1) * pageSize);
		params.add(pageSize);

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Equipment> list = new ArrayList<Equipment>();

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
			Equipment equipment = null;
			while (rs.next()) {
				equipment = new Equipment();
				equipment.setEquipmentId(rs.getString("equipmentId"));
				equipment.setEquipmentName(rs.getString("equipmentName"));
				equipment.setEquipmentType(rs.getString("equipmentType"));
				equipment.setEquipmentPrice(rs.getFloat("equipmentPrice"));
				equipment.setEquipmentAmount(rs.getInt("equipmentAmount"));
				equipment.setEquipmentspecification(rs
						.getString("equipmentSpecification"));
				equipment.setPutime(rs.getDate("putTime"));
				equipment.setOperatPerson(rs.getString("operatPersonnel"));
				list.add(equipment);
			}
		} finally {
			DBUtils.closeAll(rs, pstmt, conn);
		}
		return list;
	}

	@Override
	public Equipment getEquipmentById(String equipmentId) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Equipment equipment = null;
		String sql = "select * from tb_equipment where equipmentId=?";
		try {
			conn = DBUtils.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, equipmentId);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				equipment = new Equipment();
				equipment.setEquipmentId(rs.getString("equipmentId"));
				equipment.setEquipmentName(rs.getString("equipmentName"));
				equipment.setEquipmentType(rs.getString("equipmentType"));
				equipment.setEquipmentPrice(rs.getFloat("equipmentPrice"));
				equipment.setEquipmentAmount(rs.getInt("equipmentAmount"));
				equipment.setEquipmentspecification(rs
						.getString("equipmentSpecification"));
				equipment.setPutime(rs.getDate("putTime"));
				equipment.setOperatPerson(rs.getString("operatPersonnel"));
			}
		} finally {
			DBUtils.closeAll(rs, pstmt, conn);
		}
		return equipment;
	}

	@Override
	public int updateEquipment(Connection conn, String equipmentId, int num)
			throws Exception {
		String sql = "update tb_equipment set equipmentAmount=equipmentAmount+? where equipmentId=?";
		return this.executeUpdate(conn, sql, num, equipmentId);
	}

	@Override
	public int deleteEquipment(Connection conn, String equipmentId)
			throws Exception {
		String sql = "delete from tb_equipment where equipmentId=?";
		return this.executeUpdate(conn, sql, equipmentId);
	}

}
