package com.saitu.dao;

import java.io.Serializable;
import java.util.List;

import com.saitu.util.PageModel;

public interface BaseDao<T> {
	public void save(T t);// 保存数据

	public void saveOrUpdate(T t);// 保存或修改数据

	public void update(T t);// 更新数据

	public void delete(Serializable... ids);// 删除数据

	public T get(Serializable entityId);// get加载实体对象

	public T load(Serializable entityId);// load加载实体对象

	public Object uniqueResult(String hql, Object[] queryParams);// 使用hql语句操作
	// 分页操作

	public long getCount(String where, Object[] parmams);

	public PageModel getPageModel(final int pageNo, final String hql,
			final Object[] queryParams);

	public PageModel getPageModels(final int pageNo, final String where,
			final String count, final Object[] queryParams);// 自定义sql

	public List<?> getList(String where, Object[] queryParams);
}
