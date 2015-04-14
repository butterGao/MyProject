package com.sitemap.controller;
import java.util.List;
import net.loyin.util.PropertiesContent;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.sitemap.manager.GradeManage;
import com.sitemap.model.Organization;
import com.sitemap.model.Task;
import com.sitemap.model.Users;
import com.sitemap.system.Constant;
import com.sitemap.system.Power;
import com.sitemap.system.pingfen;
import com.sitemap.util.BASE64;
import com.sitemap.util.Result;
import com.sitemap.util.TimeUtil;
/**
 * 用户模块
 */
public class UsersController extends BaseController {
	public UsersController() {
		this.tableName = "users";
	}

	/**
	 * 登出
	 */
	public void logout() {
		setSessionAttr("users", null);
		setSessionAttr("org", null);
		setSessionAttr("power", null);
		redirect(getRequest().getServletContext().getContextPath());
	}
	/**
	 * 登陆后判断权限
	 */
	public void login() {
		String name = getPara("login_name");
		if(name.equals("admin")){//超级管理远账号
			if(getPara("password").equals(PropertiesContent.get("admin.pass"))){
				Users users=new Users();
				users.set("user_name", "超级管理员");
				Power power = new Power();
				power.setTask(true);
				power.setQueryScore(true);
				setSessionAttr("users", users);
				setSessionAttr("power", power);
				renderJson(new Result(true));
			}else{
				renderJson(new Result(2, "用户密码不正确"));
			}
		}
		else if (Users.dao.isExistName(name)) {// 是否存在用户名
			Users users = null;
			Organization org = null;
			try {
				String a = BASE64.encryptBASE64(getPara("password").getBytes()).trim();// 密码加密
				System.out.println("密码：" + a + ";");
				users = Users.dao.checkoutPass(name, a);
				org = Organization.dao.findById(users.get(Users.organizationId));
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (users != null) {
				removeSessionAttr("users");
				setSessionAttr("users", users);
				setSessionAttr("org", org);
				Power power = new Power();
				power.setKaohe(true);
				try {
					// 判断是否为处室领导
					if (users.getStr("id").equals(org.getStr("lead"))) {
						power.setZongjie(true);
						power.setMubiao(true);
						power.setType(0);
					} else {
						power.setType(1);
					}
				} catch (Exception e) {
					power.setType(1);
				}
				// 判断是否为上级领导
				if (org.get("id").equals(Constant.TopLead)){
					power.setType(0);
					System.out.println("上级领导登录");
				}
				// 判断是否人事处
				/*if (org.get("id").equals(Constant.Personnel)) {
					power.setTask(true);
					power.setQueryScore(true);
				}*/
				setSessionAttr("power", power);
				renderJson(new Result(true));
			} else {// 用户名密码不正确
				renderJson(new Result(2, "用户密码不正确"));
			}
		} else {// 用户不存在
			renderJson(new Result(1, "用户不存在"));
		}
	}
	/**
	 * 登陆后判断要处理的任务
	 */
	public void index() {
		setAttr("newTask", Db.find("SELECT * FROM task where commit = 1 ORDER BY create_time desc LIMIT 0,5"));
		if (getSessionAttr("users") != null && getSessionAttr("power") != null) {
			Organization org = getSessionAttr("org");
			Users users = getSessionAttr("users");
			Power power = getSessionAttr("power");
			if (power.isZongjie()) {
				long zjcount = Task.dao.queryCountForWhere("and commit =1 and count = 0 and ? between zjStart and zjEnd",
						org.getStr("id"), TimeUtil.getNewDate());
				// 总结完成数
				long zj = Db
						.queryLong(
								"select count(1) from zongjie where o_id= ? and t_id in(select t_id from task_organization where o_id =?) and t_id not in(select id from task where count =1) and commit=1",
								org.getStr("id"), org.getStr("id"));
				setAttr("zjSize", zjcount - zj);
			}
			//--------------------目标
			if (power.isMubiao()) {
				long mbcount = Task.dao.queryCountForWhere("and commit =1 and count = 0 and ? between mbStart and mbEnd",
						org.getStr("id"), TimeUtil.getNewDate());
				// 目标完成数
				long mb = Db
						.queryLong(
								"select count(1) from mubiao where o_id= ? and t_id in(select t_id from task_organization where o_id =?) and t_id not in(select id from task where count =1) and commit=1",
								org.getStr("id"), org.getStr("id"));
				setAttr("mbSize", mbcount - mb);
			}
			//--------------------考核
			if (power.isKaohe()) {
				int khSize=0;
				
				if(power.getType()==0){//如果是领导
					List<Record> task = Db
							.find("select a.id,b.weighter from task a left JOIN target b on (a.target_id = b.id) where a.commit =1 and a.count = 0 and ? between khStart and khEnd",
									TimeUtil.getNewDate());
					for (Record t : task) {
						List<pingfen> ps=GradeManage.dao.getPfList(t);
						for(pingfen p:ps){
							if(p.getId().equals(org.getStr("id"))){//判断有没有参与任务
								if(Db.queryLong("select count(1) from grade where t_id = ? and u_id = ?  and commit=1 ",t.getStr("id"),getUserId())==0)khSize++;//参与评测没有评分
								break;
							}
							if(p.getId().equals(users.getStr("id"))){//判断有没有参与任务
								if(Db.queryLong("select count(1) from grade where t_id = ? and u_id = ?  and commit=1 ",t.getStr("id"),getUserId())==0)khSize++;//参与评测没有评分
								break;
							}
						}
					}
				}else{
					List<Record> task = Task.dao.queryTaskForWhere("and commit =1 and count = 0 and ? between khStart and khEnd", getOrgId(),TimeUtil.getNewDate());
					for(Record t:task){
						if(Db.queryLong("select count(1) from grade where t_id = ? and u_id = ? and o_id=? and commit=1 ",t.getStr("id"),getUserId(),getOrgId())==0)khSize++;//参与任务没有自评
					}
				}
				setAttr("khSize",khSize);
			}
		}
		render("/index.jsp");
	}

	public void show() {
	}
}
