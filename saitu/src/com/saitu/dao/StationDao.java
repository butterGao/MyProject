package com.saitu.dao;

import java.util.Date;

import com.saitu.model.Station;

public interface StationDao extends BaseDao<Station>{
	public int count(Date d1,Date d2);
}
