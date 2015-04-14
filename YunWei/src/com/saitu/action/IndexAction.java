package com.saitu.action;

import java.io.File;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.struts2.interceptor.ApplicationAware;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Component;
import com.opensymphony.xwork2.ActionContext;
import com.saitu.dao.CategoryDao;
import com.saitu.dao.FloatDao;
import com.saitu.dao.IndexsDao;
import com.saitu.dao.LogincountDao;
import com.saitu.model.Cpolicy;
import com.saitu.model.Display;
import com.saitu.model.Duties;
import com.saitu.model.Entry;
import com.saitu.model.Floatw;
import com.saitu.model.Institution;
import com.saitu.model.Link;
import com.saitu.model.LoginCount;
import com.saitu.model.OPpolicy;
import com.saitu.model.Working;
import com.saitu.util.TimeUtil;

@Component
public class IndexAction extends BaseAction implements ApplicationAware{
	// private Cpolicy cpolicy;
	// private Display display;
	// private Duties duties;
	// private Institution institution;
	// private OPpolicy oPpolicy;
	// private Working working ;
	// public String init(){
	// working = workingDao.getNow()!=null?workingDao.getNow():null;
	// cpolicy=cpolicyDao.getNow()!=null?cpolicyDao.getNow():null;
	// display=displayDao.getNow()!=null?displayDao.getNow():null;
	// duties=dutiesDao.getNow()!=null?dutiesDao.getNow():null;
	// institution=institutionDao.getNow()!=null?institutionDao.getNow():null;
	// oPpolicy=oPpolicyDao.getNow()!=null?oPpolicyDao.getNow():null;
	// working=workingDao.getNow()!=null?workingDao.getNow():null;
	// System.out.println("ss");
	// return SUCCESS;
	// }
	private FloatDao floatDao;
	Map<String,Object> application;
	private Cpolicy c1;
	private Cpolicy c2;
	private Cpolicy c3;
	private Cpolicy c4;
	private Cpolicy c5;
	private Cpolicy c6;
	private Cpolicy c7;
	private Cpolicy c8;
//	private List links;
	private List<Floatw> floatws;
	private List cpolicys;
	private List<Entry> works;
	private List<Entry> policies;
	private List<Entry> displaies;
	private Entry entry;
	private Entry policy;
	private Entry display;
	private Entry opinion;
	private Entry repair;
	private Entry working;
	private Entry map;
	private Entry query;
	private LogincountDao lDao;
	private int count1;
	private int count2;
	
	public String init() {
		LoginCount lCount=lDao.get(1);
		LoginCount lCount2=lDao.get(2);
		if(session.get("id")==null){
			lCount.setCount(lCount.getCount()+1);
			lCount2.setCount(lCount2.getCount()+1);
			lDao.update(lCount2);
			lDao.update(lCount);
			session.put("id",TimeUtil.getStringTime());
		}
		count1=lCount.getCount();
		count2=lCount2.getCount();
		cpolicys=cpolicyDao.getlists();
		c1=(Cpolicy) cpolicys.get(0);
		c2=(Cpolicy) cpolicys.get(1);
		c3=(Cpolicy) cpolicys.get(2);
		c4=(Cpolicy) cpolicys.get(3);
		c5=(Cpolicy) cpolicys.get(4);
		c6=(Cpolicy) cpolicys.get(5);
		c7=(Cpolicy) cpolicys.get(6);
		c8=(Cpolicy) cpolicys.get(7);
		application.put("c1",c1 );
		application.put("c2",c2 );
		application.put("c3",c3 );
		application.put("c4",c4 );
		application.put("c5",c5 );
		application.put("c6",c6 );
		application.put("c7",c7 );
		application.put("c8",c8 );
//		links=linkDao.getLinks();
		floatws=floatDao.findList("from Floatw f ", null);
//		policy =entryDao.getN(entryDao.get(indexDao.get(1).getEid()));//主页政策流程
//		display = entryDao.getN(entryDao.get(indexDao.get(3).getEid()));//主页宣传展示
//		opinion = entryDao.getN(entryDao.get(indexDao.get(4).getEid()));//主页意见反馈
		displaies=entryDao.getEntries(3);
		works=entryDao.getEntries(2);
		policies=entryDao.getEntries(1);
		
		//repair = entryDao.getNew(51);//主页网上报修
//		working =entryDao.getN(entryDao.get(indexDao.get(2).getEid()));;//工作
		return SUCCESS;
	}
	private List<Entry> s(List<Entry> l){
		for(int i=0;i<l.size();i++){
			if(l.get(i).getTitle().length()>21){
				l.get(i).setTitle(l.get(i).getTitle().substring(0, 22)+"...");
			}
		}
		return l;
	}
	public Entry getEntry() {
		return entry;
	}

	public void setEntry(Entry entry) {
		this.entry = entry;
	}

	public Entry getPolicy() {
		return policy;
	}

	public void setPolicy(Entry policy) {
		this.policy = policy;
	}

	public Entry getDisplay() {
		return display;
	}

	public void setDisplay(Entry display) {
		this.display = display;
	}

	public Entry getOpinion() {
		return opinion;
	}

	public void setOpinion(Entry opinion) {
		this.opinion = opinion;
	}

	public Entry getRepair() {
		return repair;
	}

	public void setRepair(Entry repair) {
		this.repair = repair;
	}

	public Entry getWorking() {
		return working;
	}

	public void setWorking(Entry working) {
		this.working = working;
	}

	public Entry getMap() {
		return map;
	}

	public void setMap(Entry map) {
		this.map = map;
	}

	public Entry getQuery() {
		return query;
	}

	public void setQuery(Entry query) {
		this.query = query;
	}


//	public List getLinks() {
//		return links;
//	}
//
//	public void setLinks(List links) {
//		this.links = links;
//	}

	public void setFloatDao(FloatDao floatDao) {
		this.floatDao = floatDao;
	}

	public List<Floatw> getFloatws() {
		return floatws;
	}

	public void setFloatws(List<Floatw> floatws) {
		this.floatws = floatws;
	}

	public List<Entry> getWorks() {
		return works;
	}

	public List<Entry> getPolicies() {
		return policies;
	}
	public List<Entry> getDisplaies() {
		return displaies;
	}
	@Override
	public void setApplication(Map<String, Object> application) {
		this.application=application;
	}
	@Resource(name="logincountDao")
	public void setlDao(LogincountDao lDao) {
		this.lDao = lDao;
	}
	public int getCount1() {
		return count1;
	}
	public void setCount1(int count1) {
		this.count1 = count1;
	}
	public int getCount2() {
		return count2;
	}
	public void setCount2(int count2) {
		this.count2 = count2;
	}
	

}
