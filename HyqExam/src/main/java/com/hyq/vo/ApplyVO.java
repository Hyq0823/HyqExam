package com.hyq.vo;

/**
 * 报名信息和用户的中间VO实体
 * @author HYQ
 * 用与查询一个用户（id）是否报过了 一个名(infoId)
 *
 */
public class ApplyVO  
{
	/**报名信息id*/
	private Integer applyInfoId;
	/**用户id*/
	private String userId;
	
	
	
	
	
	
	public ApplyVO(Integer applyInfoId, String userId) {
		this.applyInfoId = applyInfoId;
		this.userId = userId;
	}
	public ApplyVO() {
		super();
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
	
	
	
	
}
