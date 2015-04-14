package com.saitu.dao.impl;

import org.springframework.stereotype.Component;

import com.saitu.dao.RouteDao;
import com.saitu.model.Route;
import com.saitu.util.PageModel;
@Component("routeDao")
public class RouteDaoImpl extends BaseDaoImpl<Route> implements RouteDao {

	@Override
	public PageModel getAll(int p) {
		return getPageModel(p, null, null);
	}


	@Override
	public PageModel getByName(int p, String name) {
		System.out.println("+++++++++++++++++++++++++++++++++++++getByName"+name);
		if(name==null){
			return getAll(p);
		}
		String where="r where r.name like ?";
		name="%"+name+"%";
		return getPageModel(p, where, new Object[]{name});
	}

	@Override
	public PageModel getByState(int p, String state) {
		state="%"+state+"%";
		return getPageModel(p, "r where r.state like ?", new Object[]{state});
	}

	@Override
	public PageModel getByUser(int p, String user) {
		user="%"+user+"%";
		return getPageModel(p, "r where r.username like ?", new Object[]{user});
	}


	@Override
	public PageModel getByDate(int p, Object[] queryParams) {
		String where="r where r.updateDate between ? and ?";
		return getPageModel(p, where, queryParams);
	}
	
}
