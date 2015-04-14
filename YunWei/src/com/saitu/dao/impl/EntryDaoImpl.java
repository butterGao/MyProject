package com.saitu.dao.impl;

import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.InExpression;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Component;

import com.saitu.dao.EntryDao;
import com.saitu.model.Entry;
import com.saitu.model.Indexs;
import com.saitu.util.HTMLtoString;
import com.sun.istack.internal.FinalArrayList;

@Component("entryDao")
public class EntryDaoImpl extends BaseDaoImpl<Entry> implements EntryDao {
	private String s;
	private Entry e;

	public Entry g() {
		return null;
	}

	// 得到过滤的文章
	@Override
	public Entry getNew(int id) {
		try {
			e = findList(
					"from Entry e where e.categoryid = ? order by creatTime desc",
					new Object[] { id }).get(0);
		} catch (Exception e) {
		}
		if (e != null) {
			s = HTMLtoString.HtmlToText(e.getContent());
			s = s.length() >= 98 ? s.substring(0, 98) : s.substring(0,
					s.length());
			e.setContent(s + "...");
		}
		return e;
	}

	public Entry getN(Entry e) {
		if (e != null) {
			s = HTMLtoString.HtmlToText(e.getContent());
			s = s.length() >= 98 ? s.substring(0, 98) : s.substring(0,
					s.length());
			e.setContent(s + "...");
		}
		return e;
	}
	@SuppressWarnings("unchecked")
	public List<Indexs> getIns(final int a){
		return (List<Indexs>) hibernateTemplate.execute(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				String hql="from Indexs i where i.cid = ?";
				Query query = session.createQuery(hql);
				setQueryParams(query, new Object[] {a});
				return query.list();
			}
		});
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<Entry> getEntries(final int a) {
		return (List<Entry>) hibernateTemplate.execute(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				// String
				// hql="select new Entry(id,title,creatTime,categoryid,path,types) from Entry e where e.categoryid > ? and e.categoryid < ? order by creatTime desc";
				String hql = "select e from Entry e   inner join  e.indexs i where i.cid = ? ORDER BY i.orders desc,e.creatTime desc";
				/*
				 * if(a>=30&&b<=40){ hql=
				 * "select new Entry(id,title,creatTime,categoryid,path,types) from Entry e where ( e.categoryid > ? and e.categoryid < ? ) or e.chenguo > 0 order by creatTime desc"
				 * ; }
				 */
				
				Query query = session.createQuery(hql);
				setQueryParams(query, new Object[]{a});
				return query.list();
			}
		});
	}
	/*
	 * @Override public List<Entry> getNs(List<Entry> s) { for (int i = 0; i
	 * <s.size(); i++) { String n=""; switch (s.get(i).getCategoryid()) { case
	 * 11:n=""; break; case 12:n=""; break; case 13:n=""; break; case 14:n="";
	 * break; case 11:n=""; break; case 11:n=""; break; case 11:n=""; break;
	 * case 11:n=""; break; case 11:n=""; break; case 11:n=""; break; case
	 * 11:n=""; break; case 11:n=""; break; case 11:n=""; break; case 11:n="";
	 * break; case 11:n=""; break;
	 * 
	 * } s.get(i).setTitle("["+"]"); }
	 * 
	 * return s; }
	 */

	@SuppressWarnings("unchecked")
	@Override
	public List<Entry> getByCategory(final int a,final int b,final int i,final int t) {
		return (List<Entry>) hibernateTemplate.execute(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				 String hql="select new Entry(id,title,creatTime,categoryid,path,types) from Entry e where e.categoryid > ? and e.categoryid < ? order by creatTime desc";
				 if(a>=30&&b<=40){ hql=
				"select new Entry(id,title,creatTime,categoryid,path,types) from Entry e where ( e.categoryid > ? and e.categoryid < ? ) or e.chenguo > 0 order by creatTime desc"
				 ; }
				Query query = session.createQuery(hql);
				setQueryParams(query, new Object[]{a,b});
				query.setMaxResults(t);
				query.setFirstResult(getFirstResult(i, t));
				return query.list();
			}
		});
	}
}
