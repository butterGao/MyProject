package com.saitu.dao;

import com.saitu.model.Indexs;

public interface IndexsDao extends BaseDao<Indexs>{
	public Indexs getEid(Integer id);
	/**
	 * 清空
	 */
	public void setOrder(Integer cid);
}
