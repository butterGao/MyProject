package com.saitu.dao;

import java.util.List;

import com.saitu.model.Category;
import com.saitu.model.Cpolicy;

public interface CpolicyDao extends BaseDao<Cpolicy>{
	public List<Category> getlists();
	public void swop(int id, int order);
}
