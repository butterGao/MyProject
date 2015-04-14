package com.saitu.dao;

import java.util.List;

import com.saitu.model.Entry;

public interface EntryDao extends BaseDao<Entry> {
		public Entry getNew(int id);
		public Entry getN(Entry id);
		public List<Entry> getEntries(int a);//
		public List<Entry> getByCategory(int a,int b,int s,int page);//按模块取
//		public List<Entry> getNs(List<Entry> s);
}
