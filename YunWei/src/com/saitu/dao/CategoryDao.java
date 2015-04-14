package com.saitu.dao;

import java.util.List;

import com.saitu.model.Category;

public interface CategoryDao extends BaseDao<Category> {
	public List<Category> getlists();
	public void swop(int id, int order);
}
