package com.sitemap.listener;
import java.util.List;
import java.util.TimerTask;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import net.loyin.util.PropertiesContent;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.druid.DruidPlugin;
import com.sitemap.util.Tasks;
import com.test.Test2;
import com.test.test;
/**
 * 自动更新，自动发短信，自动提交到期任务的监听器
 */
public class AutoUpdateData implements ServletContextListener {
	// 所有民政局人员
	private String sqlUser = "select b.*,a.USER_LOGIN_NAME,a.USER_PASSWORD,c.organization_id,a.order_num from ims_ot_employee b "
			+ "inner join ims_ot_user a on(a.employee_id=b.id) "
			+ "inner join (select * from ims_rt_employee_organization a "
			+ "where a.organization_id in "
			+ "(select a.id from ims_ot_organization a,ims_rt_organization b where a.id=b.organization_id"
			+ " and b.super_organization_id ='b08865f0fe368c5cde4891c71c6255ee')) c on (b.id=c.employee_id)";
	// 所有上海市民政局处室
	private String sqlOrganization = "select a.id,a.organization_code,a.organization_name,a.organization_short_name,a.order_num "
			+ "from ims_ot_organization a,ims_rt_organization b "
			+ "where a.id=b.organization_id and b.super_organization_id ='b08865f0fe368c5cde4891c71c6255ee'";

	public void contextDestroyed(ServletContextEvent arg0) {
		System.out.println("Running  -------------- contextDestroyed(): " + "定时任务消除");
	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		try {
			// 定时任务
			Tasks.startDayForTime(new TimerTask() {
				public void run() {
					try {
						update();
					} catch (Exception e) {
					}
				};
			}, "23:59:59", 12);
			
			Tasks.startDayForTime(new TimerTask() {
				public void run() {
					try {
						commit();
					} catch (Exception e) {
					}
				};
			}, "00:00:01", 24);
		} catch (Exception e) {
			System.out.println("Running  : contextInitialized(): " + "定时任务开启失败!!!!");
			e.printStackTrace();
		}
	}
	
	
	/***
	 * 提交任务
	 */
	public void commit(){
		Db.update("update  mubiao set COMMIT =1 where t_id in (select id from task where mbend < NOW())");
		Db.update("update  zongjie set COMMIT =1 where t_id in (select id from task where zjend < NOW())");
	}
	
	
	/***
	 * 更新数据
	 */
	public void update() {
		DruidPlugin druidPlugin2 = new DruidPlugin(PropertiesContent.get("jdbc.url2"),
				PropertiesContent.get("jdbc.username2"), PropertiesContent.get("jdbc.password2"),
				PropertiesContent.get("jdbc.driver2"));
		try {
			druidPlugin2.start();// 启动副数据源
			List<Record> users = null;
			List<Record> organization = null;
			// 查询数据
			users = Db.find(druidPlugin2.getDataSource(), sqlUser);
			organization = Db.find(druidPlugin2.getDataSource(), sqlOrganization);
			// 判断取到的数据不为空（不能太少）
			if (users.size() > 100 && organization.size() > 50) {
				// 清空表
				Db.update("truncate table organization_");
				// 插入数据
				for (Record r : organization) {
					if(r.getStr("ORGANIZATION_SHORT_NAME").indexOf("（")>1){
						r.set("ORGANIZATION_SHORT_NAME", r.getStr("ORGANIZATION_SHORT_NAME").substring(0, r.getStr("ORGANIZATION_SHORT_NAME").indexOf("（")));
					}
					Db.save("organization_",
							new Record().set("id", r.getStr("id")).set("code", r.getStr("ORGANIZATION_CODE"))
									.set("order_num", r.getBigDecimal("ORDER_NUM"))
									.set("name", r.getStr("ORGANIZATION_NAME"))
									.set("short_name",r.getStr("ORGANIZATION_SHORT_NAME")));
				}
				Db.deleteById("organization_","96d9764e1ea5c09b8e48cd22bda0cffb");//删除督查室
				Db.deleteById("organization_","9006527faf346254d4756cad3565cba9");//删除团委
				Db.update("delete from sx_o where id=?","96d9764e1ea5c09b8e48cd22bda0cffb");
				Db.update("delete from sx_o where id=?","9006527faf346254d4756cad3565cba9");
				// 清空表
				Db.update("truncate table users_");
				// 插入数据 
				for (Record r : users) {
					if(r.getStr("ORGANIZATION_ID").equals("96d9764e1ea5c09b8e48cd22bda0cffb")){
						r.set("ORGANIZATION_ID", "9e861cd6b0cf93d357b63f5c496d14d4");
					}
					if(r.getStr("ORGANIZATION_ID").equals("9006527faf346254d4756cad3565cba9")){
						r.set("ORGANIZATION_ID", "4a649910e6c579b1ef2a95417d8262a2");
					}
					Db.save("users_",
							new Record().set("id", r.getStr("id")).set("number", r.getStr("EMPLOYEE_NUMBER")).set("order_num", r.get("order_num"))
									.set("user_name", r.getStr("REAL_NAME")).set("login_name", r.getStr("USER_LOGIN_NAME"))
									.set("password", r.getStr("USER_PASSWORD")).set("organization_id", r.getStr("ORGANIZATION_ID")));
			}
			}
			//根据设置添加人员信息
			Db.update("truncate table users");
			Db.update("truncate table organization");
			//<----
//			Db.save("users_", new Record().set("id", "11").set("organization_id", "1009245e7188ebff77433043610f65eb").set("login_name", "11").set("user_name", "普通处室处长").set("password", "MTE="));
//			Db.save("users", new Record().set("id", "22").set("organization_id", "639668bb1c23f38447f92e79e9ade0af").set("login_name", "22").set("user_name", "人事处普通人员").set("password", "MTE="));
//			Db.save("users_", new Record().set("id", "33").set("organization_id", "c504c59b8a9fd8c1129dc62cdb51ef41").set("login_name", "33").set("user_name", "测试上级领导").set("password", "MTE="));
			//--->
			Db.update("insert into organization(id,short_name,lead,code,name,order_num)  select a.id,a.short_name,b.lead,a.code,a.name,a.order_num from sx_o b LEFT JOIN organization_ a ON (a.id=b.id)");//更新处室
			Db.update("insert into users(id,number,user_name,login_name,password,organization_id) select id,number,user_name,login_name,password,organization_id from users_  where id in(select u_id from sx_u)");//更新用户
			//<---
//			Db.update("update organization set lead = 11 where id='1009245e7188ebff77433043610f65eb'");
			//---->
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Running =====> AutoUpdateData.update()  : " + "更新失败");
			
		} finally {
			druidPlugin2.stop();
		}
	}
}
