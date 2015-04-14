package com.sitemap.controller;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.sitemap.interceptor.LoginInterceptor;
import com.sitemap.interceptor.TaskInterceptor;
import com.sitemap.manager.GradeManage;
import com.sitemap.model.Grade;
import com.sitemap.model.Organization;
/**
 * 指标管理
 */
public class TargetController extends BaseController{
	public TargetController(){
		this.tableName="target";
	}
	
	public void index(){
		setAttr("lists", Db.find("select * from target order by create_time desc"));
		setAttr("size", Db.find("select id from target").size()); 
		render("/admin/target_list.jsp");
	}
	/**
	 * 显示指标
	 */
	public void show(){
		String id = this.getPara("id");
		Record target=Db.findById(tableName, id);
		String weighter=target.get("weighter");
		setAttr("lists", GradeManage.dao.getPingfens(weighter));
		setAttr(tableName,target);
		render("/admin/target_show.jsp");
	}
	
	public void yulan(){
		setAttr(tableName, getRecord());
		setAttr("yulan", 1);
		render("/admin/target_show.jsp");
	}
	
	
	@Before(TaskInterceptor.class)
	public void edit(){
		setAttr("orgs", Organization.dao.queryEasy());
		goShow("/admin/target_edit.jsp");
	}
	
}
