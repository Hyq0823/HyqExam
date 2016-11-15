package com.hyq.domain;

import java.util.Date;

/**
 * 报名信息 实体
 * @author HYQ
 *
 */
public class ApplyInfo {
	
	/**报名信息id*/
	private int id;
	
	/**报名标题*/
	private String title;
	
	/**报名描述*/
	private String description;
	
	/**报名开始时间*/
	private String startTime;
	
	/**报名信息状态   进行中 、已结束*/
	private String status;
	
	/**报名结束时间*/
	private String endTime;
	
	/**上轮报名id*/
	private Integer parentId;
	
	/**是否手工审核报名考生信息*/
	private String isHandConfirm;
	
	/**未开始*/
	public static String APPLy_NotStart = "未开始";
	
	/**进行中*/
	public static String APPLy_RUNNING = "进行中";
	
	
	/**已结束*/
	public static String APPLy_OVER = "已结束";
	
	
	
	
//============================================================================================

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}


	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	
	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public String getIsHandConfirm() {
		return isHandConfirm;
	}

	public void setIsHandConfirm(String isHandConfirm) {
		this.isHandConfirm = isHandConfirm;
	}
	
	

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	@Override
	public String toString() {
		return "ApplyInfo [id=" + id + ", title=" + title + ", description="
				+ description + ", startTime=" + startTime + ", status="
				+ status + ", endTime=" + endTime + ", parentId=" + parentId
				+ ", isHandConfirm=" + isHandConfirm + "]";
	}

	
	
	
	
	

}
