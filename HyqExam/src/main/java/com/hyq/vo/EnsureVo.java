package com.hyq.vo;

import com.hyq.domain.Apply;
import com.hyq.domain.ApplyInfo;
import com.hyq.domain.User;


/**
 * 审核 实体的VO
 * @author HYQ
 *
 */
public class EnsureVo {
	private User user; //user的基本信息
	
	private ApplyInfo applyInfo; //报名基本信息
	
	private Apply apply; //报名表的基本信息

	
	
	//====================================================================
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public ApplyInfo getApplyInfo() {
		return applyInfo;
	}

	public void setApplyInfo(ApplyInfo applyInfo) {
		this.applyInfo = applyInfo;
	}

	public Apply getApply() {
		return apply;
	}

	public void setApply(Apply apply) {
		this.apply = apply;
	}
	
	
	

}
