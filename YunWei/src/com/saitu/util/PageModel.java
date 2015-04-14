package com.saitu.util;

import java.util.List;

/**
 *  分页
 */
public class PageModel {
	private List list;
	public static int MaxResult=10;
	private int pageNumber;// 当前页
	private int pageSize;// 每页多少条记录 
	private int totalRecords;// 总记录数
	public PageModel() {
	}
	/**
	 * @param pageNumber
	 *            当前页
	 * @param pageSize
	 *            每页多少条记录
	 * @param totalRecords
	 *            总记录数
	 */
	public PageModel(int pageNumber, int pageSize, int totalRecords) {
		if(pageSize>=1){
			this.pageSize = pageSize;
		}else{
			this.pageSize=1;
		}
		this.pageNumber = pageNumber;
		this.totalRecords = totalRecords;
	}

	public int getTotalPage() {
		return (int) Math.ceil(totalRecords / pageSize);
	}

	public int getTopPageNo() {
		return 1;
	}

	public int getNextPage() {
		if (pageNumber >= getTotalPage()) {
			return getTotalPage() == 0 ? 1 : getTotalPage();
		}
		return pageNumber + 1;
	}

	public int getPreviousPage() {
		if (pageNumber <= 1) {
			return 1;
		}
		return pageNumber - 1;
	}

	public int getListPage() {
		return getTotalPage() == 0 ? 1 : getTotalPage();
	}

	public List getList() {
		return list;
	}

	public void setList(List list) {
		this.list = list;
	}

	public int getPageNumber() {
		return pageNumber;
	}

	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getTotalRecords() {
		return totalRecords;
	}

	public void setTotalRecords(int totalRecords) {
		this.totalRecords = totalRecords;
	}

}
