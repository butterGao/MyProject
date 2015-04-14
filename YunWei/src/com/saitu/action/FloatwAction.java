package com.saitu.action;

import java.io.File;
import java.util.List;

import com.opensymphony.xwork2.ActionSupport;
import com.saitu.dao.FloatDao;
import com.saitu.model.Floatw;
import com.saitu.util.FileUpload;

public class FloatwAction extends ActionSupport{
	private Floatw floatw;
	private List<Floatw> floatws;
	private FloatDao floatDao;
	private File mgfile;
	private int id;
	public String edit(){
		floatw=floatDao.get(id);
		return SUCCESS; 
	}
	public String show(){
		floatws=floatDao.findList("from Floatw f", null);
		return SUCCESS;
	}
	public String count(){
		id=(int) floatDao.getCount();
		return SUCCESS;
	}
	public String delete(){
		floatDao.delete(id);
		return SUCCESS;
	}
	public String addshouye(){
		if(mgfile!=null){
			try {
				floatw.setPath(FileUpload.upLoad(mgfile));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		floatDao.save(floatw);
		floatws=floatDao.findList("from Floatw f", null);
		return "list";
	}
	
	public String update() throws Exception{
		floatw.setPath(floatDao.get(floatw.getId()).getPath());
		if(mgfile!=null){
			floatw.setPath(FileUpload.upLoad(mgfile));
		}
		floatDao.update(floatw);
		floatws=floatDao.findList("from Floatw f", null);
		return "list";
	}
	
	public Floatw getFloatw() {
		return floatw;
	}

	public void setFloatw(Floatw floatw) {
		this.floatw = floatw;
	}

	public void setFloatDao(FloatDao floatDao) {
		this.floatDao = floatDao;
	}
	public File getMgfile() {
		return mgfile;
	}
	public void setMgfile(File mgfile) {
		this.mgfile = mgfile;
	}
	public List<Floatw> getFloatws() {
		return floatws;
	}
	public void setFloatws(List<Floatw> floatws) {
		this.floatws = floatws;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
}
