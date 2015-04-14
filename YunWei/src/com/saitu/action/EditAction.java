package com.saitu.action;

import java.io.File;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.saitu.dao.IndexsDao;
import com.saitu.model.Entry;
import com.saitu.model.Indexs;
import com.saitu.util.FileUpload;
import com.saitu.util.PageModel;

public class EditAction extends BaseAction {
	private Entry entry;
	private int id;
	private int count;
	private int cid;
	private int cg;
	private int ccid;
	private int a;
	private int b;
	private int p = 0;
	private int page;
	private int total;
	private Date date1;
	private IndexsDao indexsDao;
	private Date date2;
	private List<Entry> rows;
	private PageModel pageModel;
	private String where;
	private File file;
	private String fileFileName;

	public String add() {
		entry.setCreatTime(new Date());
		if (cg < 1) {
			entry.setCategoryid(cid);
		}
		entry.setChenguo(cg);
		entry.setTypes(0);
		if (session.get("path") != null)
			entry.setPath(session.get("path").toString());
		entryDao.save(entry);
		if (cg > 0) {
			id = cg;
			return "listcg";
		}
		return "back";
	}

	public String list() {
		pageModel = entryDao.find(p, " e where e.categoryid = ? ", new Object[] { cid });
		return SUCCESS;
	}

	public String listc() {
		System.out.println("listc    =" + id);
		pageModel = entryDao.find(p, " e where e.categoryid = ? ", new Object[] { id });
		return SUCCESS;
	}

	public String chenguoa() {
		pageModel = entryDao.find(p, " e where e.chenguo = ? ", new Object[] { cg });
		return SUCCESS;
	}

	public String chenguo() {
		pageModel = entryDao.find(p, " e where e.chenguo = ? ", new Object[] { cg });
		cid = cid;
		return "list";
	}

	public String query() {
		String hql = "e where e.categoryid = ?";
		where = " and e.creatTime between ? and ?";
		if (date1 != null && date2 != null) {
			hql += where;
			pageModel = entryDao.find(p, hql, new Object[] { cid, date1, date2 });
			return "list";
		}
		pageModel = entryDao.find(p, hql, new Object[] { cid });
		return "list";
	}

	public String delete() {
		entryDao.delete(id);
		return "back";
	}

	public String upload() {
		entry.setCreatTime(new Date());
		if (entry.getCategoryid() == 34 || entry.getCategoryid() == 31) {
			entryDao.save(entry);
			id = entry.getCategoryid();
			return "listc";
		}
		try {
			entry.setPath(FileUpload.upLoad(file, FileUpload.getStringTime() + fileFileName));
			entry.setTypes(1);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		entryDao.save(entry);
		return "back";
	}

	public String edit() {
		entry = entryDao.get(id);
		return SUCCESS;
	}

	// 后台首页栏目显示
	public String indst() {
		rows = entryDao.getEntries(cid);
		return SUCCESS;
	}
	
	public String zhiding(){
		System.out.println(id);
		Indexs index = indexsDao.get(id);
		index.setOrders(1);
		indexsDao.setOrder(cid);
		indexsDao.update(index);
		return SUCCESS;
	}
	
	// 模块文章
	public String catelist() {
		//String hql = " e where e.categoryid > ? and e.categoryid < ? order by e.creatTime desc";
		String hql = " e  order by e.creatTime desc";
		/*if (a >= 30 && b <= 40) {
			// hql =
			// "select new Entry(id,title,creatTime,categoryid,path,types) from Entry e where ( e.categoryid > ? and e.categoryid < ? ) or e.chenguo > 0 order by creatTime desc";
			hql = " e where ( e.categoryid > ? and e.categoryid < ? ) or e.chenguo > 0 order by e.creatTime desc";
		}*/
		//pageModel = entryDao.find(page, hql, null);
		pageModel=entryDao.findAny(hql, null, null, page, "id,title,creatTime,categoryid,path,types");
		rows = pageModel.getList();
		total = pageModel.getTotalRecords();
		return SUCCESS;
	}

	// 栏目是否重复
	public String exist() {
		count = ((Long) indexsDao.uniqueResult("select count(id) from Indexs i where i.entry.id= ?", new Object[] { id })).intValue();
		entry = entryDao.get(id);
		return SUCCESS;
	}

	// 首页栏目
	public String edite() {
		Indexs index = indexsDao.getEid(id);
		Entry r=new Entry();
		r.setId(cid);
		index.setEntry(r);// 这里Cid就是eid
		
		indexsDao.update(index);
		return SUCCESS;
	}

	public String update() {
		if (session.get("path") != null) {
			entry.setPath(session.get("path").toString());
			session.remove("path");
		}
		entry.setCreatTime(new Date());
		entryDao.update(entry);
		if (entry.getChenguo() > 0) {
			id = entryDao.get(entry.getChenguo()).getCategoryid();
			System.out.println(id);
			if (id == 34 || id == 31) {
				return "listc";
			}
		}
		return "back";
	}
	
	
	public String update2() {
		entry.setCreatTime(new Date());
		entryDao.update(entry);
		id=entry.getCategoryid();
		return "listc";
	}
	

	// -----------------get，set---------------------------

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

	public int getP() {
		return p;
	}

	public void setP(int p) {
		this.p = p;
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
		this.date1 = date1;
	}

	public Date getDate2() {
		return date2;
	}

	public void setDate2(Date date2) {
		this.date2 = date2;
	}

	public int getCid() {
		return cid;
	}

	public void setCid(int cid) {
		this.cid = cid;
	}

	public void setIndexDao(IndexsDao indexsDao) {
		this.indexsDao = indexsDao;
	}

	public int getCcid() {
		return ccid;
	}

	public void setCcid(int ccid) {
		this.ccid = ccid;
	}

	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public int getCg() {
		return cg;
	}

	public List<Entry> getRows() {
		return rows;
	}

	public void setCg(int cg) {
		this.cg = cg;
	}

	public void setA(int a) {
		this.a = a;
	}

	public void setB(int b) {
		this.b = b;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public void setIndexsDao(IndexsDao indexsDao) {
		this.indexsDao = indexsDao;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}
}
