package com.saitu.action;
import java.util.Date;
import java.util.List;

import com.saitu.dao.CpolicyDao;
import com.saitu.model.Cpolicy;
import com.saitu.util.PageModel;
public class CpolicyAction extends BaseAction {
	private int id;
	private int p;
	private int order;
	private List list;
	private Cpolicy cpolicy;
	private CpolicyDao cpolicyDao;

	public String add() {
		cpolicyDao.save(cpolicy);
		return "add";
	}
	public String swap(){
		cpolicyDao.swop(id, order);
		int order2=cpolicyDao.get(id).getSunxu();
		return "back";
	}
	public String edit(){
		cpolicy=cpolicyDao.get(id);
		return SUCCESS;
	}
	public String delte() {
		cpolicyDao.delete(id);
		return "delete";
	}

	public String update() {
		System.out.println(cpolicy.getTitle()+cpolicy.getSunxu());
		cpolicyDao.update(cpolicy);
		return "back";
	}

	public String list() {
		list=cpolicyDao.getlists();
		return "list";
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getP() {
		return p;
	}
	public void setP(int p) {
		this.p = p;
	}
	public int getOrder() {
		return order;
	}
	public void setOrder(int order) {
		this.order = order;
	}
	public Cpolicy getCpolicy() {
		return cpolicy;
	}
	public void setCpolicy(Cpolicy cpolicy) {
		this.cpolicy = cpolicy;
	}
	public void setCpolicyDao(CpolicyDao cpolicyDao) {
		this.cpolicyDao = cpolicyDao;
	}
	public List getList() {
		return list;
	}
	public void setList(List list) {
		this.list = list;
	}
}
