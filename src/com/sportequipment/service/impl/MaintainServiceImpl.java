package com.sportequipment.service.impl;

import java.util.List;

import com.sportequipment.dao.MaintainDao;
import com.sportequipment.dao.impl.MaintainDaoImpl;
import com.sportequipment.domain.Maintain;
import com.sportequipment.service.MaintainService;

public class MaintainServiceImpl implements MaintainService {
	private MaintainDao maintaindao = new MaintainDaoImpl();

	@Override
	public List<Maintain> getEquipmentsByPage(int pageNo, int pageSize,
			String equipmentId, String equipmentName, String equipmentType,
			String operatPerson, String equipmentspecification)
			throws Exception {
		return maintaindao.getMaintainsByPage(pageNo, pageSize, equipmentId, equipmentName, equipmentType, operatPerson, equipmentspecification);
	}

}
