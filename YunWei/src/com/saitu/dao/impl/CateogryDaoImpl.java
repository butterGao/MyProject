package com.saitu.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Component;

import com.saitu.dao.CategoryDao;
import com.saitu.model.Category;
import com.saitu.model.Link;

@Component("categoryDao")
public class CateogryDaoImpl extends BaseDaoImpl<Category> implements CategoryDao{
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
	@SuppressWarnings("unchecked")
	@Override
	public List<Category> getlists() {
		 return (List<Category>)hibernateTemplate.execute(new HibernateCallback() {
			
			@Override
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Query q=session.createQuery("from Cateogry l order by l.order");
				return q.list();
			} 
		});
	}
}
