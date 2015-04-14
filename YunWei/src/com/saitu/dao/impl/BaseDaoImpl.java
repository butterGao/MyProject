package com.saitu.dao.impl;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.SessionFactoryUtils;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.saitu.dao.BaseDao;
import com.saitu.util.PageModel;

/**
 * Dao支持类
 * 
 */
@Transactional
@SuppressWarnings("unchecked")
public class BaseDaoImpl<T> implements BaseDao<T> {
	// 泛型的类型
	protected Class<T> clzz = (Class<T>) ((ParameterizedType) getClass()
			.getGenericSuperclass()).getActualTypeArguments()[0];
	// Hibernate模板
	protected HibernateTemplate hibernateTemplate;

	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	@Resource
	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}

	@Override
	public void delete(Serializable... ids) {
		for (Serializable id : ids) {
			T t = (T) getHibernateTemplate().load(this.clzz, id);
			getHibernateTemplate().delete(t);
		}
	}

	/**
	 * 利用get()方法加载对象，获取对象的详细信息
	 */
	@Transactional(propagation = Propagation.NOT_SUPPORTED, readOnly = true)
	public T get(Serializable entityId) {
		return (T) getHibernateTemplate().get(this.clzz, entityId);
	}

	/**
	 * 利用load()方法加载对象，获取对象的详细信息
	 */
	@Transactional(propagation = Propagation.NOT_SUPPORTED, readOnly = true)
	public T load(Serializable entityId) {
		return (T) getHibernateTemplate().load(this.clzz, entityId);
	}

	/**
	 * 利用hql语句查找单条信息
	 */
	@Override
	@Transactional(propagation = Propagation.NOT_SUPPORTED, readOnly = true)
	public Object uniqueResult(final String hql, final Object[] queryParams) {
		return getHibernateTemplate().execute(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				Query query = session.createQuery(hql);// 执行查询
				setQueryParams(query, queryParams);// 设置查询参数
				return query.uniqueResult();
			}
		});
	}

	/**
	 * 获取指定对象的信息条数
	 */
	@Transactional(propagation = Propagation.NOT_SUPPORTED, readOnly = true)
	public long getCount() {
		String hql = "select count(*) from " + clzz.getSimpleName();
		return (Long) uniqueResult(hql, null);
	}

	/**
	 * 利用save()方法保存对象的详细信息
	 */
	@Override
	public void save(Object obj) {
		getHibernateTemplate().save(obj);
	}

	@Override
	public void saveOrUpdate(Object obj) {
		getHibernateTemplate().saveOrUpdate(obj);
	}

	/**
	 * 利用update()方法修改对象的详细信息
	 */
	@Override
	public void update(Object obj) {
		getHibernateTemplate().update(obj);
	}

	@Transactional(propagation = Propagation.NOT_SUPPORTED, readOnly = true)
	public PageModel find(final int pageNo) {
		return find(null, null, null, pageNo);
	}

	@Transactional(propagation = Propagation.NOT_SUPPORTED, readOnly = true)
	public PageModel find(int pageNo, Map<String, String> orderby) {
		return find(null, null, orderby, pageNo);
	}

	@Transactional(propagation = Propagation.NOT_SUPPORTED, readOnly = true)
	public PageModel find(int pageNo, String where, Object[] queryParams) {
		return find(where, queryParams, null, pageNo);
	}
	/**
	 * 分页查询
	 * 
	 * @param where
	 *            查询条件
	 * @param queryParams
	 *            hql参数值
	 * @param orderby
	 *            排序
	 * @param pageNo
	 *            第几页
	 * @param maxResult
	 *            返回记录数量 return PageModel
	 */
	@Transactional(propagation = Propagation.NOT_SUPPORTED, readOnly = true)
	public PageModel find(final String where, final Object[] queryParams,
			final Map<String, String> orderby, final int pageNo) {
		final PageModel pageModel = new PageModel();// 实例化分页对象
		pageModel.setPageNumber(pageNo);// 设置当前页数
		pageModel.setPageSize(PageModel.MaxResult);// 设置每页显示记录数
		getHibernateTemplate().execute(new HibernateCallback() {// 执行内部方法
					@Override
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						String hql = new StringBuffer().append("from ")// 添加form字段
								.append(clzz.getSimpleName())// 添加对象类型
								.append(" ")// 添加空格
								.append(where == null ? "" : where)// 如果where为null就添加空格,反之添加where
								.append(createOrderBy(orderby))// 添加排序条件参数
								.toString();// 转化为字符串
						Query query = session.createQuery(hql);// 执行查询
						setQueryParams(query, queryParams);// 为参数赋值
						List<T> list = null;// 定义List对象
						// 如果maxResult<0，则查询所有
						if (pageNo < 0) {
							list = query.list();// 将查询结果转化为List对象
						} else {
							list = query
									.setFirstResult(
											getFirstResult(pageNo,
													PageModel.MaxResult))// 设置分页起始位置
									.setMaxResults(PageModel.MaxResult)// 设置每页显示的记录数
									.list();// 将查询结果转化为List对象
							// 定义查询总记录数的hql语句
							hql = new StringBuffer()
									.append("select count(*) from ")// 添加hql语句
									.append(clzz.getSimpleName())// 添加对象类型
									.append(" ")// 添加空格
									.append(where == null ? "" : where)// 如果where为null就添加空格,反之添加where
									.toString();// 转化为字符串
							query = session.createQuery(hql);// 执行查询
							setQueryParams(query, queryParams);// 设置hql参数
							int totalRecords = ((Long) query.uniqueResult())
									.intValue();// 类型转换
							pageModel.setTotalRecords(totalRecords);// 设置总记录数
						}
						pageModel.setList(list);// 将查询的list对象放入实体对象中
						return null;
					}
				});
		return pageModel;// 返回分页的实体对象
	}

	@Transactional(propagation = Propagation.NOT_SUPPORTED, readOnly = true)
	public PageModel findAny(final String where, final Object[] queryParams,
			final Map<String, String> orderby, final int pageNo,final String zhiduan) {
		final PageModel pageModel = new PageModel();// 实例化分页对象
		pageModel.setPageNumber(pageNo);// 设置当前页数
		pageModel.setPageSize(PageModel.MaxResult);// 设置每页显示记录数
		getHibernateTemplate().execute(new HibernateCallback() {// 执行内部方法
					@Override
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						String hql = new StringBuffer().append("select new ")// 添加form字段
								.append(clzz.getSimpleName())// 添加对象类型
								.append("(")// 添加空格
								.append(zhiduan)
								.append(") ") 
								.append(" from ")
								.append(clzz.getSimpleName())
								.append(" ")
								.append(where == null ? "" : where)// 如果where为null就添加空格,反之添加where
								.append(createOrderBy(orderby))// 添加排序条件参数
								.toString();// 转化为字符串
						Query query = session.createQuery(hql);// 执行查询
						setQueryParams(query, queryParams);// 为参数赋值
						List<T> list = null;// 定义List对象
						// 如果maxResult<0，则查询所有
						if (pageNo < 0) {
							list = query.list();// 将查询结果转化为List对象
						} else {
							list = query
									.setFirstResult(
											getFirstResult(pageNo,
													PageModel.MaxResult))// 设置分页起始位置
									.setMaxResults(PageModel.MaxResult)// 设置每页显示的记录数
									.list();// 将查询结果转化为List对象
							// 定义查询总记录数的hql语句
							hql = new StringBuffer()
									.append("select count(*) from ")// 添加hql语句
									.append(clzz.getSimpleName())// 添加对象类型
									.append(" ")// 添加空格
									.append(where == null ? "" : where)// 如果where为null就添加空格,反之添加where
									.toString();// 转化为字符串
							query = session.createQuery(hql);// 执行查询
							setQueryParams(query, queryParams);// 设置hql参数
							int totalRecords = ((Long) query.uniqueResult())
									.intValue();// 类型转换
							pageModel.setTotalRecords(totalRecords);// 设置总记录数
						}
						pageModel.setList(list);// 将查询的list对象放入实体对象中
						return null;
					}
				});
		return pageModel;// 返回分页的实体对象
	}
	
	/**
	 * 获取分页查询中结果集的起始位置
	 * 
	 * @param pageNo
	 *            第几页
	 * @param maxResult
	 *            页面显示的记录数
	 * @return 起始位置
	 */
	protected int getFirstResult(int pageNo, int maxResult) {
		int firstResult = (pageNo - 1) * maxResult;
		return firstResult < 0 ? 0 : firstResult;
	}

	/**
	 * 对query中的参数赋值
	 * 
	 * @param query
	 * @param queryParams
	 */
	protected void setQueryParams(Query query, Object[] queryParams) {
		if (queryParams != null && queryParams.length > 0) {
			for (int i = 0; i < queryParams.length; i++) {
				query.setParameter(i, queryParams[i]);
			}
		}
	}

	/**
	 * 创建排序hql语句
	 * 
	 * @param orderby
	 * @return 排序字符串
	 */
	protected String createOrderBy(Map<String, String> orderby) {
		StringBuffer sb = new StringBuffer("");
		if (orderby != null && orderby.size() > 0) {
			sb.append(" order by ");
			for (String key : orderby.keySet()) {
				sb.append(key).append(" ").append(orderby.get(key)).append(",");
			}
			sb.deleteCharAt(sb.length() - 1);
		}
		return sb.toString();
	}

	/**
	 * 获取Session对象
	 * 
	 * @return
	 */
	protected Session getSession() {
		return (!this.hibernateTemplate.isAllowCreate() ? SessionFactoryUtils
				.getSession(this.hibernateTemplate.getSessionFactory(), false)
				: SessionFactoryUtils.getSession(
						this.hibernateTemplate.getSessionFactory(),
						this.hibernateTemplate.getEntityInterceptor(),
						this.hibernateTemplate.getJdbcExceptionTranslator()));
	}

	// 得到最新的文章
	@Override
	public T getNow() {
		System.out.println(clzz.getSimpleName());

		return (T) uniqueResult(
				"from " + clzz.getSimpleName()
						+ " u where u.creatTime=(select max(creatTime) from "
						+ clzz.getSimpleName() + ")", null);
	}

	@Override
	public List<T> findList(final String hql, final Object[] queryParams) {
		return (List<T>) getHibernateTemplate().execute(
				new HibernateCallback() {
					@Override
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						System.out.println(hql);
						Query query = session.createQuery(hql);// 执行查询
						setQueryParams(query, queryParams);// 设置查询参数
						return query.list();
					}
				});
	}
}
