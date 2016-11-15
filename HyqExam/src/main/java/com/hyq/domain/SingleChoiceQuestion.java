package com.hyq.domain;

/**
 * 单选题
 * @author HYQ
 *
 */
public class SingleChoiceQuestion extends BaseQuestion 
{
	private String itemA;
	private String itemB;
	
	
	/**剩下的选项    范围 0-5  */
	private String lastItem; //
	private String trueItem; //正确选项
	
	
	
//========================================================================
	public String getItemA() {
		return itemA;
	}

	public void setItemA(String itemA) {
		this.itemA = itemA;
	}

	public String getItemB() {
		return itemB;
	}

	public void setItemB(String itemB) {
		this.itemB = itemB;
	}



	public String getLastItem() {
		return lastItem;
	}

	public void setLastItem(String lastItem) {
		this.lastItem = lastItem;
	}

	public String getTrueItem() {
		return trueItem;
	}

	public void setTrueItem(String trueItem) {
		this.trueItem = trueItem;
	}
	
	
	
	
	
	
}
