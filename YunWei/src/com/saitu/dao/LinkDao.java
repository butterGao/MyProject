package com.saitu.dao;


import java.util.List;

import com.saitu.model.Link;

public interface LinkDao extends BaseDao<Link>{
	public List<Link> getLinks();
	public void swop(int id,int order);
}

