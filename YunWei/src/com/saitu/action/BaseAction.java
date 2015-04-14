package com.saitu.action;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.stereotype.Component;

import com.opensymphony.xwork2.ActionSupport;
import com.saitu.dao.CpolicyDao;
import com.saitu.dao.DisplayDao;
import com.saitu.dao.DutiesDao;
import com.saitu.dao.EntryDao;
import com.saitu.dao.InstitutionDao;
import com.saitu.dao.LinkDao;
import com.saitu.dao.OPpolicyDao;
import com.saitu.dao.WorkingDao;
@Component
public class BaseAction extends ActionSupport implements RequestAware,SessionAware {
	protected Map<String, Object> session;
	protected Map<String, Object> request;
	protected CpolicyDao cpolicyDao;
	protected DisplayDao displayDao;
	protected DutiesDao dutiesDao;
	protected EntryDao entryDao;
	protected LinkDao linkDao;
	protected InstitutionDao institutionDao; 
	protected OPpolicyDao oPpolicyDao;
	protected WorkingDao workingDao;
	
	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}
	@Override
	public void setRequest(Map<String, Object> request) {
		this.request = request;
	}
	@Resource
	public void setCpolicyDao(CpolicyDao cpolicyDao) {
		this.cpolicyDao = cpolicyDao;
	}
	
	@Resource
	public void setDisplayDao(DisplayDao displayDao) {
		this.displayDao = displayDao;
	}
	
	@Resource
	public void setDutiesDao(DutiesDao dutiesDao) {
		this.dutiesDao = dutiesDao;
	}
	@Resource
	public void setInstitutionDao(InstitutionDao institutionDao) {
		this.institutionDao = institutionDao;
	}
	@Resource
	public void setoPpolicyDao(OPpolicyDao oPpolicyDao) {
		this.oPpolicyDao = oPpolicyDao;
	}
	@Resource
	public void setWorkingDao(WorkingDao workingDao) {
		this.workingDao = workingDao;
	}
	@Resource(name="entryDao")
	public void setEntryDao(EntryDao entryDao) {
		this.entryDao = entryDao;
	}
	public void setLinkDao(LinkDao linkDao) {
		this.linkDao = linkDao;
	}
	
}
