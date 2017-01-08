package com.hyq.domain;

import java.util.Date;

public class User {
	/**用户UUID**/
	private String id; 
	
	/**用户网站昵称*/
	private String nickname;
	
	/**用户真实姓名*/
	private String truename;
	
	/**用户密码*/
	private String password;
	
	/**用户邮箱*/
	private String email;
	
	/**用户身份证号*/
	private String idCardNumber;
	
	/**用户电话*/
	private String phone;
	
	/**用户地址*/
	private String address;
	
	/**所受教育*/
	private String education;
	
	/**就职经历*/
	private String emplore;
	
	/**其他想说的*/
	private String other;
	
	/**性别*/
	private String sex;
	
	/**证件类型*/
	private String idCardType;
	
	/**出生年月*/
	private String birth;
	
	/**当前状态*/
	private String status;
	
	/**从医信息*/
	private String doctorInfo;
	
	private Role role;
	
	
	/**微信openid*/
	private String openid;
	
	/**微信unionid*/
	private String unionid;
	/**头像*/
	private String headimg;
	
//====================================================================
	public String getOpenid() {
		return openid;
	}

	public void setOpenid(String openid) {
		this.openid = openid;
	}

	public String getUnionid() {
		return unionid;
	}

	public void setUnionid(String unionid) {
		this.unionid = unionid;
	}

	public String getHeadimg() {
		return headimg;
	}

	public void setHeadimg(String headimg) {
		this.headimg = headimg;
	}

	public String getId() {
		return id;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public User(String id) {
		super();
		this.id = id;
	}

	public User() {
		super();
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", nickname=" + nickname + ", truename="
				+ truename + ", password=" + password + ", email=" + email
				+ ", idCardNumber=" + idCardNumber + ", phone=" + phone
				+ ", address=" + address + ", education=" + education
				+ ", emplore=" + emplore + ", other=" + other + ", sex=" + sex
				+ ", idCardType=" + idCardType + ", birth=" + birth
				+ ", status=" + status + ", doctorInfo=" + doctorInfo + "]";
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getIdCardType() {
		return idCardType;
	}

	public void setIdCardType(String idCardType) {
		this.idCardType = idCardType;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDoctorInfo() {
		return doctorInfo;
	}

	public void setDoctorInfo(String doctorInfo) {
		this.doctorInfo = doctorInfo;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getTruename() {
		return truename;
	}

	public void setTruename(String truename) {
		this.truename = truename;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getIdCardNumber() {
		return idCardNumber;
	}

	public void setIdCardNumber(String idCardNumber) {
		this.idCardNumber = idCardNumber;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEducation() {
		return education;
	}

	public void setEducation(String education) {
		this.education = education;
	}

	public String getEmplore() {
		return emplore;
	}

	public void setEmplore(String emplore) {
		this.emplore = emplore;
	}

	public String getOther() {
		return other;
	}

	public void setOther(String other) {
		this.other = other;
	}
	
	
	
	
	
}
