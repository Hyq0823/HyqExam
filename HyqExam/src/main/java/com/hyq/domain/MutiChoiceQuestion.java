package com.hyq.domain;

public class MutiChoiceQuestion  extends BaseQuestion
{
	private String item; //选项
	private String trueItem; //正确选项
	
	
	public String getTrueItem() {
		return trueItem;
	}
	public void setTrueItem(String trueItem) {
		this.trueItem = trueItem;
	}
	public String getItem() {
		return item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	
	
}
