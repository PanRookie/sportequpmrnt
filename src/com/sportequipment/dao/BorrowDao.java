package com.sportequipment.dao;

import java.sql.Connection;
import java.util.List;

import com.sportequipment.domain.Borrow;

public interface BorrowDao {
	public abstract int addBorrow(Connection conn, String loginName,
			String equipmentId, String operatperson, int num) throws Exception;

	public abstract Borrow findBorrow(String loginname, String equipmentId)
			throws Exception;

	public int updateBorrow(Connection conn, String loginName,
			String equipmentId, int num) throws Exception;

	public abstract List<Borrow> getBorrowsByPage(int pageNo, int pageSize,
			String equipmentId, String loginName) throws Exception;
	
	public int deleteBorrow(Connection conn,String equipmentId,String loginName) throws Exception;
	
	public abstract int getTotalCount(String equipmentId,String loginName) throws Exception;
}
