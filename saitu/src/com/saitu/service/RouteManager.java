package com.saitu.service;

import com.saitu.model.Route;
import com.saitu.util.PageModel;

public interface RouteManager {
	public Route get(int id);
	public void delete(int id);
	public PageModel getAll();//查询所有线路
	public PageModel getByDate(String date1,String date2);//查询时间段线路
	public PageModel getByName(String name);//查询线路名称
	public PageModel getByState(String state);//按状态查询
	public PageModel getByUser(String user);//根据操作员查询
}
