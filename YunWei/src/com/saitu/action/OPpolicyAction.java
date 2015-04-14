package com.saitu.action;
import com.saitu.dao.OPpolicyDao;
import com.saitu.model.OPpolicy;
import com.saitu.util.PageModel;
public class OPpolicyAction extends BaseAction {
	private int id;
	private int p;
	private PageModel pageModel;
	private OPpolicy oPpolicy;
	private OPpolicyDao oPpolicyDao;

	public String add() {
		oPpolicyDao.save(oPpolicy);
		return "add";
	}

	public String delte() {
		oPpolicyDao.delete(id);
		return "delete";
	}

	public String update() {
		oPpolicyDao.update(oPpolicy);
		return "update";
	}

	public String list() {
		return "list";
	}
}
