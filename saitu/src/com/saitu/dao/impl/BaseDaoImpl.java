package com.saitu.dao.impl;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.saitu.dao.BaseDao;
import com.saitu.util.PageModel;

public class BaseDaoImpl<T> implements BaseDao<T> {
	private Class<T> clazz;
	// hibernate模板
	private HibernateTemplate hibernateTemplate;

	// 初始化泛型对象
	public BaseDaoImpl() {
		clazz = (Class<T>) ((ParameterizedType) getClass()
				.getGenericSuperclass()).getActualTypeArguments()[0];
	}

	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	@Resource
	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}

	/**
	 * 利用save方法保存对象的详细信息
	 */
	@Override
	public void save(T t) {
		hibernateTemplate.save(t);
	}

	@Override
	public void saveOrUpdate(T t) {
		hibernateTemplate.saveOrUpdate(t);
	}

	/**
	 * 利用update()方法修改对象的详细信息
	 */
	@Override
	public void update(T t) {
		hibernateTemplate.update(t);
	}

	@Override
	public void delete(Serializable... ids) {
		for (Serializable id : ids) {
			hibernateTemplate.delete(hibernateTemplate.load(this.clazz, id));
		}

	}

	@Override
	public T get(Serializable entityId) {
		return (T) hibernateTemplate.get(clazz, entityId);
	}

	@Override
	public T load(Serializable entityId) {
		return (T) hibernateTemplate.load(clazz, entityId);
	}

	/**
	 * 利用hql查找单条信息
	 */
	@Override
	public Object uniqueResult(final String hql, final Object[] queryParams) {

		return hibernateTemplate.execute(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				Query query = session.createQuery(hql);
				if (queryParams != null) {
					for (int i = 0; i < queryParams.length; i++) {
						query.setParameter(i, queryParams);
					}
				}
				return query.uniqueResult();
			}
		});
	}

	@Override
	public long getCount(String where, Object[] parmams) {

		return (Long) uniqueResult(where, null);
	}

	/**
	 * 分页查询方法
	 * 
	 * @param pageNo
	 *            页数
	 * @param maxResult
	 *            一页最大显示数
	 * @param hql
	 *            查询语句
	 * @param queryParams
	 *            查询参数
	 * @param totalRecords
	 *            总记录数
	 * @return 分页模型
	 */
	public PageModel getPageModel(final int pageNo, final String where,
			final Object[] queryParams) {
		int totalRecords = 0;
		final int mr = PageModel.MaxResult;
		final PageModel p = new PageModel(pageNo, mr, totalRecords);
		p.setPageNumber(pageNo);
		p.setPageSize(mr);
		getHibernateTemplate().execute(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				String hql = new StringBuffer().append("from ")
						.append(clazz.getSimpleName()).append(" ")
						.append(where == null ? "" : where).toString();
				Query query = session.createQuery(hql);
				if (queryParams != null && queryParams.length > 0) {
					for (int i = 0; i < queryParams.length; i++) {
						query.setParameter(i, queryParams[i]);
					}
				}
				p.setList(query.setFirstResult((pageNo - 1) * mr)
						.setMaxResults(mr).list());
				hql = new StringBuffer().append("select count(*) from ")
						.append(clazz.getSimpleName()).append(" ")
						.append(where == null ? "" : where).toString();
				query = session.createQuery(hql);
				if (queryParams != null && queryParams.length > 0) {
					for (int i = 0; i < queryParams.length; i++) {
						query.setParameter(i, queryParams[i]);
					}
				}
				p.setTotalRecords(((Long) query.uniqueResult()).intValue());// 储存最大记录
				return null;
			}
		});
		return p;
	}

	public PageModel getPageModels(final int pageNo, final String where,
			final String count, final Object[] queryParams) {
		int totalRecords = 0;
		final int mr = PageModel.MaxResult;
		final PageModel p = new PageModel(pageNo, mr, totalRecords);
		p.setPageNumber(pageNo);
		p.setPageSize(mr);
		getHibernateTemplate().execute(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				Query query = session.createQuery(where);
				if (queryParams != null && queryParams.length > 0) {
					for (int i = 0; i < queryParams.length; i++) {
						query.setParameter(i, queryParams[i]);
					}
				}
				p.setList(query.setFirstResult((pageNo - 1) * mr)
						.setMaxResults(mr).list());
				query = session.createQuery(count);
				if (queryParams != null && queryParams.length > 0) {
					for (int i = 0; i < queryParams.length; i++) {
						query.setParameter(i, queryParams[i]);
					}
				}
				p.setTotalRecords(((Long) query.uniqueResult()).intValue());// 储存最大记录
				return null;
			}
		});
		return p;
	}

	public List<?> getList(final String where, final Object[] queryParams) {

		return (List<?>) getHibernateTemplate().execute(
				new HibernateCallback() {

					@Override
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						Query query = session.createQuery(where);
						if (queryParams != null && queryParams.length > 0) {
							for (int i = 0; i < queryParams.length; i++) {
								query.setParameter(i, queryParams[i]);
							}
						}
						return query.list();
					}
				});
	}

}
