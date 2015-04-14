package com.sitemap.controller;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import com.alibaba.fastjson.JSON;
import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.sitemap.interceptor.LoginInterceptor;
import com.sitemap.manager.GradeManage;
import com.sitemap.model.Organization;
import com.sitemap.model.Task;
import com.sitemap.model.Users;
import com.sitemap.system.PingfenCode;
import com.sitemap.system.pingfen;
import com.sitemap.util.TimeUtil;
/**
 * 绩效考核功能
 */
@Before(LoginInterceptor.class)
public class PingfenController extends BaseController {
	public void index() {
		if (getCurrentPower().getType() == 0) {// 领导
			List<Record> task = Db
					.find("select a.id,a.count,a.title,a.open,a.create_time,b.weighter,a.khStart,a.khEnd from task a left JOIN target b on (a.target_id = b.id) where a.commit=1  order by a.create_time desc");
			Iterator<Record> ts = task.iterator();
			while (ts.hasNext()) {
				Record t = ts.next();
				List<pingfen> ps = GradeManage.dao.getPfList(t);
				for (pingfen p : ps) {
					System.out.println(p);
				}
				boolean b = true;
				for (pingfen p : ps) {
					if (p.getId().equals(getOrgId())) {// 判断有没有参与任务
						b = false;
					}
					if (p.getId().equals(getUserId())) {// 判断有没有参与任务
						b = false;
					}
				}
				if (b) {
					ts.remove();
				}
			}
			for (Record t : task) {// 判断有没有完成评分
				if (t.getInt("count") == 0 && TimeUtil.between(t.getTimestamp("khStart"), t.getTimestamp("khEnd"))) {
					if (Db.queryLong("select count(1) from grade where t_id=? and u_id =? and commit = 1 ",
							t.getStr("id"), getUserId()) > 0) {
						// 评分完成
						t.set("over", 1);
					} else {
						t.set("over", 0);
					}
				} else {
					t.set("over", 1);
				}
			}
			setAttr("task", task);
			setAttr("size", task.size());
		} else {// 自评
			List<Record> task = Task.dao.queryTaskForWhere(" and commit= 1 ", getOrgId());
			for (Record t : task) {
				if (t.getInt("count") == 0 && TimeUtil.between(t.getTimestamp("khStart"), t.getTimestamp("khEnd"))) {
					if (Db.queryLong("select count(1) from grade where t_id = ? and u_id = ? and o_id=? and commit=1 ",
							t.getStr("id"), getUserId(), getOrgId()) > 0) {
						t.set("over", 1);
					} else {
						t.set("over", 0);
					}
				} else {
					t.set("over", 1);
				}
			}
			setAttr("task", task);
			setAttr("size", task.size());
		}
		render("/admin/task_list.jsp");
	}

	public void show() {
		String t_id = getPara("id");
		setAttr("t_id", getPara("id"));
		if (getCurrentPower().getType() == 0) {
			System.out.println("上级领导评分");
			List<Record> lists = Organization.dao.querFroTask(getPara("id"));
			// if(Db.queryLong("select count(1) from organization_fxg where uid=?",getUserId())>0){
			// lists=Db.find("select id,short_name from organization where id in (select o_id from task_organization where t_id = ?) and id in(select oid from organization_fxg where uid=?) order by order_num",getPara("id"),getUserId());
			// }
			for (Record o : lists) {
				Integer score = Db.queryInt("select score from grade where t_id=? and u_id=? and o_id =? and lead=0",
						t_id, getUserId(), o.get("id"));
				o.set("score", score);
			}
			setAttr("lists", lists);
			if (getPara("over").equals("1")) {
				render("/admin/pingfen_show.jsp");
			} else {
				setAttr("t_id", t_id);
				render("/admin/pingfen_edit.jsp");
			}
		} else {
			Record zongjie = Db.findFirst("select * from zongjie where t_id = ? and o_id= ?", t_id, getOrgId());
			Record mubiao = Db.findFirst("select * from mubiao where t_id = ? and o_id= ?", t_id, getOrgId());
			setAttr("mubiao", mubiao);
			setAttr("zongjie", zongjie);
			setAttr("t_id", t_id);
			if(getPara("over").equals("1")){
				Integer socre = Db.queryInt("select score from grade where u_id=?and t_id=? and o_id=?", getUserId(), t_id,
						getOrgId());
				setAttr("score", socre);
			}else{
				setAttr("score", 100);
			}
			setAttr("over", getPara("over"));
//			List<pingfen> ps = GradeManage.dao
//					.getPfList(Db
//							.findFirst(
//									"select a.id,a.title,a.open,a.create_time,b.weighter from task a left JOIN target b on (a.target_id = b.id) where a.id=?",
//									t_id));
//			pingfen b = ps.get(1);
//			if (socre == null) {
//				if (b.getType() == 1) {
//					socre = 100;
//				} else {
//					socre = 0;
//				}
//				setAttr("pins", 0);
//			} else {
//				setAttr("pins", 1);
//			}
			render("/admin/pingfen_ziping.jsp");
		}
	}
	/**
	 * 显示填报工作的目标和详情
	 */
	public void showContent() {
		Record zongjie = Db.findFirst("select * from zongjie where t_id = ? and o_id= ? and commit=1", getPara("t_id"),
				getPara("id"));
		Record mubiao = Db.findFirst("select * from mubiao where t_id = ? and o_id= ? and commit=1", getPara("t_id"), getPara("id"));
		Map<String, Object> parameter = new HashMap<String, Object>();
		parameter.put("mubiao", mubiao);
		parameter.put("zongjie", zongjie);
		renderJson(parameter);
	}
	
	public void goQueryAllXq(){
		setAttr("q", 1);
		List<Record> lists = Organization.dao.querFroTask(getPara("id"));
		setAttr("lists", lists);
		setAttr("t_id", getPara("id"));
		render("/admin/pingfen_show.jsp");
	}

	/**
	 * 处室自评
	 */
	public void ziping() {
		try {
			String t_id = getPara("t_id");
			if (Db.queryLong("select count(1) from grade where t_id=? and u_id=? and u_o_id=?", t_id, getUserId(),
					getOrgId()) > 0) {
				Db.update("delete from grade where t_id=? and u_id=? and  u_o_id=?", t_id, getUserId(), getOrgId());
			}
			Db.save("grade",
					new Record().set("u_id", getUserId()).set("commit", 1).set("lead", 1).set("u_o_id", getOrgId())
							.set("t_id", t_id).set("o_id", getOrgId()).set("score", getParaToInt("score")));
			renderJson(true);
		} catch (Exception e) {
			e.printStackTrace();
			renderJson(false);
		}
	}
	/**
	 * 评分
	 */
	public void pingfen() {
		try {
			String t_id = getPara("t_id");
			String u_id = getUserId();
			String o_id = getOrgId();
			int commit = getParaToInt("commit");
			List<PingfenCode> codes = JSON.parseArray(getPara("json"), PingfenCode.class);
			if (Db.queryLong("select count(1) from grade where u_id=? and t_id=? and u_o_id=?", u_id, t_id, o_id) > 0) {// 如果存在就清空
				Db.update("delete from grade where u_id=? and t_id=? and u_o_id = ?", u_id, t_id, o_id);
			}
			for (PingfenCode d : codes) {
				Db.save("grade", new Record().set("t_id", t_id).set("u_id", u_id).set("commit", commit).set("lead", 0)
						.set("o_id", d.getId()).set("score", d.getCode()).set("u_o_id", o_id));
			}
			renderJson(true);
		} catch (Exception e) {
			e.printStackTrace();
			renderJson(false);
		}
	}
}
