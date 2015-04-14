
package com.test;
import java.sql.Connection;
import java.util.List;
import net.loyin.jFinal.plugin.AutoTableBindPlugin;
import net.loyin.jFinal.plugin.TableNameStyle;
import net.loyin.util.PropertiesContent;
import com.alibaba.fastjson.JSON;
import com.jfinal.kit.JsonKit;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.activerecord.CaseInsensitiveContainerFactory;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.DbKit;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.druid.DruidPlugin;

public class test {
	private static String sqlUser = "select b.*,a.USER_LOGIN_NAME,a.USER_PASSWORD,c.organization_id,a.order_num from ims_ot_employee b "
			+ "inner join ims_ot_user a on(a.employee_id=b.id) "
			+ "inner join (select * from ims_rt_employee_organization a "
			+ "where a.organization_id in "
			+ "(select a.id from ims_ot_organization a,ims_rt_organization b where a.id=b.organization_id"
			+ " and b.super_organization_id ='b08865f0fe368c5cde4891c71c6255ee')) c on (b.id=c.employee_id)";
	// 所有上海市民政局处室
	private static String sqlOrganization = "select a.id,a.organization_code,a.organization_name,a.organization_short_name,a.order_num "
			+ "from ims_ot_organization a,ims_rt_organization b "
			+ "where a.id=b.organization_id and b.super_organization_id ='b08865f0fe368c5cde4891c71c6255ee'";

	public test() {
		DruidPlugin druidPlugin = new DruidPlugin(PropertiesContent.get("jdbc.url"),
				PropertiesContent.get("jdbc.username"), PropertiesContent.get("jdbc.password"),
				PropertiesContent.get("jdbc.driver"));
		druidPlugin.start();
		ActiveRecordPlugin arp = new ActiveRecordPlugin(druidPlugin);
		arp.start();
		AutoTableBindPlugin autoTableBindPlugin = new AutoTableBindPlugin(druidPlugin, TableNameStyle.LOWER);
		autoTableBindPlugin.setShowSql(true);
		autoTableBindPlugin.setContainerFactory(new CaseInsensitiveContainerFactory());
		autoTableBindPlugin.start();
	}

	public static void main(String[] args) {
		test t = new test();
		long starttime = System.currentTimeMillis();
		DruidPlugin druidPlugin2 = new DruidPlugin(PropertiesContent.get("jdbc.url2"),
				PropertiesContent.get("jdbc.username2"), PropertiesContent.get("jdbc.password2"),
				PropertiesContent.get("jdbc.driver2"));
		try {
			druidPlugin2.start();// 启动副数据源
			List<Record> users = null;
			List<Record> organization = null;
			// 查询数据
			organization = Db.find(druidPlugin2.getDataSource(), sqlOrganization);
			users = Db.find(druidPlugin2.getDataSource(), sqlUser);
			// 判断取到的数据不为空（不能太少）
			if (users.size() > 100 && organization.size() > 50) {
				// 清空表
				Db.update("truncate table users");
				Db.update("truncate table organization");
				// 插入数据
				for (Record r : organization) {
					Db.save("organization",
							new Record().set("id", r.getStr("id")).set("code", r.getStr("ORGANIZATION_CODE"))
									.set("order_num", r.getBigDecimal("ORDER_NUM"))
									.set("name", r.getStr("ORGANIZATION_NAME"))
									.set("short_name", r.getStr("ORGANIZATION_SHORT_NAME")));
				}
				
				// 插入数据
				for (Record r : users) {
					System.out.println(JSON.toJSONString(r));
					Record record=new Record().set("id", r.getStr("id")).set("number", r.getStr("EMPLOYEE_NUMBER"))
					.set("user_name", r.getStr("REAL_NAME")).set("login_name", r.getStr("USER_LOGIN_NAME"))
					.set("password", r.getStr("USER_PASSWORD")).set("organization_id", r.getStr("ORGANIZATION_ID"))
					.set("order_num", r.getBigDecimal("order_num"));
					Db.save("users",record);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Running =====> AutoUpdateData.update()  : " + "更新失败");
		} finally {
			druidPlugin2.stop();
		}
	}
}