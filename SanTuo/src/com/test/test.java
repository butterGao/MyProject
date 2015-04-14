package com.test;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import net.loyin.jFinal.plugin.AutoTableBindPlugin;
import net.loyin.jFinal.plugin.TableNameStyle;
import net.loyin.util.PropertiesContent;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.activerecord.CaseInsensitiveContainerFactory;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.dialect.OracleDialect;
import com.jfinal.plugin.druid.DruidPlugin;
import com.sitemap.util.TimeUtil;

public class test {
	public test() {
		DruidPlugin druidPlugin = new DruidPlugin(PropertiesContent.get("jdbc.url"),
				PropertiesContent.get("jdbc.username"), PropertiesContent.get("jdbc.password"),
				PropertiesContent.get("jdbc.driver"));
		druidPlugin.start();
		ActiveRecordPlugin arp = new ActiveRecordPlugin(druidPlugin);
		arp.setDialect(new OracleDialect());
		AutoTableBindPlugin autoTableBindPlugin = new AutoTableBindPlugin(druidPlugin, TableNameStyle.LOWER);
		autoTableBindPlugin.setShowSql(true);
		autoTableBindPlugin.setContainerFactory(new CaseInsensitiveContainerFactory());
		autoTableBindPlugin.start();
		arp.start();
	
	}
		
		public static void main(String[] args)  {
			test t = new test();
			//Db.find("select peopledou,rtype from st_report where peopledou like ',_2' escape ',' and status = 1 ");
		}
}