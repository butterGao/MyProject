package com.saitu.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Component;

import com.saitu.dao.CpolicyDao;
import com.saitu.model.Category;
import com.saitu.model.Cpolicy;

@Component("cpolicyDao")
public class CpolicyDaoImpl extends BaseDaoImpl<Cpolicy> implements CpolicyDao{
	public void swop(final int id,final int order) {
		hibernateTemplate.execute(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Query q=session.createQuery("update Cpolicy c set c.sunxu = ? where c.id=? ");
				setQueryParams(q,new Object[]{order,id});
				q.executeUpdate();
				return null;
			}
		});
}
	
@SuppressWarnings("unchecked")
@Override
public List<Category> getlists() {
	 return (List<Category>)hibernateTemplate.execute(new HibernateCallback() {
		
		@Override
		public Object doInHibernate(Session session) throws HibernateException,
				SQLException {
			Query q=session.createQuery("from Cpolicy c order by c.sunxu");
			return q.list();
		} 
	});
}
}
