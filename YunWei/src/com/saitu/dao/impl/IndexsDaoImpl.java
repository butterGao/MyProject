package com.saitu.dao.impl;

import java.sql.SQLException;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Component;
import com.saitu.dao.IndexsDao;
import com.saitu.model.Indexs;
import com.sun.istack.internal.FinalArrayList;
@Component("indexsDao")
public class IndexsDaoImpl extends BaseDaoImpl<Indexs> implements IndexsDao{
	@Override
	public Indexs getEid(final Integer id) {
		return (Indexs) hibernateTemplate.execute(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				Query query = session.createQuery("from Indexs i where i.entry.id = ?");// 执行查询
				setQueryParams(query, new Object[]{id});
				return query.uniqueResult();
			}
		});
	}

	@Override
	public void setOrder(final Integer cid) {
		try {
			hibernateTemplate.execute(new HibernateCallback() {
				@Override
				public Object doInHibernate(Session session)
						throws HibernateException, SQLException {
					System.out.println(cid);
					Query query = session.createQuery("UPDATE Indexs  set orders = 0 where cid=?");// 执行查询
					setQueryParams(query, new Object[]{cid});
					return query.executeUpdate();
				}
			});
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
}
