package com.sitemap.controller;

import java.util.ArrayList;
import java.util.List;
import org.apache.commons.lang.StringUtils;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.sitemap.listener.AutoUpdateData;
import com.sitemap.manager.GradeManage;
import com.sitemap.model.Organization;
import com.sitemap.model.Users;
import com.sitemap.system.Constant;
import com.sitemap.system.Power;
import com.sitemap.system.pingfen;
import com.sitemap.util.Result;
import com.test.Test2;


/**
 * 公用的控制
 * 一般调用常用ajax
 * CommonController
 */
public class CommonController extends BaseController {
	public void index() {
//		String webseal_ip = getRequest().getRemoteAddr();
//		List<String> ip=new ArrayList<String>();
//		ip.add("130.2.2.5");
//		ip.add("130.2.2.18");
//		ip.add("130.1.33.67");
//		ip.add("127.0.0.1");
//		System.out.println(webseal_ip);
//		if(ip.contains(webseal_ip)){
//			System.out.println("单点登录IP验证正确:"+webseal_ip);
			dandian();
//		}
		
		redirect(getRequest().getServletContext().getContextPath()+"/users/index");
	}
	/**
	 * */
	private void dandian(){
		String name = getRequest().getHeader("iv-user");
		System.out.println("单点获取用户名"+name);
		if(StringUtils.isNotEmpty(name)&&Users.dao.isExistName(name)){
			Users users = null;
			Organization org = null;
			users = Users.dao.checkoutPass(name);
			if (users != null) {
				org = Organization.dao.findById(users.get(Users.organizationId));
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
			}
		}
	}
	
	
	
	/**
	 * 查询处室人员
	 */
	public void person(){
		renderJson(Users.dao.queryForOrganization(getPara("id")));
	}
	
	

	
	/**
	 * 根据ID查任务
	 */
	public void taskid(){
		renderJson(Db.findFirst("select * from task where id = ?",getPara("id")));
	}
	
	/**
	 * 判断领导是否存在
	 */
	public void exitsLead(){
		if(Db.queryLong("select count(1) from organization where lead = ? and lead in(select id from users)", "33")>0){
			renderJson(true);
		}else{
			renderJson(false);
		}
	}
	
	
	/**
	 * 判断选择处室是否在指标中
	 */
	public void exitsTarget(){
		List<pingfen> ps = GradeManage.dao.getPingfens(Db.queryStr("select weighter from target where id = ?",getPara("target")));
		ps.remove(0);
		ps.remove(0);
		ps.remove(0);
		String [] orgs=getPara("orgs_id").split(",");
		List<String> ts=new ArrayList<String>();
		List<String> os=new ArrayList<String>();
		for(String o:orgs){
			os.add(o);
		}
		for(pingfen p:ps){
			if(p.getType()>0&&!p.getId().equals(Constant.TopLead)){
				ts.add(p.getId());
			}
		}
		renderJson(os.containsAll(ts));
	}
	
	//更新数据
	public void updateDate(){
		try {
			AutoUpdateData data=new AutoUpdateData();
			data.update();
			renderJson(true);
		} catch (Exception e) {
			renderJson(false);
			e.printStackTrace();
		}
	}
	/**
	 * 得到处室得分详情
	 */
	public void getScoreForOrg(){
		renderJson(GradeManage.dao.getScores(getPara("o_id"),getPara("t_id")));
	}
	
	
}
