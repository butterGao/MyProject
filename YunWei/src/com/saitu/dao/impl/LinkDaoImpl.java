package com.saitu.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Component;

import com.saitu.dao.LinkDao;
import com.saitu.model.Link;
@Component("linkDao")
public class LinkDaoImpl extends BaseDaoImpl<Link> implements LinkDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<Link> getLinks() {
		return (List<Link>)hibernateTemplate.execute(new HibernateCallback() {
			
			@Override
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Query q=session.createQuery("from Link l order by l.sunxu");
				return q.list();
			} 
		});
	}

	@Override
	public void swop(final int id,final int order) {
			hibernateTemplate.execute(new HibernateCallback() {
				
				@Override
				public Object doInHibernate(Session session) throws HibernateException,
						SQLException {
					Query q=session.createQuery("update Link l set l.sunxu = ? where l.id=? ");
					setQueryParams(q,new Object[]{order,id});
					q.executeUpdate();
					return null;
				}
			});
	}
}
