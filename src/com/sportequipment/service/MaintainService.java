package com.sportequipment.service;

import java.util.List;

import com.sportequipment.domain.Maintain;

public interface MaintainService {
	public abstract List<Maintain> getEquipmentsByPage(int pageNo,
			int pageSize, String equipmentId, String equipmentName,
			String equipmentType, String operatPerson,
			String equipmentspecification) throws Exception;
}
