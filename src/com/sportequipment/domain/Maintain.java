package com.sportequipment.domain;

import java.util.Date;

public class Maintain {
	public String getEquipmentId() {
		return equipmentId;
	}
	public void setEquipmentId(String equipmentId) {
		this.equipmentId = equipmentId;
	}
	public String getEquipmentName() {
		return equipmentName;
	}
	public void setEquipmentName(String equipmentName) {
		this.equipmentName = equipmentName;
	}
	public String getEquipmentType() {
		return equipmentType;
	}
	public void setEquipmentType(String equipmentType) {
		this.equipmentType = equipmentType;
	}
	public float getEquipmentPrice() {
		return equipmentPrice;
	}
	public void setEquipmentPrice(float equipmentPrice) {
		this.equipmentPrice = equipmentPrice;
	}
	public Integer getEquipmentAmount() {
		return equipmentAmount;
	}
	public void setEquipmentAmount(Integer equipmentAmount) {
		this.equipmentAmount = equipmentAmount;
	}
	public String getEquipmentspecification() {
		return equipmentspecification;
	}
	public void setEquipmentspecification(String equipmentspecification) {
		this.equipmentspecification = equipmentspecification;
	}
	public Date getPutime() {
		return putime;
	}
	public void setPutime(Date putime) {
		this.putime = putime;
	}
	public String getOperatPerson() {
		return operatPerson;
	}
	public void setOperatPerson(String operatPerson) {
		this.operatPerson = operatPerson;
	}
	private String equipmentId;
	private String equipmentName;
	private String equipmentType;
	private float equipmentPrice;
	private Integer equipmentAmount;
	private String equipmentspecification;
	private Date putime;
	private String operatPerson;
}
