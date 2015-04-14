package com.sitemap.system;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.sitemap.manager.GradeManage;
import com.sitemap.model.Organization;

public class AllScore {
	private List<pingfen> leads;
	private List<pingfen> fxgs;
	private List<pingfen> zhiPings;
	private List<pingfen> chushis;
	private List<pingfen> zpfs;
	private List<pingfen> target;
	private String oid;
	private String tid;
	public AllScore() {
	}
	public AllScore(String tid,String oid) {
		target=GradeManage.dao.getPingfensForTid(tid);
		this.oid=oid;
		this.tid=tid;
	}
	
	public List<pingfen> getLead(){
		leads=new ArrayList<pingfen>();
		pingfen lead = null;
		for(pingfen p:target){
			if(p.getId().equals(Constant.TopLead)){
				lead=p;
			}
		}
		List<Record> leadrs=Db.find("select id from users where organization_id=?",Constant.TopLead);
		List<Record> fxgs=Organization.dao.queryFxg(oid);
		Iterator<Record> l = leadrs.iterator();
		while(l.hasNext()){//删除指定领导指
			Record r=l.next();
			for(pingfen p1:target){
				if(r.getStr("id").equals(p1.getId())){
					l.remove();
				}
			}
			for(Record f:fxgs){
				if(r.getStr("id").equals(f.getStr("uid"))){
					l.remove();
				}
			}
		}
		Integer f=0;
		for(Record r:leadrs){
			if(lead.getType()==1){
				f+=GradeManage.dao.getScoreOne(oid,r.getStr("id"),tid)==null?100:GradeManage.dao.getScoreOne(oid,r.getStr("id"),tid);
			}else{
				f+=GradeManage.dao.getScoreOne(oid,r.getStr("id"),tid)==null?0:GradeManage.dao.getScoreOne(oid,r.getStr("id"),tid);
			}
		}
		
		lead.setScore(f/(double)leads.size());
		leads.add(lead);
		return leads;
	}
}
