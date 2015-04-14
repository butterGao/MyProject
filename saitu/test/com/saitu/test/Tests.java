package com.saitu.test;

import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.cfg.AnnotationConfiguration;
import org.hibernate.cfg.Configuration;
import org.hibernate.tool.hbm2ddl.SchemaExport;
import org.junit.Test;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import com.saitu.dao.RecordDao;
import com.saitu.dao.impl.RecordDaoImpl;
import com.saitu.model.Record;
import com.saitu.model.Route;
import com.saitu.util.GetNewDate;

public class Tests {
	static ClassPathXmlApplicationContext c = new ClassPathXmlApplicationContext("beans.xml"); 
	static HibernateTemplate h=(HibernateTemplate)c.getBean("hibernateTemplate");
	static RecordDao rd=(RecordDaoImpl)c.getBean("recordDao");
	@Test   
	public void create() {
		new SchemaExport(new AnnotationConfiguration().configure("beans.xml")).create(true, true);
	} 
	@Test
	public void updateTody(){
		h.execute(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				Query query;
				query = session 
						.createQuery("from route r where r.overDate >= ?");
				query.setParameter(0, GetNewDate.getYMD(new Date()));
				List<Route> l = query.list();
				List<Record> e = null;
				for (Route r : l) {
					e = rd.getByID(0, r.getId()).getList();
					for (Record c : e) {
						c.setB(0);
					}
				}
				return null;
			}
		});
	}
	
	@Test
	public void testDao(){
		RecordDao a=(RecordDao)c.getBean("recordDao");
		Record r=new Record();
		r.setTitle("aaa");
		System.out.println("s");
		a.save(r);
	}
	@Test
	public void testHql(){
		h.execute(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String hql=new StringBuffer()
				.append("from Record r where r.id=1 order by r.publishDate")
				.toString();
				Query query = session.createQuery(hql);
				List l=query.list();
				return null;
			}
		});
	}
	@Test
	public void testCount(){
		h.execute(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String hql=new StringBuffer()
				.append("select count (*) from Record r where r.b =1 order by r.publishDate")
				.toString();
				Query query = session.createQuery(hql);
				List l=query.list();
				return null;
			}
		});
		
	}
	@Test
public void tests(){
	List l = rd.getList("select r from Record r inner join r.routes o  where o.id = ? order by r.changeDate desc",
			new Object[] { 1 });
	Record record=null;
	for(int i=0;i<l.size();i++){
		record=(Record) l.get(i);
		System.out.println(record.getId());
	}

}
	public static void main(String[] args)  {
		
}
}