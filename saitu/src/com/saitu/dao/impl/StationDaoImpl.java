package com.saitu.dao.impl;

import java.io.Serializable;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Component;

import com.saitu.dao.StationDao;
import com.saitu.model.Station;
import com.saitu.util.PageModel;
@Component("stationDao")
public class StationDaoImpl extends BaseDaoImpl<Station> implements StationDao  {
	@Override
	public int count(final Date d1, final Date d2) {
		return 	(Integer) getHibernateTemplate().execute(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Query q=session.createQuery("select sum(s.count) from Station s where s.datetime between ? and ?");
				q.setParameter(0, d1);
				q.setParameter(1, d2);
				System.out.println(25);
				if(q.uniqueResult()==null)
					return 0;
				return ((Long)q.uniqueResult()).intValue();
			}
		});
	}
	
}
