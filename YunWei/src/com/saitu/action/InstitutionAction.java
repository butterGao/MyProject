package com.saitu.action;

import com.saitu.dao.InstitutionDao;
import com.saitu.model.Institution;
import com.saitu.util.PageModel;

public class InstitutionAction extends BaseAction {
	private int id;
	private int p;
	private PageModel pageModel;
	private Institution institution;
	private InstitutionDao institutionDao;

	public String add() {
		institutionDao.save(institution);
		return "add";
	}

	public String delte() {
		institutionDao.delete(id);
		return "delete";
	}

	public String update() {
		institutionDao.update(institution);
		return "update";
	}

	public String list() {
		return "list";
	}
}
