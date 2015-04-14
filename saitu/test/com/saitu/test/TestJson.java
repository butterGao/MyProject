package com.saitu.test;

import java.sql.SQLException;
import java.util.List;





import net.sf.json.JSONArray;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;

import com.saitu.model.Record;

public class TestJson {
	static ClassPathXmlApplicationContext c = new ClassPathXmlApplicationContext("beans.xml"); 
	static HibernateTemplate h=(HibernateTemplate)c.getBean("hibernateTemplate");
		public static void main(String[] args) {
			List<Record> l=h.find("from Record r"); 
		System.out.println(JSONArray.fromObject(l).toString());
		}  
}
