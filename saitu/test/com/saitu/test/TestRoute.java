package com.saitu.test;

import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.junit.Test;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;

import com.saitu.dao.RecordDao;
import com.saitu.dao.RouteDao;
import com.saitu.dao.impl.RecordDaoImpl;
import com.saitu.dao.impl.RouteDaoImpl;
import com.saitu.model.Record;
import com.saitu.model.Route;
import com.saitu.util.GetNewDate;

public class TestRoute {
	static ClassPathXmlApplicationContext c = new ClassPathXmlApplicationContext(
			"beans.xml");
	static HibernateTemplate h = (HibernateTemplate) c
			.getBean("hibernateTemplate");
	static RecordDao rd = (RecordDaoImpl) c.getBean("recordDao");
	static RouteDao ro = (RouteDaoImpl) c.getBean("routeDao");

	public static void main(String[] args) {
		System.out.println(GetNewDate.getYMD(new Date()));
		h.execute(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				Query query;
				query = session
						.createQuery("from Route r where r.overDate <= ?");
				query.setParameter(0, new Date());
				List<Route> l = query.list();
				return null;
			}
		});

	}

	// 测试自动更新到期绕道的路线
	@Test
	public void testUpdateRecord() {
		h.execute(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				Query query;
				query = session
						.createQuery("from Route r where r.overDate <= ?");
				query.setParameter(0, GetNewDate.getYMD(new Date()));
				List<Route> l = query.list();
				return null;
			}
		});
	}

	// 测试最近一次记录
	@Test
	public void testNewRecord() {
		RecordDao r = (RecordDaoImpl) c.getBean("recordDao");
		Record e;
		r.getNewReoced(2);
	}

	@Test
	public void testListName() {
		RouteDao r = (RouteDaoImpl) c.getBean("recordDao");
		r.getByState(0, "正常");
	}
}
