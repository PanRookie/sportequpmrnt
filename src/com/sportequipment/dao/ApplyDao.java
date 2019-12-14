package com.sportequipment.dao;

import java.sql.Connection;
import java.util.Date;
import java.util.List;

import com.sportequipment.domain.Apply;

public interface ApplyDao {
	public abstract int addApply(Apply apply) throws Exception;
	public int updateApply(Connection conn, String loginName,String equipmentId, int num) throws Exception;
	public int deleteApply(Connection conn,String loginName,String equipmentId) throws Exception;
	public abstract List<Apply> getApplysByPage(int pageNo, int pageSize,String equipmentId, String loginName,int num,Date applyDate) throws Exception;
	public abstract int getTotalCount(String equipmentId,String loginName,int num,Date applyDate) throws Exception;
}
