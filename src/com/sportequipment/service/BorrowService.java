package com.sportequipment.service;

import java.util.List;

import com.sportequipment.domain.Borrow;

public interface BorrowService {
	public abstract int lendEquipment(String loginName, String equipmentId,
			String operatperson, int equipmentnum) throws Exception;
	

	public abstract List<Borrow> getEquipmentsByPage(int pageNo, int pageSize,
			String equipmentId, String loginName) throws Exception;
	
	public abstract int returnBorrow(String loginName, String equipmentId, int equipmentnum) throws Exception;
	
	public int deleteEquipment(String equipmentId,String loginName,int equipmentnum) throws Exception;
}
