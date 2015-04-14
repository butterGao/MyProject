package com.sitemap.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import net.loyin.jFinal.anatation.RouteBind;
import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.sitemap.interceptor.LoginInterceptor;
/**
*报警历史
*/
@RouteBind (path="/warn")
@Before(LoginInterceptor.class)
public class WaringHistoryController extends BaseController {
	public WaringHistoryController(){
		this.tableName=st_waring_history;
	}
	public void index(){
		List<Record> draws=Db.find("select a.*,b.uname from st_waring a,st_userinfor b where a.drawid=b.id and a.cid =?",getCid());
				for(Record r:draws){
					try {
						r.set("STARTTIME",r.get("STARTTIME").toString().substring(0,16));
						r.set("ENDTIME",r.get("ENDTIME").toString().substring(0,16));
					} catch (Exception e) {
					}
				}
		setAttr("draws", draws);
		render("/warning.jsp");
	}
	public void col(){
		try {
			if (getPara("oper").equals("add")) {
				Db.save(tableName, getRecord().remove("oper").set("id", "waring_historySequ.nextval").set("userid",1));
			} else if (getPara("oper").equals("del")) {
				Db.deleteById(tableName, getPara("id"));
			} else if (getPara("oper").equals("edit")) {
				Db.update(tableName, getRecord().remove("oper"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		renderJson(true);
	}
	
	public void dingwei(){
		renderJson(Db.findFirst("select * from st_gps_history where id =(select max(id) from st_gps_history where userid=?)",getPara("id")));
	}
	/**
	 *查询报警区域和区域中人员
	 */
	public void queryWaring(){
		Map<String, Object> parameter = new HashMap<String, Object>();
		parameter.put("LNGLAT", Db.queryStr("select lnglat from st_waring where id =?",getPara("id")));
		parameter.put("users", Db.find("select * from st_waring_people where wid =?",getPara("id")));
		renderJson(parameter);
	}
	/**
	 *删除报警区域中的人员
	 */
	public void deletePeo(){
		renderJson(Db.deleteById(st_waring_people,"userid",getPara("id")));
	}
	/**
	 *删除报警区域
	 */
	public void deleteDraw(){
		renderJson(Db.deleteById(st_waring,getPara("id")));
	}
	/**
	 *绘制一个报警区域
	 */
	public void addwarn(){
		Integer id=Db.findFirst("select waringSequ.nextval as id from DUAL").getBigDecimal("id").intValue();
		Db.save(st_waring, getRecord().remove("otherid").set("id", id)
				.set("cid", getCid()).set("drawid", getUid()));
		for(String uid:getPara("otherid").split(",")){//删除所有已在区域中的人员
			Db.deleteById(st_waring_people,"userid",uid);
		}
		for(String uid:getPara("otherid").split(",")){
			Integer ids=Db.findFirst("select waring_peopleSequ.nextval as id from DUAL").getBigDecimal("id").intValue();
			Db.update("insert into st_waring_people(WID, ID, USERID,USERNAME) "
					+ "values(?, ?, ?,(select uname from ST_USERINFOR where id= ?))",id,
					ids,uid,uid);
//			Db.save(st_waring_people, new Record().set("id", "waring_historySequ.nextval")
//					.set("userid", uid).set("wid", id));
		}
		renderJson(true);
	}
}
