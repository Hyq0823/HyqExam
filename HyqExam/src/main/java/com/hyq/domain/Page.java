package com.hyq.domain;

import java.util.List;

public class Page {

	private int pageSize; // 页面记录数
	private int pageNum; // 页号
	private int totalRecord; // 总记录数

	private int totalPage; // 总页数
	private List list;// 页面数据
	private int startIndex;// 记录数据库从哪里取数据

	private int startPage;// 开始页号
	private int endPage; // 结束页号

	public Page(int pageNum, int pageSize, int totalRecord) {
		this.pageNum = pageNum;
		this.pageSize = pageSize;
		this.totalRecord = totalRecord;

		// 根据总记录数 和单个页面的记录数 计算总页数
		if (this.totalRecord % this.pageSize == 0) {
			this.totalPage = this.totalRecord / this.pageSize;
		} else {
			this.totalPage = this.totalRecord / this.pageSize + 1;
		}

		// 数据库开始索引是 想看的页号 -1 乘上一页的记录数
		// 加入一页10条
		// 比如看第一页 开始就是0
		// 比如看第2页 开始就是 2 -1 * 10 = 10
		// 比如看第3页 开始就是 3 -1 * 10 = 20
		startIndex = (pageNum - 1) * pageSize;

		// 如果页面总记录数小于一个页面的大小
		if (this.totalRecord < this.pageSize) {
			// 表示要看第一页
			this.startPage = 1;
			this.totalRecord = this.pageSize;

			this.endPage = this.totalRecord; // 结束页设置为总记录数的大小
		}
		else // 总记录 10条 页面大小3 pageNum = 2
		{
			startPage = pageNum - 2;
			endPage = pageNum + 2; // 控制显示5个页号在页面上

			if (startPage < 1) {
				startPage = 1;
				endPage = 4;
			}
			if (endPage > totalPage) {
				endPage = totalPage;
			}
		}
	}
	
	

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getTotalRecord() {
		return totalRecord;
	}

	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public List getList() {
		return list;
	}

	public void setList(List list) {
		this.list = list;
	}

	public int getStartIndex() {
		return startIndex;
	}

	public void setStartIndex(int startIndex) {
		this.startIndex = startIndex;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	
	
	
	
	

}
