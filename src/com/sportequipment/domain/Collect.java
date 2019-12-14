package com.sportequipment.domain;

public class Collect {
	public Integer getCollectId() {
		return collectId;
	}
	public void setCollectId(Integer collectId) {
		this.collectId = collectId;
	}
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	public String getEquipmentId() {
		return equipmentId;
	}
	public void setEquipmentId(String equipmentId) {
		this.equipmentId = equipmentId;
	}
	private Integer collectId;
	private String loginName;
	private String equipmentId;
}
