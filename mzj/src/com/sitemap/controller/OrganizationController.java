package com.sitemap.controller;
import java.util.List;
import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.sitemap.interceptor.TaskInterceptor;
/**
 * 设置处室功能
 */
@Before(TaskInterceptor.class)
public class OrganizationController extends BaseController {
	public void index() {
		List<Record> orgs=Db.find("select * from organization_ order by order_num");
		List<Record> org=Db.find("select * from sx_o");
		for(Record os:orgs){
			boolean b=false;
			os.set("lead", 0);
			for(Record o:org){
				if(os.getStr("id").equals(o.getStr("id"))){
					if(o.getStr("lead")!=null){
						os.set("lead", 1);
					}
					b=true;
					break;
				}
			}
			if(b)os.set("on", 1);
			else os.set("on", 0);
		}
		setAttr("orgs", orgs);
		render("/admin/organization_edit.jsp");
	}
	/**
	 * 显示用户
	 */
	public void users(){
		String o_id=getPara("o_id");
		List<Record> users=Db.find("select * from users_ where organization_id=? order by login_name",o_id);
		List<Record> user=Db.find("select u_id from sx_u where o_id=?",o_id);
		String lead=Db.queryStr("select lead from sx_o where id=?",o_id);
		for(Record us:users){
			boolean b=false;
			for(Record u:user){
				if(us.getStr("id").equals(u.getStr("u_id"))){
					b=true;
					break;
				}
			}
			if(us.getStr("id").equals(lead)){
				us.set("lead", 1);
			}
			else {
				us.set("lead", 0);
			}
			
			if(b)us.set("on", 1);
			else us.set("on", 0);
		}
		renderJson(users);
	}
	
	/**
	 * 设置领导
	 */
	public void lead(){
		Db.update("update set lead=? from sx_u where id=?",getPara("u_id"),getPara("u_id"));
	}
	
	/**
	 * 筛选处室
	 */
	public void saveOrg(){
		Db.save("sx_o", new Record().set("id", getPara("o_id")));
	}
	/**
	 * 删除处室
	 */
	public void delOrg(){
		Db.delete("sx_o",new Record().set("id", getPara("o_id")));
	}
	
	/**
	 * 显示处室
	 */
	public void getOrgs(){
		List<Record> orgs=Db.find("select * from organization order by order_num");
		List<Record> org=Db.find("select * from organization_fxg where uid=?",getPara("id"));
		for(Record os:orgs){
			for(Record o:org){
				if(os.getStr("id").equals(o.getStr("oid"))) os.set("checked", 1);
			}
		}
		renderJson(orgs);
	}
	
	/**
	 * 设置分协管
	 */
	public void selectFxg(){
		try {
			String [] orgs=getPara("orgs").split(",");
			String uid=getPara("id");
			Db.update("delete from organization_fxg where uid=?",uid);
			for(String oid:orgs){
				Db.update("insert into organization_fxg values(?,?)",uid,oid);
			}
			renderJson(true);
		} catch (Exception e) {
			renderJson(true);
			e.printStackTrace();
		}
	}
	
	/**
	 * 更新设置
	 */
	public void updateDate(){
		try {
			Db.update("truncate table users");
			Db.update("truncate table organization");
			Db.update("insert into organization(id,short_name,lead,code,name,order_num)  select a.id,a.short_name,b.lead,a.code,a.name,a.order_num from sx_o b LEFT JOIN organization_ a ON (a.id=b.id)");//更新处室
			Db.update("insert into users(id,number,user_name,login_name,password,organization_id) select id,number,user_name,login_name,password,organization_id from users_  where id in(select u_id from sx_u)");//更新用户
			renderJson(true);
		} catch (Exception e) {
			e.printStackTrace();
			renderJson(false);
		}
	}
	
	/**
	 * 筛选用户
	 */
	public void sxUser() {
		String o_id=getPara("o_id");
		String []us=getPara("u_id").split(";");
		try {
			Db.update("delete from sx_u where o_id=?", o_id);
			Db.update("update sx_o set lead=? where id=?",getPara("lead"),o_id);
			for(String u_id:us){
				Db.save("sx_u", new Record().set("u_id",u_id).set("o_id", o_id));
			}
			renderJson(true);
		} catch (Exception e) {
			e.printStackTrace();
			renderJson(false);
		}
	}
}
