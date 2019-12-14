package com.sportequipment.util;

import java.sql.Connection;
import java.sql.PreparedStatement;


public class BaseDao {

	// 增刪改方法
	public int executeUpdate(String sql, Object... params) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			conn = DBUtils.getConnection(); 	
			pstmt = conn.prepareStatement(sql);
			if (params != null) {
				for (int i = 0; i < params.length; i++) {
					pstmt.setObject(i + 1, params[i]);
				}
			}
			result = pstmt.executeUpdate();
		} finally {
			DBUtils.closeAll(null, pstmt, conn);
		}
		return result;
	}

	// 增刪改方法
	public int executeUpdate(Connection baseConn, String sql, Object... params) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			if (baseConn != null) {
				conn = baseConn;
			} else {
				conn = DBUtils.getConnection(); 
			}
			pstmt = conn.prepareStatement(sql);
			if (params != null) {
				for (int i = 0; i < params.length; i++) {
					pstmt.setObject(i + 1, params[i]);
				}
			}
			result = pstmt.executeUpdate();
		} finally {
			if (baseConn != null) {
				DBUtils.closeAll(null, pstmt, null);
			} else {
				DBUtils.closeAll(null, pstmt, conn);
			}
		}
		return result;
	}
}
