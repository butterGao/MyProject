package com.saitu.action;

import com.opensymphony.xwork2.ActionSupport;
import com.saitu.dao.EntryDao;
import com.saitu.model.Entry;

import java.io.FileInputStream;
import java.io.InputStream;
import java.net.URLEncoder;

import org.apache.struts2.ServletActionContext;

//文件下载
public class UploadAction extends ActionSupport {
	private Entry entry;
	private int id;
	private EntryDao entryDao;
	private String title;

	// 返回一个输入流，作为一个客户端来说是一个输入流，但对于服务器端是一个 输出流
	public InputStream getDownloadFile(){
		entry=entryDao.get(id);
		this.title=entry.getTitle()+entry.getPath().substring(entry.getPath().lastIndexOf("."));
		InputStream inputStream=null;
		try{
			inputStream=ServletActionContext.getServletContext()
					.getResourceAsStream("upload/"+entry.getPath());
		}catch (Exception e){
			
		}
		if(inputStream==null)title+="在服务器上未找到";
			return inputStream;
	}
	public Entry getEntry() {
		return entry;
	}


	public void setEntry(Entry entry) {
		this.entry = entry;
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public EntryDao getEntryDao() {
		return entryDao;
	}


	public void setEntryDao(EntryDao entryDao) {
		this.entryDao = entryDao;
	}
	public String getTitle() {
		//return title;
		try{
		return URLEncoder.encode(title, "utf-8");
		}catch(Exception e)
		{
			return "unknow";
		}
	}
	public void setTitle(String title) {
		this.title = title;
	}

}
