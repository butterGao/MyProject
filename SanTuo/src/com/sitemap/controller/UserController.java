package com.sitemap.controller;
import java.math.BigDecimal;
import java.util.List;
import sun.org.mozilla.javascript.internal.Kit;
import net.loyin.util.PropertiesContent;
import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.sitemap.interceptor.LoginInterceptor;
import com.sitemap.model.Result;
import com.sitemap.system.Authority;
import com.sitemap.system.AuthorityManager;
import com.sitemap.util.TimeUtil;
/**
*用户管理
*/
public class UserController extends BaseController {
	public UserController() {
		this.tableName = st_userInfor;
	}
	
	public void login() {  
		if(getPara("lname").equals("admin")){
				Record user = Db.findFirst("select a.* from st_userInfor a where a.lname=? and a.pwd =? ", getPara("lname"), getPara("pass"));
				//超级管理员权限
				if(user==null){
					renderJson(new Result("用户名或密码不正确"));
				}else{
					user.set("cid", new BigDecimal(0));
					setSessionAttr("cityname", "");
					setSessionAttr("user", user);
					renderJson(new Result(true));
				}
			}else{
				Record user = Db.findFirst("select a.*,b.cid,c.starttime,c.endtime from st_userInfor a,st_role b,st_company c where a.lname=? and a.pwd =? and a.rid=b.id and b.cid =c.id", getPara("lname"), getPara("pass"));
					if (user == null) {
						renderJson(new Result("用户名或密码不正确"));
					} else {
						if(user.getTimestamp("starttime")!=null){
							if(user.getTimestamp("starttime").getTime()<System.currentTimeMillis()&&user.getTimestamp("endtime").getTime()>System.currentTimeMillis()){
								setSessionAttr("user", user);
								setSessionAttr("cityname", Db.queryStr("select area from st_company where id = ?",user.get("cid")));
								renderJson(new Result(true));
							}else{
								renderJson(new Result("账号使用时间到期"));
							}
						}else{
							setSessionAttr("user", user);
							setSessionAttr("cityname", Db.queryStr("select area from st_company where id = ?",user.get("cid")));
							renderJson(new Result(true));
						}
					//权限session
					//setSessionAttr("authority", AuthorityManager.initAuthority(user.getStr("id")));
					}
			}
	}
	
	//查询登陆账号权限
	public void queryAuthority(){
		if(getCid()==0){
			renderJson(	Db.find("select fid from st_role_func where rid=?",0));
					
		}
		else{
//			renderJson(	Db.find("select fid from st_role_func where cid=? and rid="
//					+ "(select id from st_role where id="
//					+ "(select rid from st_userinfor where id=?))",getCid(),getUid()));
			renderJson(Db.find("select * from st_role_func where rid= ? ",((Record)getSessionAttr("user")).getBigDecimal("rid")));
		}
		
		}
	
	public void queryUser(){
		String where ="";
		Db.paginate(getParaToInt("p") == null ? 1 : getParaToInt("p"), 8, "select *", "from " + tableName
				+ where);
	}
}
