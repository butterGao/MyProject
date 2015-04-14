package com.test;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import com.jfinal.plugin.activerecord.Db;
import com.sitemap.manager.ExcelManager;
import com.sitemap.manager.GradeManage;


public class test3 {

	public static void main(String[] args) {
		Test2 aTest3=new Test2();
//	GradeManage.dao.pingfen("20141208110841005308cb");
	ExcelManager.exportAll("20141208110841005308cb", "c:/aa.xls");
		//String a=Db.queryStr("select content from task where id = '20141208110841005308cb'");
		//a.replaceAll("tbody", "a");
		//System.out.println(a);
	}
	
}
