package com.sitemap.controller;
import java.util.List;
import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.sitemap.interceptor.LoginInterceptor;
import com.sitemap.model.Organization;
import com.sitemap.model.Task;
import com.sitemap.util.TimeUtil;

@Before(LoginInterceptor.class)
public class ZongjieController extends BaseController {
	public ZongjieController() {
		this.tableName = "zongjie";
	}

	public void index() {
		Organization org = getSessionAttr("org");
		List<Record> rs = Task.dao.queryTaskForWhere("and commit = 1 ", org.getStr("id"));
		for (Record record : rs) {
			// 判断是否完成
			if (record.getInt("open") == 1) {
				record.set("over", 0);
			} else {
				if (Db.queryLong("select count(1) from zongjie where t_id = ? and o_id = ? and commit = 1",
						record.get("id"), org.get("id")) > 0) {
					record.set("over", 1);
				} else {// 未完成 判断是否在可以填写时间
					if (record.getInt("count") == 0
							&& TimeUtil.between(record.getTimestamp("zjStart"), record.getTimestamp("zjEnd"))) {
						// 在可填写时间
						record.set("over", 0);
					} else {
						record.set("over", 1);
					}
				}
			}
		}
		setAttr("task", rs);
		setAttr("size", rs.size());
		render("/admin/task_list.jsp");
	}

	public void yulan() {
		setAttr(tableName, getRecord());
		render("/admin/zongjie_show.jsp");
	}

	public void show() {
		Organization org = getSessionAttr("org");
		String t_id = getPara("id");
		String over = getPara("over");
		Record task = Db.findFirst("select title,id,open from task where id = ?", t_id);
		setAttr(tableName, Db.findFirst("select * from zongjie where t_id = ? and o_id= ?", t_id, org.get("id")));
		setAttr("mubiao", Db.findFirst("select * from mubiao where t_id = ? and o_id= ?", t_id, org.get("id")));
		if (over.equals("0")) {
			setAttr("t_id", t_id);
			setAttr("task", task);
			render("/admin/zongjie_edit.jsp");
		} else {
			setAttr("over", over);
			render("/admin/zongjie_show.jsp");
		}
	}
}
