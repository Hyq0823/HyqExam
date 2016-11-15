package com.hyq.domain;

/**
 * 报名表
 * @author HYQ
 *
 */
public class Apply {
	/**报名号id*/
	private int id;
	
	/**报名信息id*/
	private int applyInfoId;
	
	/**考生id*/
	private String userId;
	
	/**报名考生状态  待审核、已通过、未通过*/
	private String applyStatus;
	
	public static String STANDBY_ENSURE = "待审核";
	
	public static String PASS = "已通过";
	
	public static String FAIL = "未通过";
	
	
	

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getApplyInfoId() {
		return applyInfoId;
	}

	public void setApplyInfoId(int applyInfoId) {
		this.applyInfoId = applyInfoId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getApplyStatus() {
		return applyStatus;
	}

	public void setApplyStatus(String applyStatus) {
		this.applyStatus = applyStatus;
	}
	
	
	

}
