package com.saitu.dao;


import com.saitu.model.Route;
import com.saitu.util.PageModel;
public interface RouteDao extends BaseDao<Route>{
	public PageModel getAll(int p);//查询所有线路
	public PageModel getByDate(int p,Object[] queryParams);//查询时间段线路
	public PageModel getByName(int p,String name);//查询线路名称
	public PageModel getByState(int p,String state);//按状态查询
	public PageModel getByUser(int p,String user);//根据操作员查询
}
