package com.hyq.domain;

/***
 * 站内信 --实体
 * @author HYQ
 *
 */
public class Message {
	private Integer id; //
	
	private User sender;//
	private User accepter;  //从页面获取
	private String content;
	
	private String sendTime;
	
	
	private Boolean isGet;      //额外封装
	private String[] userIds; //额外封装
	
	//
	
	
	
	
	
	
//==========================================================================
	
	
	
	public Integer getId() {
		return id;
	}
	public String[] getUserIds() {
		return userIds;
	}
	public void setUserIds(String[] userIds) {
		this.userIds = userIds;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public User getSender() {
		return sender;
	}
	public void setSender(User sender) {
		this.sender = sender;
	}
	public User getAccepter() {
		return accepter;
	}
	public void setAccepter(User accepter) {
		this.accepter = accepter;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSendTime() {
		return sendTime;
	}
	public void setSendTime(String sendTime) {
		this.sendTime = sendTime;
	}
	public Boolean getIsGet() {
		return isGet;
	}
	public void setIsGet(Boolean isGet) {
		this.isGet = isGet;
	}
	
	
	

}
