package com.sportequipment.dao;

import java.util.List;

import com.sportequipment.domain.Collect;



public interface CollectDao {
	public abstract int addCollect(String loginName,String equipmentId) throws Exception;
	public abstract int deleteCollect(String loginName,String equipmentId) throws Exception;
	public abstract List<Collect> getBorrowsByPage(String loginName) throws Exception;
}
