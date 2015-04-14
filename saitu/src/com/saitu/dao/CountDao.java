package com.saitu.dao;

import java.sql.SQLException;
import java.util.Date;

import javax.annotation.Resource;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Component;
@Component
public class CountDao {
	private HibernateTemplate hibernateTemplate;
	public int getRcount(final Date d1,final Date d2){
		return  (Integer) hibernateTemplate.execute(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Query q=session.createQuery(
						"select count(*) from Route r  join  r.records o where "
						+ "o.updateDate between ? and ?" ); 
				q.setParameter(0, d1);
				q.setParameter(1, d2);
				if(q.uniqueResult()==null){
					return 0; 
				}
				return ((Long)q.uniqueResult()).intValue();
			}
		});
	}
	
	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	@Resource
	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	} 
}
