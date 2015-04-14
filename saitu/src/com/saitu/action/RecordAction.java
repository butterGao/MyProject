package com.saitu.action;

import java.io.File;
import java.util.Date;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;
import com.saitu.dao.RecordDao;
import com.saitu.dao.RouteDao;
import com.saitu.model.Record;
import com.saitu.model.Route;
import com.saitu.util.FileUpload;
import com.saitu.util.PageModel;

public class RecordAction extends ActionSupport implements SessionAware {
	private static final long serialVersionUID = 1L;
	private String URL;
	private int count;
	private RecordDao recordDao;
	private File file;
	private Record record;
	private Route route;
	private RouteDao routeDao;
	private PageModel pageModel;// 分页模板
	private Date date1;// 开始时间
	private Date date2;// 结束时间
	private int id;// 传值用ID
	private int pn;// 页码
	private Map<String, Object> session;

	public String add() throws Exception {
		if (file != null) {
			record.setPath(FileUpload.upLoad(file));
		}
		recordDao.save(record);
		return "list";
	}
	public String list11(){
			if(id!=0){
			session.put("id", id);
			}
			id=(Integer) session.get("id");
			System.out.println("idsssssssss"+id);
			route=routeDao.get(id);
			pageModel = recordDao.getByID(pn, id);
			count = pageModel.getTotalRecords();
			System.out.println("idsssssssss"+id);
		return SUCCESS;
	}
	public String listByDate() {
		cl();
		String where = "r where (r.b= 0 or  r.comment !='') and r.publishDate between ? and ?";
		pageModel = recordDao.getByDate(pn, where,
				new Object[] { session.get("date1"), session.get("date2") });
		count=pageModel.getTotalRecords();
		return "other";
	}
 
	public String listByDate1() {
		cl();
		String where = "r where r.b= 1 and r.updateDate between ? and ?";
		pageModel = recordDao.getByDate(pn, where,
				new Object[] { session.get("date1"), session.get("date2") });
		count=pageModel.getTotalRecords();
		System.out.println("++++++++++++++++++++++++++");
		return "list1";
	}

	// 根据路线ID查询所属记录
	public String listRecordId() {
		pageModel = recordDao.getByID(pn, id);
		count = pageModel.getTotalRecords();
		return "list1";
	}

	public String edit() {
		record = recordDao.get(id);
		return SUCCESS;
	}

	public String update() throws Exception {
		if (file != null) {
			record.setPath(FileUpload.upLoad(file));
		}
		Record record1 = recordDao.get(record.getId());
		System.out.println(record1.getRoutes());
		if (record1.getRoutes() != null) {
			Set<Route> ro = new HashSet<Route>();
			ro = record1.getRoutes();
			record.setRoutes(ro);
			/*
			 * Set<Record> re=new HashSet<Record>(); for(Route s:ro){
			 * re=s.getRecords(); re.add(record); s.setRecords(re);; }
			 */
		}
		recordDao.update(record);
		return "list";
	}

	// 查询今天公告
	public String listToday() {
		recordDao.updateRecord();
		System.out.println("更新结束");
		pageModel = recordDao.getToday(pn);
		count = pageModel.getTotalRecords();
		return SUCCESS;
	}

	// 所有公告
	public String all() {
		pageModel = recordDao.getAll(pn);
		count = pageModel.getTotalRecords();
		return "list";
	}

	// 查询记录
	public String list1() {
		session.clear();
		session.put("URL", "Record_list1");
		String where = "r where r.b= 1 order by r.id";
		pageModel = recordDao.getBy1(pn, where, null);
		count = pageModel.getTotalRecords();
		return SUCCESS;
	}

	// 查询公告
	public String list() {
		session.clear();
		session.put("URL", "Record_list");
		pageModel = recordDao.getBy1(pn, getWhere("0"), null);
		count = pageModel.getTotalRecords();
		return SUCCESS;
	}

	public String delete() {
		record = recordDao.get(id);
		int a = record.getB();
		System.out.println("SSSSSSSSSSSSSSSSSSS" + a);
		recordDao.delete(id);
		return "list";
	}

	// 判断有时间段
	protected Object[] judge(Date date1, Date date2) {
		if (session.get("date1") != null && session.get("date2") != null) {
			// where.append(" and r.publishDate between ? and ?");
		}
		Object[] prams = null;
		if (session.get("date1") != null && session.get("date1") != null) {
			prams = new Object[] { session.get("date1"), session.get("date2") };
		}
		return prams;
	}

	public void cl() {
		if (URL != null) {
			session.put("URL", URL);
		}
		if (date1 != null) {
			session.put("date1", date1);
		}
		if (date2 != null) {
			session.put("date2", date2);
		}
	}

	// 判断查询语句
	protected String getWhere(String s) {
		StringBuffer where = new StringBuffer().append("r where (r.b=")
				.append(s).append(" or r.comment !='')");
		where.append(" order by r.id");
		return where.toString();
	}

	public File getFile() {
		return file;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getPn() {
		return pn;
	}

	public Record getRecord() {
		return record;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public void setPn(int pn) {
		this.pn = pn;
	}

	public void setRecord(Record record) {
		this.record = record;
	}

	public void setRecordDao(RecordDao recordDao) {
		this.recordDao = recordDao;
	}

	public PageModel getPageModel() {
		return pageModel;
	}

	public void setPageModel(PageModel pageModel) {
		this.pageModel = pageModel;
	}

	public Date getDate1() {
		return date1;
	}

	public void setDate1(Date date1) {
		if (this.date1 == null) {
			this.date1 = date1;
		}
	}

	public Date getDate2() {
		return date2;
	}

	public void setDate2(Date date2) {
		if (this.date2 == null)
			this.date2 = date2;
	}

	public Route getRoute() {
		return route;
	}

	public void setRoute(Route route) {
		this.route = route;
	}

	public void setRouteDao(RouteDao routeDao) {
		this.routeDao = routeDao;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	public Map<String, Object> getSession() {
		return session;
	}

	public String getURL() {
		return URL;
	}

	public void setURL(String uRL) {
		URL = uRL;
	}
}
