package com.sitemap.controller;
import java.util.List;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.sitemap.util.TimeUtil;
/**
*聊天管理
*/
public class CallController extends BaseController {
	public CallController(){
		this.tableName="st_chat";
	}
	/**
	 *查询未读信息
	 */
	public void queryInfo() {
		try {
			String uid="";
			for(String id:getPara("uid").split(",")){
				uid+=id+",";
			}
			uid=uid.substring(0,uid.length()-1);
			List<Record> rs=Db.find("select * from st_chat where mid in("+uid+") and otherid =? and status= 0", getPara("sid"));
			for(Record r:rs){
				try {
					oracle.sql.TIMESTAMP time=r.get("CALLDATE");
					r.set("CALLDATE", time.timestampValue());
				} catch (Exception e) {
					
				}
			}
			renderJson(rs);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 *已查看信息
	 */
	public void lookInfo() {
		Db.update("update st_chat set status =1 where id =?", getPara("id"));
		renderJson();
	}
	/**
	 *跳转到聊天页面
	 */
	public void call(){
		Record pram=getRecord();
		try {
			pram.set("callname",getPara("callname"));
		} catch (Exception e) {
		}
		setAttr("pram", pram);
		render("/call.jsp");
	}
	/**
	 *插入一条信息
	 */
	public void insert() {
		try {
			String uname=getName(getPara("mid"));
			for(String otherid:getPara("otherid").split(",")){
				String sname=getName(otherid);
				System.out.println(uname+sname);
				Db.save(tableName,getRecord().set("id","chatSequ.nextval").set("ctype", 1).set("otherid", otherid)
							.set("mname", uname).set("othername", sname).set("createtime",TimeUtil.getNewDate()).set("status", 0));
			}
			renderJson(true);
		} catch (Exception e) {
			e.printStackTrace();
			renderJson(false);
		}
	}
	
	public String getName(String id){
		return Db.queryStr("select uname from st_userinfor where id = ?",id);
	}
}
