package com.sportequipment.service.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.sportequipment.dao.EquipmentDao;
import com.sportequipment.dao.MaintainDao;
import com.sportequipment.dao.impl.BorrowDaoImpl;
import com.sportequipment.dao.impl.EquipmentDaoImpl;
import com.sportequipment.dao.impl.MaintainDaoImpl;
import com.sportequipment.domain.Equipment;
import com.sportequipment.domain.Maintain;
import com.sportequipment.service.EquipmentService;
import com.sportequipment.util.DBUtils;

public class EquipmentServiceImpl implements EquipmentService {
	private EquipmentDao equipmentdao = new EquipmentDaoImpl();

	@Override
	public int addEquipment(Equipment equipment) throws Exception {
		if (equipmentdao.addEquipment(equipment) > 0) {
			return 1;
		} else {
			return 0;
		}
	}

	@Override
	public List<Equipment> getEquipmentsByPage(int pageNo, int pageSize,
			String equipmentId, String equipmentName, String equipmentType,
			String operatPerson, String equipmentspecification)
			throws Exception {
		return equipmentdao.getEquipmentsByPage(pageNo, pageSize, equipmentId,
				equipmentName, equipmentType, operatPerson,
				equipmentspecification);
	}

	@Override
	public int deleteEquipment(String equipmentId, int num) throws Exception {
		Connection conn = DBUtils.getConnection();
		int result = 0;
		BorrowDaoImpl borrowbaoimpl = new BorrowDaoImpl();
		String sql = "select * from tb_equipmentborrow where equipmentId=?";

		if (equipmentdao.getEquipmentById(equipmentId).getEquipmentAmount() == num
				&& borrowbaoimpl.getBorrows(sql, equipmentId).get(0) == null) {

			result = equipmentdao.deleteEquipment(conn, equipmentId);

		} else {
			result = equipmentdao.updateEquipment(conn, equipmentId, -num);

		}
		return result;
	}

	@Override
	public int maintainEquipment(String equipmentId, int num) throws Exception {

		int executepunctuation = 0;
		Connection conn = null;

		MaintainDao maintaindao = new MaintainDaoImpl();
		Equipment equipment = equipmentdao.getEquipmentById(equipmentId);
		Maintain maintain = new Maintain();
		maintain.setEquipmentId(equipment.getEquipmentId());
		maintain.setEquipmentName(equipment.getEquipmentName());
		maintain.setEquipmentType(equipment.getEquipmentType());
		maintain.setEquipmentPrice(equipment.getEquipmentPrice());
		maintain.setEquipmentAmount(1);
		maintain.setOperatPerson(equipment.getOperatPerson());
		maintain.setEquipmentspecification(equipment
				.getEquipmentspecification());
		maintain.setPutime(equipment.getPutime());

		try {
			conn = DBUtils.getConnection();
			conn.setAutoCommit(false);// 取消自动提交
			
			equipmentdao.updateEquipment(conn, equipmentId, -num);

			if (maintaindao.getEquipmentById(equipmentId).getEquipmentId() == null) {

				executepunctuation = maintaindao.addEquipment(conn, maintain);
				conn.commit();

			} else {

				executepunctuation = maintaindao.updateEquipment(conn,
						equipmentId, num);
				conn.commit();
			}
		} catch (Exception e) {
			try {
				if (conn != null)
					conn.rollback();// 回滚
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				if (conn != null) {
					conn.setAutoCommit(true);
					DBUtils.closeAll(null, null, conn);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		/*
		 * if (equipment.getEquipmentAmount() > 1) {
		 * 
		 * try { conn = DBUtils.getConnection(); conn.setAutoCommit(false);//
		 * 取消自动提交
		 * 
		 * if (maintaindao.getEquipmentById(equipmentId).getEquipmentId() ==
		 * null) {
		 * 
		 * maintaindao.addEquipment(conn, maintain);
		 * 
		 * } else {
		 * 
		 * maintaindao.updateEquipment(conn, equipmentId, 1); }
		 * executepunctuation = 2;
		 * 
		 * 
		 * 
		 * executepunctuation = 3;
		 * 
		 * conn.commit(); executepunctuation = 0;
		 * 
		 * } catch (Exception e) { try { if (conn != null) conn.rollback();// 回滚
		 * } catch (SQLException e1) { e1.printStackTrace(); } } finally { try {
		 * if (conn != null) { conn.setAutoCommit(true); DBUtils.closeAll(null,
		 * null, conn); } } catch (SQLException e) { e.printStackTrace(); } } }
		 * else {
		 * 
		 * try { conn = DBUtils.getConnection(); conn.setAutoCommit(false);
		 * 
		 * equipmentdao.deleteEquipment(conn, equipmentId); executepunctuation =
		 * 2;
		 * 
		 * if (maintaindao.getEquipmentById(equipmentId).getEquipmentId() ==
		 * null) {
		 * 
		 * maintaindao.addEquipment(conn, maintain);
		 * 
		 * } else {
		 * 
		 * maintaindao.updateEquipment(conn, equipmentId, 1); }
		 * executepunctuation = 3;
		 * 
		 * conn.commit();
		 * 
		 * executepunctuation = 0; } catch (Exception e) { try { if (conn !=
		 * null) conn.rollback();// 回滚 } catch (SQLException e1) {
		 * e1.printStackTrace(); } } finally { try { if (conn != null) {
		 * conn.setAutoCommit(true); DBUtils.closeAll(null, null, conn); } }
		 * catch (SQLException e) { e.printStackTrace(); } }
		 * 
		 * }
		 */
		return executepunctuation;
	}

	@Override
	public Equipment getEquipmentById(String equipmentId) throws Exception {

		return equipmentdao.getEquipmentById(equipmentId);
	}
}
