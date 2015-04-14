package com.saitu.dao;

import com.saitu.model.Record;
import com.saitu.util.PageModel;
public interface RecordDao extends BaseDao<Record>{
		public PageModel getBy1(int p,String where,Object[] queryParams);//查询公告或记录
		public PageModel getByID(int p,int id);//根据路线ID查询记录
		public PageModel getAll(int p); //查询全部
		public PageModel getBy0(int p,String where,Object[] queryParams); //查询未更新
		public Record getNewReoced(int id);//根据路线ID查询最近一次的记录
		public PageModel getToday(int p);//查询今日任务
		public void updateRecord();//自动更新到期线路
		public PageModel getByDate(int p,String where,Object[] queryParams);//查询时间段内的公告记录
}
 