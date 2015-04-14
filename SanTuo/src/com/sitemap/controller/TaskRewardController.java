package com.sitemap.controller;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.sitemap.interceptor.LoginInterceptor;
import com.sitemap.util.TimeUtil;
import net.loyin.jFinal.anatation.RouteBind;
/**
*任务奖励 
*/
@RouteBind(path="/tr")
@Before(LoginInterceptor.class)
public class TaskRewardController extends BaseController {
	public TaskRewardController() {
		this.tableName = st_reward;
	}
	
	public void show() {
		Page<Record>p;
		if(getCid()==0){
			p=Db.paginate(getParaToInt("page"), getParaToInt("rows"), "select *", "from " + tableName+"order by id desc");

		}else{
			p=Db.paginate(getParaToInt("page"), getParaToInt("rows"), "select *", "from " + tableName+" where  cid =? order by id desc",getCid());

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
	
	public void save(){
		Db.save(tableName,getRecord().remove("oper").set("id", "userSequ.nextval").set("cid", getCid()));
	}
	
}
