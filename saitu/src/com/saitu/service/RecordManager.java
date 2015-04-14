package com.saitu.service;

import com.saitu.model.Record;
import com.saitu.util.PageModel;

public interface RecordManager {
	public Record get(int id);
	public void delete(int id);
	public PageModel getByDate(String date1,String date2);//按时间查找更新
	public PageModel getByBool(int i);//查询更新与否记录
	public PageModel getByID(int id);//根据路线ID查询记录
	public PageModel getAll();
	public void save(Record record);
}
