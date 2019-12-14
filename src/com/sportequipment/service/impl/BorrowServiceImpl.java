package com.sportequipment.service.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.sportequipment.dao.BorrowDao;
import com.sportequipment.dao.EquipmentDao;

import com.sportequipment.dao.impl.BorrowDaoImpl;
import com.sportequipment.dao.impl.EquipmentDaoImpl;
import com.sportequipment.domain.Borrow;

import com.sportequipment.service.BorrowService;
import com.sportequipment.util.DBUtils;

public class BorrowServiceImpl implements BorrowService {
	private BorrowDao borrowdao = new BorrowDaoImpl();
	private EquipmentDao equipmentdao = new EquipmentDaoImpl();

	@Override
	public int lendEquipment(String loginName, String equipmentId,
			String operatperson, int equipmentnum) throws Exception {
		Connection conn = null;
		int executepunctuation = 0;

		int equipmentmount = equipmentdao.getEquipmentById(equipmentId)
				.getEquipmentAmount();
		if (equipmentmount == 0) {
			executepunctuation = 4;
		} else if (equipmentnum <= equipmentmount) {

			try {

				conn = DBUtils.getConnection();
				conn.setAutoCommit(false);
				
				equipmentdao.updateEquipment(conn, equipmentId, -equipmentnum);
				
				
				if (borrowdao.findBorrow(loginName, equipmentId) == null) {

					borrowdao.addBorrow(conn, loginName, equipmentId,
							operatperson, equipmentnum);
					conn.commit();

				} else {
					
					borrowdao.updateBorrow(conn, loginName, equipmentId,
							equipmentnum);
					conn.commit();
				}
				
				
				executepunctuation = 3;
			} catch (Exception e) {
				try {
					if (conn != null)
						conn.rollback();
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

		} else {
			executepunctuation = 1;
		}
		return executepunctuation;
	}

	@Override
	public List<Borrow> getEquipmentsByPage(int pageNo, int pageSize,
			String equipmentId, String loginName) throws Exception {
		return borrowdao.getBorrowsByPage(pageNo, pageSize, equipmentId,
				loginName);
	}

	@Override
	public int returnBorrow(String loginName, String equipmentId,
			int equipmentnum) throws Exception {
		Connection conn = null;
		int executepunctuation = 0;

		try {
			conn = DBUtils.getConnection();
			conn.setAutoCommit(false);
			equipmentdao.updateEquipment(conn, equipmentId, equipmentnum);
			executepunctuation = 1;
			if (borrowdao.findBorrow(loginName, equipmentId)
					.getEquipmentcount() == equipmentnum) {
				borrowdao.deleteBorrow(conn, equipmentId, loginName);
			} else {
				borrowdao.updateBorrow(conn, loginName, equipmentId,
						-equipmentnum);
			}
			conn.commit();
			executepunctuation = 2;
		} catch (Exception e) {
			try {
				if (conn != null)
					conn.rollback();
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

		return executepunctuation;
	}

	@Override
	public int deleteEquipment(String equipmentId, String loginName,int equipmentnum)
			throws Exception {
		Connection conn = DBUtils.getConnection();
		int result = 0;
		if (borrowdao.findBorrow(loginName, equipmentId).getEquipmentcount() == equipmentnum) {
			result = borrowdao.deleteBorrow(conn, equipmentId, loginName);
		} else {
			result = borrowdao.updateBorrow(conn, loginName, equipmentId,-equipmentnum);
		}
		return result;
	}

}
