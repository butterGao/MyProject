package com.sitemap.controller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import org.apache.commons.lang.StringUtils;
import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.sitemap.interceptor.LoginInterceptor;
import com.sitemap.interceptor.Tr;
import com.sitemap.util.TimeUtil;
/**
*上报管理
*/
@Before(LoginInterceptor.class)
public class ReportController extends BaseController{
	public void index(){
		String sql="select a.id,a.uname from ST_USERINFOR a LEFT JOIN ST_ROLE b ON (a.RID=b.ID)"
				+ " where b.CID=? and b.ID in (select rid from ST_ROLE_FUNC where FID =16 and cid=?)";
		setAttr("peoples", Db.find(sql,getCid(),getCid()));
		render("/report_add.jsp");
	}
	
	public void review(){
		
		setAttr("r", getRecord());
		render("/report_edit.jsp");
	}
	//显示上报详情
	public void review_show(){
		Map<String, Object> parm = new HashMap<String, Object>();
		Record record=Db.findFirst("select * from st_report  where id = ?",getPara("id"));
		parm.put("content", record.get("content"));
		parm.put("reviews",	Db.find("select a.createtime,a.status,b.uname from st_review a,st_userinfor b where a.userid=b.id and a.rid=?",getPara("id")));
		if(record.getBigDecimal("status").intValue()==2){//已经驳回
			parm.put("isre",true);
		}else{
			//已经审批过
			if(Db.queryBigDecimal("select count(1) from st_review where status > 0 and userid = ? and rid = ?"
					,getUid(),getPara("id")).intValue()>0){
				parm.put("isre",true);
			}else{
				parm.put("isre",false);
			}
		}
		renderJson(parm);
	}
	//审批上报
	public void shenpi() {
		Record record=Db.findFirst("select id,rtype,peopledou from st_report where id=?",getPara("id"));
		try {
			Db.save(st_Review, new Record().set("id", "reviewsequ.nextval").set("userid",getUid())
					.set("status", getPara("type")).set("createtime", TimeUtil.getNewDate())
					.set("descript", getPara("content")).set("rid", getPara("id")));
			String pou=record.getStr("peopledou");
			Db.update(st_Report, record.set("peopledou",pou.replace(getUid()+"_", "")));
			
			if(getParaToInt("type")==2){//驳回
				Db.update("update st_report set status =2 where id= ? ",getPara("id"));
			}
			
			renderJson(true);
		} catch (Exception e) {
			renderJson(false);
			e.printStackTrace();
		}
	}
	//显示上报
	public void showReview(){
		Page<Record>p=Db.paginate(getParaToInt("page"), getParaToInt("rows"), "select a.id,a.people,a.peopledou,a.rtype,a.title,a.remark,a.countNumber,a.createtime,a.status,b.uname ", 
				"from st_report a,st_userinfor b where a.pid=b.id and  ',_'||a.people like  ?  escape ',' order by id desc","%,_"+getUid()+",_%");
		Iterator<Record> i=p.getList().iterator();
		while(i.hasNext()){
			Record r=i.next();
			r.set("over", 0);
			try {
				 if(r.getBigDecimal("rtype").intValue()==1){//如果是逐级
					if(StringUtils.isNotEmpty(r.getStr("peopledou"))){
						if (Integer.parseInt(r.getStr("peopledou").split("_")[0])==getUid()){//审批人在第一顺序
							r.set("over", 1);
						}else {
							i.remove();
						}
					}
				}else{//同级
						try {
							if (r.getStr("peopledou").contains((getUid() + "_"))) {//在审批列表中
								r.set("over", 1);
							}
						} catch (Exception e) {
						}
				}
				//---------查询审批人名称
				String people="";
				for(Record s:Db.find("select uname from st_userinfor where ',_'||?||',_' like '%,_'||id||',_%'  escape ','",r.getStr("people"))){
					people+=s.getStr("uname")+",";
				}
				r.set("people",people);
				r.set("CREATETIME",r.get("CREATETIME").toString().substring(0,19));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		renderJson(p);
	}
	//保存
	public void save(){
		Record record=getRecord();
		Integer id=Db.findFirst("select reportSequ.nextval as id from DUAL").getBigDecimal("id").intValue();
		record.set("id", id).set("createtime",TimeUtil.getNewDate());
		record.set("countnumber",getPara("people").split(",").length);
		record.set("peopledou", getPara("people").replaceAll(",", "_")+"_");//审批人存到dou
		record.set("people", getPara("people").replaceAll(",", "_")+"_");
		Db.save(st_Report, record.set("pid", getUid()).set("status", 1).set("cid", getCid()));
//		if(getParaToInt("rtype")==1){//逐级审批
//			Db.save(st_Review, new Record().set("id", "ReviewSequ.nextval").set("rid", id)
//					.set("userid", getPara("people").split(",")[0]).set("status", 0));
//		}else{//同级审批
//			for(String u:getPara("people").split(",")){
//				Db.save(st_Review, new Record().set("id", "ReviewSequ.nextval").set("rid", id)
//						.set("userid",u).set("status", 0));
//			}
//		}
		renderJson(true);
	}
	
	
	public void edit(){
		
	}
	
}
