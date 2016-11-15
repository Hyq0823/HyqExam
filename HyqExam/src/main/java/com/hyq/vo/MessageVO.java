package com.hyq.vo;

/**
 * 消息的vo  
 * @author HYQ
 * 可以方便的获取  你给我发的消息
 *
 */
public class MessageVO {
	private String me;
	private String you;
	
	
	
	
	
	public MessageVO(String me, String you) {
		super();
		this.me = me;
		this.you = you;
	}
	public MessageVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getMe() {
		return me;
	}
	public void setMe(String me) {
		this.me = me;
	}
	public String getYou() {
		return you;
	}
	public void setYou(String you) {
		this.you = you;
	}
	
	
	

}
