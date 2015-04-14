package com.sitemap.controller;
import java.sql.Timestamp;
import java.util.List;
import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.sitemap.interceptor.LoginInterceptor;
import com.sitemap.interceptor.TaskInterceptor;
import com.sitemap.manager.ExcelManager;
import com.sitemap.manager.GradeManage;
import com.sitemap.model.Organization;
import com.sitemap.model.Target;
import com.sitemap.util.EXcelUtil;
import com.sitemap.util.TimeUtil;

/**
 * 任务管理
 */
public class TaskController extends BaseController {
	public TaskController() {
		this.tableName = "task";
	}
	
	@Before(TaskInterceptor.class)
	public void edit() {
		List<Record> orgs= Organization.dao.queryEasy();
		orgs.remove(0);
		setAttr("orgs", orgs);
		setAttr("targets", Target.dao.queryEasy());
		goShow("/admin/task_edit.jsp");
	}
	public void show() {
		System.out.println(Db.findById(tableName, getPara("id")).getInt("commit"));
		if(Db.findById(tableName, getPara("id")).getInt("commit")==0){
			List<Record> orgs= Organization.dao.queryEasy();
			List<Record> org= Organization.dao.querFroTask(getPara("id"));
			orgs.remove(0);
			for(Record os:orgs){
				os.set("checked", 0);
				for(Record o:org){
					if(os.getStr("id").equals(o.getStr("id"))) os.set("checked", 1);
				}
			}
			setAttr("orgs", orgs);
			setAttr("targets", Target.dao.queryEasy());
			goShow("/admin/task_edit.jsp");
		}else{
			setAttr("orgs", Organization.dao.querFroTask(getPara("id")));
			goShow("/admin/task_show.jsp");
		}
	}
	@Before(TaskInterceptor.class)
	public void save() {
		try {//解析传来的所有组织
			String []ids=getPara("orgs_id").split(",");
			Record task=getRecord();
			String t_id=getPara("id");
			task.set("create_time", TimeUtil.getNewDate())
			.set("mbstart", getTime(getPara("mbstart")))
			.set("mbend", getTimeEnd(getPara("mbend")))
			.set("zjstart", getTime(getPara("zjstart")))
			.set("zjend", getTimeEnd(getPara("zjend")))
			.set("khstart", getTime(getPara("khstart")))
			.set("khend", getTimeEnd(getPara("khend")))
			.set("open", 0) .set("count", 0)
			.set("content", getPara("content"));
			task.remove("orgs_id");
			if(t_id.equals("")){//id为空 新增
				t_id=TimeUtil.getStringTime();
				task.set("id", t_id);
				Db.save("task", task);
			}else{//更新
				System.out.println(t_id);
				Db.update("delete from task_organization where t_id= ? ",t_id);//清空参与任务组织
				
				Db.update("task", task);
			}
			for(String o_id:ids){//保存所有参与任务的组织
				Db.update("insert into task_organization (t_id,o_id) values(?,?)",t_id,o_id);
			}
			renderJson(true);
		} catch (Exception e) {
			e.printStackTrace();
			renderJson(false);
		}
	}
	/**
	 * 统计
	 */
	@Before(TaskInterceptor.class)
	public void count(){
		String t_id=getPara("id");
		try {
			GradeManage.dao.pingfen(t_id);
			Db.update("update task set count = 1 where id = ?", t_id);
			String path=getRequest().getSession().getServletContext().getRealPath("/excel/"+t_id+".xls");
			//导出excel
			ExcelManager.exportAll(t_id, path);
			renderJson(true);
		} catch (Exception e) {
			e.printStackTrace();
			renderJson(false);
		}
	}
	public void yulan(){
		setAttr(tableName, getRecord());
		setAttr("yulan", "1");
		render("/admin/task_show.jsp");
	}
	
	/**
	 * 设置时间
	 */
	private Timestamp getTime(String time){	
		return TimeUtil.getTimestamp(time,"yyyy-MM-dd");
	}
	/**
	 * 设置时间
	 */
	private Timestamp getTimeEnd(String time){	
		time+=" 23:59:59";
		return TimeUtil.getTimestamp(time,"yyyy-MM-dd HH:mm:ss");
	}
	public void index() {
		setAttr("task", Db.find("select * from task order by create_time desc"));
		setAttr("size", Db.find("select * from task ").size());
		setAttr("type", getPara("type"));
		setAttr("id", getPara("id"));
		render("/admin/task_list.jsp");
	}
}
