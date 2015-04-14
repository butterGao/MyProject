package com.saitu.dao;

import java.io.Serializable;
import java.util.List;
import java.util.Map;



import com.saitu.util.PageModel;

/**
 * 基本的方法
 * @author Administrator
 */
public interface BaseDao<T> {
	//基本数据库操作方法
	public void save(Object obj);//保存数据
	public void saveOrUpdate(Object obj);//保存或修改数据
	public void update(Object obj);//修改数据
	public void delete(Serializable ... ids);//删除数据
	public T get(Serializable entityId);//加载实体对象
	public T load(Serializable entityId);//加载实体对象
	public Object uniqueResult(String hql, Object[] queryParams);//使用hql语句操作
	//分页操作
	public long getCount();//获取总信息数
	public PageModel find(int pageNo);//普通分页操作
	public PageModel find(int pageNo,String where, Object[] queryParams);//搜索信息分页方法
//	public PageModel myFind(int pageNo,String where, Object[] queryParams);
	public PageModel findAny(final String where, final Object[] queryParams,
			final Map<String, String> orderby, final int pageNo,final String zhiduan);
	public PageModel find(int pageNo,Map<String, String> orderby);//按指定条件排序分页方法
	public PageModel find(String where, Object[] queryParams,
			Map<String, String> orderby, int pageNo);//按指定条件分页和排序的分页方法
	public List<T> findList(String hql,Object[] q);
	public T getNow();//得到最近的一条信息
}
