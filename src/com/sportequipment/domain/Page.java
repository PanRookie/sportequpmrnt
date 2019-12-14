package com.sportequipment.domain;

import java.util.List;

public class Page<T> {
	private int pageCount; // ��ҳ��
	private int totalCount;// �ܼ�¼��
	private int pageSize;// ÿҳ��С
	private int pageNo;// ��ǰҳ��
	private List<T> list;//��ǰҳ���ݼ���

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getTotalCount() {
		return totalCount;
	}

	// �����ݿ�����
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		this.pageCount = totalCount % pageSize == 0 ? totalCount / pageSize  : totalCount / pageSize + 1;//�ܼ�¼������ȡ��ҳ��
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
    //�����ݿ�������
	public void setList(List<T> list) {
		this.list = list;
	}

}
