package com.saitu.action;

import com.saitu.dao.DutiesDao;
import com.saitu.model.Duties;
import com.saitu.util.PageModel;
 
public class DutiesAction extends BaseAction {
	private int id;
	private int p;
	private PageModel pageModel;
	private Duties duties;
	private DutiesDao dutiesDao;
 
	public String add() {
		dutiesDao.save(duties);
		return "add";
	}

	public String delte() {
		dutiesDao.delete(id);
		return "delete";
	}

	public String update() {
		dutiesDao.update(duties);
		return "update";
	}

	public String list() {
		return "list";
	}
}
