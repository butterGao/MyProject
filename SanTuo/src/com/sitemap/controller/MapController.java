package com.sitemap.controller;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Db;
import com.sitemap.interceptor.LoginInterceptor;
/**
*地图管理类
*/
@Before(LoginInterceptor.class)
public class MapController extends BaseController{
	public void queryGPS(){
		renderJson(Db.find("select * from st_gps_history where userid= ? and createtime between ? and ?"
				,getPara("userid"),getRecord().get("starttime"),getRecord().get("endtime")));
	}
}
