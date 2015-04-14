package com.saitu.action;

import java.util.Date;

import com.opensymphony.xwork2.ActionSupport;
import com.saitu.dao.CountDao;
import com.saitu.dao.StationDao;

public class CountAction extends ActionSupport{
	private CountDao countDao;
	private int cr;//记录总数
	private int st;//站点更改数
	private Date date1;
	private Date date2;
	private StationDao stationDao;
	public String count(){
		cr=countDao.getRcount(date1, date2);
		st=stationDao.count(date1, date2);
		return "count";
	}
	 
	public void setCountDao(CountDao countDao) {
		this.countDao = countDao;
	}

	
	
	public Date getDate1() {
		return date1;
	}

	public void setDate1(Date date1) {
		this.date1 = date1;
	}

	public Date getDate2() {
		return date2;
	}

	public void setDate2(Date date2) {
		this.date2 = date2;
	}

	public void setCr(int cr) {
		this.cr = cr;
	}

	public void setStationDao(StationDao stationDao) {
		this.stationDao = stationDao;
	}

	public int getSt() {
		return st;
	}

	public void setSt(int st) {
		this.st = st;
	}

	public int getCr() {
		return cr;
	}
	
}
