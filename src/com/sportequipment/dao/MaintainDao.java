package com.sportequipment.dao;

import java.sql.Connection;
import java.util.List;

import com.sportequipment.domain.Maintain;


public interface MaintainDao {
	public abstract int addEquipment(Connection conn,Maintain maintain) throws Exception;
	
	public abstract Maintain getEquipmentById(String equipmentId) throws Exception;
	
	public int updateEquipment(Connection conn, String equipmentId, int num) throws Exception;
	
	public abstract int getTotalCount(String equipmentId, String equipmentName, String equipmentType,String operatPerson, String equipmentspecification) throws Exception;
    
	public abstract List<Maintain> getMaintainsByPage(int pageNo, int pageSize,
			String equipmentId, String equipmentName, String equipmentType,
			String operatPerson, String equipmentspecification)
			throws Exception;
}
