package com.saitu.action;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;
import com.saitu.dao.RecordDao;
import com.saitu.dao.RouteDao;
import com.saitu.dao.StationDao;
import com.saitu.model.Record;
import com.saitu.model.Route;
import com.saitu.model.Station;
import com.saitu.util.FileUpload;
import com.saitu.util.GetNewDate;
import com.saitu.util.PageModel;

public class RouteAction extends ActionSupport implements RequestAware,
		SessionAware {
	private static final long serialVersionUID = 1L;
	private String URL;
	private Date date1;
	private Date date2;
	private String where;
	private File file;
	private int count;
	private int id;
	private int Rid;
	private int pn;// 页码
	private PageModel pageModel;
	private String username;
	private Map<String, Object> request;
	// Map类型的session
	private Map<String, Object> session;
	private Record record;
	private RecordDao recordDao;
	private Route route;
	private RouteDao routeDao;
	private StationDao stationDao;
	
	
	//添加更改站点数
	protected void setSta(){
		Station s=new Station();
		s.setCount(route.getZhandian());
		s.setDatetime(new Date());
		s.setName(route.getName());
		stationDao.save(s);
	} 
	public String add() throws Exception {
		if (file != null) {
			route.setPath(FileUpload.upLoad(file));
		}
		setSta();
		routeDao.save(route);
		return "list";
	}

	public String edit() {
		route = routeDao.get(id);
		record = recordDao.getNewReoced(id);
		return SUCCESS;
	}

	// 更新路线状态和记录
	public String update() throws Exception {
		if (file != null) {
			route.setPath(FileUpload.upLoad(file));
		}
		if (Rid != 0) {
			record = recordDao.get(Rid);
			record.setB(1);
			record.setUsername(username);
			Set<Record> s = new HashSet<Record>();
			s = route.getRecords();
			s.add(record);
			System.out.println("qqqqqqqqqqqqqqqq" + record.getRoutes());
			Set<Route> d = new HashSet<Route>();
			d = record.getRoutes();
			d.add(route);
			route.setRecords(s);
			// record.getRoutes().add(route);
			// route.getRecords().add(record);
			route.setUpdateDate(record.getUpdateDate());
			recordDao.saveOrUpdate(record);
			setSta();
		}
		routeDao.saveOrUpdate(route);

		return "list";
	}

	// 判断session是否为空并赋值
	public void re() {
		if (where != null) {
			session.put("where", where);
		}
		if (date1 != null) {
			session.put("date1", date1);
		}
		if (date2 != null) {
			session.put("date2", date2);
		}
		if (URL != null) {
			session.put("URL", URL);
		}
	}

	public String listName() {
		re();
		System.out.println(session.get("where"));
		pageModel = routeDao.getByName(pn, session.get("where").toString());
		count = pageModel.getTotalRecords();
		System.out.println("listname");
		return "other";
	}
	public String listPath() {
		re();
		String hql="r where r.path is null or r.path=''";
		pageModel = routeDao.getPageModel(pn, hql, null);
		count = pageModel.getTotalRecords();
		System.out.println("listname");
		return "other";
	}

	public String listUser() {
		re();
		pageModel = routeDao.getByUser(pn, session.get("where").toString());
		count = pageModel.getTotalRecords();
		return "other";
	}

	public String listState() {
		re();
		pageModel = routeDao.getByState(pn, session.get("where").toString());
		count = pageModel.getTotalRecords();
		return "other";
	}

	public String listDate() {
		re();
		pageModel = routeDao.getByDate(pn,new Object[]{session.get("date1"),session.get("date2")});
		count = pageModel.getTotalRecords();
		return "other";
	}

	public String list() {
		session.clear();
		session.put("URL", "Route_list");
		pageModel = routeDao.getPageModel(pn, null, null);
		count = pageModel.getTotalRecords();
		return SUCCESS;
	}

	public String delete() {
		routeDao.delete(id);
		return "other";
	}

	public Date getDate1() {
		return date1;
	}

	public Date getDate2() {
		return date2;
	}

	public File getFile() {
		return file;
	}

	public int getId() {
		return id;
	}

	public int getPn() {
		return pn;
	}

	public Record getRecord() {
		return record;
	}

	public Route getRoute() {
		return route;
	}

	// 判断有时间段
	protected Object[] judge(Date date1, Date date2) {
		Object[] prams = null;
		if (date1 != null && date2 != null) {

			prams = new Object[] { date1, date2 };
		}
		return prams;
	}

	public void setDate1(Date date1) {
		this.date1 = date1;
	}

	public void setDate2(Date date2) {
		this.date2 = date2;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public void setId(int id) {
		this.id = id;
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

	public void setRoute(Route route) {
		this.route = route;
	}

	public void setRouteDao(RouteDao routeDao) {
		this.routeDao = routeDao;
	}

	public void setWhere(String where) {
		this.where = where;
	}

	public PageModel getPageModel() {
		return pageModel;
	}

	public void setPageModel(PageModel pageModel) {
		this.pageModel = pageModel;
	}

	public String getWhere() {
		return where;
	}

	public int getRid() {
		return Rid;
	}

	public void setRid(int rid) {
		Rid = rid;
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;

	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	@Override
	public void setRequest(Map<String, Object> request) {
		this.request = request;
	}

	public String getURL() {
		return URL;
	}

	public void setURL(String uRL) {
		URL = uRL;
	}

	public Map<String, Object> getRequest() {
		return request;
	}

	public Map<String, Object> getSession() {
		return session;
	}

	public RouteDao getRouteDao() {
		return routeDao;
	}

	public String getUsername() {
		return username;
	}

	public void setStationDao(StationDao stationDao) {
		this.stationDao = stationDao;
	}
	public void setUsername(String username) {
		this.username = username;
	}
}
