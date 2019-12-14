package com.sportequipment.service.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import com.sportequipment.dao.ApplyDao;
import com.sportequipment.dao.BorrowDao;
import com.sportequipment.dao.impl.ApplyDaoImpl;
import com.sportequipment.dao.impl.BorrowDaoImpl;
import com.sportequipment.domain.Apply;
import com.sportequipment.service.ApplyService;
import com.sportequipment.util.DBUtils;

public class ApplyServiceImpl implements ApplyService {
	private ApplyDao applydao = new ApplyDaoImpl();

	@Override
	public int addApply(Apply apply) throws Exception {
		// TODO Auto-generated method stub
		return applydao.addApply(apply);
	}

	@Override
	public List<Apply> getApplysByPage(int pageNo, int pageSize,
			String equipmentId, String loginName, int num, Date applyDate)
			throws Exception {
		// TODO Auto-generated method stub
		return applydao.getApplysByPage(pageNo, pageSize, equipmentId,
				loginName, num, applyDate);
	}

	@Override
	public int getTotalCount(String equipmentId, String loginName, int num,
			Date applyDate) throws Exception {
		// TODO Auto-generated method stub
		return applydao.getTotalCount(equipmentId, loginName, num, applyDate);
	}

	@Override
	public int deleteMyApply(String equipmentId, String loginName)
			throws Exception {
		// TODO Auto-generated method stub
		Connection conn = DBUtils.getConnection();
		return applydao.deleteApply(conn, loginName, equipmentId);
	}

	@Override
	public int passApply(String equipmentId, String loginName, int num,
			String operatperson) throws Exception {
		Connection conn = null;
		BorrowDao borrowdao = new BorrowDaoImpl();
         int executepunctuation = 0;
		try {
			conn = DBUtils.getConnection();
			conn.setAutoCommit(false);
			applydao.deleteApply(conn, loginName, equipmentId);
			if (borrowdao.findBorrow(loginName, equipmentId) == null) {

				borrowdao.addBorrow(conn, loginName, equipmentId, operatperson,num);
				conn.commit();

			} else {
				borrowdao.updateBorrow(conn, loginName, equipmentId, num);
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

		return executepunctuation;
	}

}
