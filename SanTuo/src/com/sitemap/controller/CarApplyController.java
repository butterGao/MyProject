package com.sitemap.controller;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.sitemap.interceptor.LoginInterceptor;
/**
*用车申请
*/
@Before(LoginInterceptor.class)
public class CarApplyController extends BaseController{
	public CarApplyController(){
		this.tableName=st_car_Apply;
	}
	
	
	public void show() {
		Page<Record>p;
		if(getCid()==0){
			p=Db.paginate(getParaToInt("page"), getParaToInt("rows"), "select *", "from " + tableName+" order by id desc");

		}else{
			System.out.println(getCid());
			p=Db.paginate(getParaToInt("page"), getParaToInt("rows"), "select *", "from " + tableName+" where userid in"
					+ "(select id from st_userinfor where rid in(select id from st_role where cid =?) ) order by id desc",getCid());

		}
		for(Record r:p.getList()){
			try {
				r.set("CREATETIME",r.get("CREATETIME").toString().substring(0,19));
			} catch (Exception e) {
			}
			try {
				r.set("STARTTIME",r.get("STARTTIME").toString().substring(0,19));
				r.set("ENDTIME",r.get("ENDTIME").toString().substring(0,19));
			} catch (Exception e) {
			}
		}
		renderJson(p);
	}

}
