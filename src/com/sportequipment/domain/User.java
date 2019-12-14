package com.sportequipment.domain;

public class User {
	private Integer userid;
	private String loginname; // 登录名
	private String password; // 登录密码
	private String username; // 真实姓名
	private String sex; // 性别
	private String schoolposition; // 职位
	private String dapartment; // 直属学院
	private String major; // 专业
	private String phonenumber; // 电话
	private String email; // 邮箱
	public Integer getUserid() {
		return userid;
	}
	public void setUserid(Integer userid) {
		this.userid = userid;
	}
	public String getLoginname() {
		return loginname;
	}
	public void setLoginname(String loginname) {
		this.loginname = loginname;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getSchoolposition() {
		return schoolposition;
	}
	public void setSchoolposition(String schoolposition) {
		this.schoolposition = schoolposition;
	}
	public String getDapartment() {
		return dapartment;
	}
	public void setDapartment(String dapartment) {
		this.dapartment = dapartment;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public String getPhonenumber() {
		return phonenumber;
	}
	public void setPhonenumber(String phonenumber) {
		this.phonenumber = phonenumber;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getIdentityCode() {
		return identityCode;
	}
	public void setIdentityCode(String identityCode) {
		this.identityCode = identityCode;
	}
	private String identityCode; // 身份证号码
}
