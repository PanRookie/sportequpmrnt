package com.sportequipment.service;

import java.util.Date;
import java.util.List;

import com.sportequipment.domain.Apply;

public interface ApplyService {
	public abstract int addApply(Apply apply) throws Exception;
	public abstract List<Apply> getApplysByPage(int pageNo, int pageSize,String equipmentId, String loginName,int num,Date applyDate) throws Exception;
	public abstract int getTotalCount(String equipmentId,String loginName,int num,Date applyDate) throws Exception;
	public abstract int deleteMyApply(String equipmentId,String loginName) throws Exception;
	public abstract int passApply(String equipmentId,String loginName,int num,String operatperson) throws Exception;
}
