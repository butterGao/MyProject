package com.sitemap.manager;

import java.util.List;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.sitemap.system.pingfen;
import com.sitemap.util.Result;

public class UserManage {
	public static UserManage dao=new UserManage();
	
	
	public Result login(Record r){
		try {
			if(Db.findFirst("select * from users where login_name = ?",r.getStr("login_name"))!=null){
				if(Db.findFirst("select * from users where password = ?",r.getStr("passwordd"))!=null){
					return new Result(true,"登陆成功");
				}
			}else{
				return new Result(false,"用户名错误");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public boolean isKaohe(){
		
		return false;
	}
	
}
