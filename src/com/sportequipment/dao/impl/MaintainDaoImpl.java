package com.sportequipment.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.sportequipment.dao.MaintainDao;
import com.sportequipment.domain.Maintain;
import com.sportequipment.util.BaseDao;
import com.sportequipment.util.DBUtils;

public class MaintainDaoImpl extends BaseDao implements MaintainDao{

	@Override
	public int addEquipment(Connection conn,Maintain maintain) throws Exception {
		String sql = "insert into tb_maintain(equipmentId,equipmentName,equipmentType,equipmentPrice,equipmentAmount,equipmentSpecification,putTime,operatPerson) value(?,?,?,?,?,?,?,?)";
		Object[] params = { maintain.getEquipmentId(),
				maintain.getEquipmentName(), maintain.getEquipmentType(),
				maintain.getEquipmentPrice(), maintain.getEquipmentAmount(),
				maintain.getEquipmentspecification(), maintain.getPutime(),
				maintain.getOperatPerson() };
		return this.executeUpdate(conn,sql, params);
	}

	@Override
	public Maintain getEquipmentById(String equipmentId) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Maintain me = new Maintain();
		String sql = "select * from tb_maintain where equipmentId=?";
		try {
			conn = DBUtils.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, equipmentId);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				me.setEquipmentId(rs.getString("equipmentId"));
				me.setEquipmentName(rs.getString("equipmentName"));
				me.setEquipmentType(rs.getString("equipmentType"));
				me.setEquipmentPrice(rs.getFloat("equipmentPrice"));
				me.setEquipmentAmount(rs.getInt("equipmentAmount"));
				me.setEquipmentspecification(rs.getString("equipmentSpecification"));
				me.setPutime(rs.getDate("putTime"));
				me.setOperatPerson(rs.getString("operatPerson"));
			}
		} finally {
			DBUtils.closeAll(rs, pstmt, conn);
		}
		return me;
	}

	@Override
	public int updateEquipment(Connection conn, String equipmentId, int num)
			throws Exception {
		String  sql = "update tb_maintain set equipmentAmount=equipmentAmount+? where equipmentId=?";
		return this.executeUpdate(conn,sql,num,equipmentId);
	}

	@Override
	public int getTotalCount(String equipmentId, String equipmentName,
			String equipmentType, String operatPerson,
			String equipmentspecification) throws Exception {
		String sql = "select count(*) from tb_maintain where 1=1";
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
			sql += " and operatPerson=?";
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
				result = rs.getInt(1); //索引或者列名来获得查询结果集中的某一列的值。记录数
			}
		} finally {
			DBUtils.closeAll(rs, pstmt, conn);
		}
		return result;
	}
	
	@Override
	public List<Maintain> getMaintainsByPage(int pageNo, int pageSize,
			String equipmentId, String equipmentName, String equipmentType,
			String operatPerson, String equipmentspecification)
			throws Exception {
String sql = "select * from tb_maintain where 1=1";
		
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
			sql += " and operatPerson=?";
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
		boolean flag = true;
		List<Maintain> list = new ArrayList<Maintain>();
		
		try {
			conn = DBUtils.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			if (params.size() > 0) {
				for (int i = 0; i < params.size(); i++) {
					pstmt.setObject(i + 1, params.get(i));
				}
			}
			rs = pstmt.executeQuery();
			Maintain maintain = null;
			while (rs.next()) {
				maintain = new Maintain();
				maintain.setEquipmentId(rs.getString("equipmentId"));
				maintain.setEquipmentName(rs.getString("equipmentName"));
				maintain.setEquipmentType(rs.getString("equipmentType"));
				maintain.setEquipmentPrice(rs.getFloat("equipmentPrice"));
				maintain.setEquipmentAmount(rs.getInt("equipmentAmount"));
				maintain.setEquipmentspecification(rs.getString("equipmentSpecification"));
				maintain.setPutime(rs.getDate("putTime"));
				maintain.setOperatPerson(rs.getString("operatPerson"));
				list.add(maintain);
				flag =false;
			}
			if(flag){
				list.add(maintain);
			}
		} finally {
			DBUtils.closeAll(rs, pstmt, conn);
		}
		return list;
	}

}
