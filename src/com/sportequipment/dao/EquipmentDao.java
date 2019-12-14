package com.sportequipment.dao;

import java.sql.Connection;
import java.util.List;

import com.sportequipment.domain.Equipment;

public interface EquipmentDao {
	/**
	 * 添加器材
	 * 
	 * @param equipment
	 * @return
	 * @throws Exception
	 */
	public abstract int addEquipment(Equipment equipment) throws Exception;
	
	/**
	 * 记录数
	 * @param equipmentId
	 * @param equipmentName
	 * @param equipmentType
	 * @param operatPerson
	 * @param equipmentspecification
	 * @return
	 * @throws Exception
	 */
	public abstract int getTotalCount(String equipmentId, String equipmentName, String equipmentType,
			String operatPerson, String equipmentspecification) throws Exception;
	
	/**
	 * 分页查询器材
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
	 * id查询器材
	 * @param equipmentId
	 * @return
	 * @throws Exception
	 */
	
	public Equipment getEquipmentById(String equipmentId) throws Exception;
	
	/**
	 * 修改器材数量   设置事务
	 * @param conn
	 * @param equipmentId
	 * @param num
	 * @return
	 * @throws Exception
	 */
	public int updateEquipment(Connection conn, String equipmentId, int num) throws Exception;
	
	/**
	 * 删除器材    设置事务
	 * @param conn
	 * @param equipmentId
	 * @return
	 * @throws Exception
	 */
	public int deleteEquipment(Connection conn,String equipmentId) throws Exception;
}
