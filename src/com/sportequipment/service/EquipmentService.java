package com.sportequipment.service;

import java.util.List;

import com.sportequipment.domain.Equipment;

public interface EquipmentService {
	/**
	 * Ìí¼ÓÆ÷²ÄÒµÎñ
	 * @param equipment
	 * @return
	 * @throws Exception
	 */
	public abstract int addEquipment(Equipment equipment) throws Exception;
	/**
	 * Ìõ¼þ²éÑ¯Æ÷²Ä
	 * @param pageNo
	 * @param pageSize
	 * @param equipmentId
	 * @param equipmentName
	 * @param equipmentType
	 * @param operatPerson
	 * @param equipmentspecification
	 * @return
	 * @throws Exception
	 */
	public abstract List<Equipment> getEquipmentsByPage(int pageNo, int pageSize,
			String equipmentId, String equipmentName, String equipmentType,
			String operatPerson, String equipmentspecification)
			throws Exception;
	
	/**
	 * É¾³ýÆ÷²Ä
	 * @param equipmentId
	 * @return
	 * @throws Exception
	 */
	public int deleteEquipment(String equipmentId,int num) throws Exception;
	

	public int maintainEquipment(String equipmentId,int num) throws Exception;
	
	/**
	 * ¸ù¾ÝÆ÷²ÄIDÕÒÆ÷²Ä
	 * @param equipmentId
	 * @return
	 * @throws Exception
	 */
	public Equipment getEquipmentById(String equipmentId) throws Exception;
}
