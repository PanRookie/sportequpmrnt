package com.sportequipment.domain;

import java.util.List;

public class Page<T> {
	private int pageCount; // 总页数
	private int totalCount;// 总记录数
	private int pageSize;// 每页大小
	private int pageNo;// 当前页码
	private List<T> list;//当前页数据集合

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getTotalCount() {
		return totalCount;
	}

	// 查数据库后放入
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		this.pageCount = totalCount % pageSize == 0 ? totalCount / pageSize  : totalCount / pageSize + 1;//总记录数，获取总页数
	}

	public int getPageCount() {
		return pageCount;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public List<T> getList() {
		return list;
	}
    //查数据库表后设置
	public void setList(List<T> list) {
		this.list = list;
	}

}
