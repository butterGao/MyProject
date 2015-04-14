package com.saitu.action;

import com.saitu.dao.WorkingDao;
import com.saitu.model.Working;
import com.saitu.util.PageModel;

public class WorkingAction extends BaseAction {
	private int id;
	private int p;
	private PageModel pageModel;
	private Working working;
	private WorkingDao workingDao;

	public String add() {
		workingDao.save(working);
		return "add";
	}

	public String delte() {
		workingDao.delete(id);
		return "delete";
	}

	public String update() {
		workingDao.update(working);
		return "update";
	}

	public String list() {
		return "list";
	}
}
