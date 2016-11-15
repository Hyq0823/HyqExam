package com.hyq.vo;

/**
 * 用于  【审核的时候】 确定上一个和下一个用户id
 * @author HYQ
 *
 */
public class ResumeVo {
	private String userId; //当前用户id
	private Integer applyId; //申请表id
	private Integer infoId; //申请信息表id
	
	
	
	
	
	
	public ResumeVo(String userId2, Integer applyId2, Integer infoId2) {
		this.userId = userId2;
		this.applyId = applyId2;
		this.infoId = infoId2;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public Integer getApplyId() {
		return applyId;
	}
	public void setApplyId(Integer applyId) {
		this.applyId = applyId;
	}
	public Integer getInfoId() {
		return infoId;
	}
	public void setInfoId(Integer infoId) {
		this.infoId = infoId;
	}
	
	
	
	

}
