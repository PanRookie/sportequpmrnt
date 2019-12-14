package com.sportequipment.domain;

import java.util.Date;

public class Borrow {

	public String getEquipmentId() {
		return equipmentId;
	}

	public void setEquipmentId(String equipmentId) {
		this.equipmentId = equipmentId;
	}

	public Date getLendDate() {
		return lendDate;
	}

	public void setLendDate(Date lendDate) {
		this.lendDate = lendDate;
	}

	public Date getWillDate() {
		return willDate;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public void setWillDate(Date willDate) {
		this.willDate = willDate;
	}

	public Date getRetuenDate() {
		return retuenDate;
	}

	public void setRetuenDate(Date retuenDate) {
		this.retuenDate = retuenDate;
	}

	public String getOperatperson() {
		return operatperson;
	}

	public void setOperatperson(String operatperson) {
		this.operatperson = operatperson;
	}

	public Integer getEquipmentcount() {
		return equipmentcount;
	}

	public void setEquipmentcount(Integer equipmentcount) {
		this.equipmentcount = equipmentcount;
	}

	public Integer getBorrowId() {
		return borrowId;
	}

	public void setBorrowId(Integer borrowId) {
		this.borrowId = borrowId;
	}
	private Integer borrowId;
	private String loginName;
	private String equipmentId;
	private Date lendDate;
	private Date willDate;
	private Date retuenDate;
	private String operatperson;
	private Integer equipmentcount;

}
