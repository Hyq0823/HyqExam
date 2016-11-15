package com.hyq.domain;


/**
 * 公告实体
 * @author HYQ
 *
 */
public class Notice {
	private int id;
	private String title;
	private String content;
	
	private String deployTime; //发布时间
	private String deployer; //发布人
	
	private int position; //位置
	
	
	
	
	
//============================================================
	
	
	
	public int getId() {
		return id;
	}
	public int getPosition() {
		return position;
	}
	public void setPosition(int position) {
		this.position = position;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getDeployTime() {
		return deployTime;
	}
	public void setDeployTime(String deployTime) {
		this.deployTime = deployTime;
	}
	public String getDeployer() {
		return deployer;
	}
	public void setDeployer(String deployer) {
		this.deployer = deployer;
	}

	
	
	
	

}
