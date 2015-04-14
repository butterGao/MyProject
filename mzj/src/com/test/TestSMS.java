package com.test;
import java.util.List;
import javax.swing.text.DefaultEditorKit.InsertBreakAction;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.sitemap.manager.GradeManage;
import com.sitemap.system.pingfen;
import com.sitemap.util.TimeUtil;

public class TestSMS {
	public static void main(String[] args) {
		Test2 test2 = new Test2();
		//Db.update("update organization set lead = 11 where id='1009245e7188ebff77433043610f65eb'");
		//Db.save("users_", new Record().set("id", "11").set("organization_id", "1009245e7188ebff77433043610f65eb").set("login_name", "11").set("user_name", "普通处室处长").set("password", "MTE="));
//		Db.save("users", new Record().set("id", "22").set("organization_id", "639668bb1c23f38447f92e79e9ade0af").set("login_name", "22").set("user_name", "人事处普通人员").set("password", "MTE="));
//		Db.save("users_", new Record().set("id", "33").set("organization_id", "c504c59b8a9fd8c1129dc62cdb51ef41").set("login_name", "33").set("user_name", "测试上级领导").set("password", "MTE="));
		//System.out.println(Db.queryStr("select score from grade"));
		System.out.println("aaaas".indexOf("b"));
	}
}
