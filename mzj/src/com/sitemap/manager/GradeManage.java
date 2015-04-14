package com.sitemap.manager;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import com.alibaba.fastjson.JSON;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.sitemap.model.Organization;
import com.sitemap.model.Task;
import com.sitemap.model.Users;
import com.sitemap.system.Constant;
import com.sitemap.system.pingfen;
import com.test.Test2;
/**
 * 打分管理
 */
public class GradeManage {
	public static GradeManage dao = new GradeManage();
	
	/**
	 * @param weight 权重
	 * @return 解析出来的权重模型列表
	 */
	public List<pingfen> getPingfens(String weight) {
		List<pingfen> l = new ArrayList<pingfen>();
		// 解析权重
		for (String a : weight.split(";")) {
			try {
				l.add(new pingfen(a));
			} catch (Exception e) {
			}
		}
		return l;
	}
	
	/**
	 * @param t_id 任务id
	 *     对任务进行统计打分计算
	 */
	public void pingfen(String t_id) {
		List<Record> pinfenO_id = Organization.dao.querFroTask(t_id);// 查询被考核的处室；
		List<Record> orgs = Organization.dao.querFroTask(t_id);// 查询被考核的处室；
		String weighter = Db.findFirst(
				"select weighter from target where id =(select target_id from task where id= ?)", t_id).get("weighter");// 得到权重
		// 得到权重
		List<pingfen> ps = GradeManage.dao.getPingfens(weighter);// 得到考核者的处室或个人群众
		pingfen a = ps.get(0);// 没有指定的处室标准
		ps.remove(0);
		pingfen b = ps.get(0);// 处室自评标准
		ps.remove(0);
		pingfen c = ps.get(0);// 处室自评标准
		ps.remove(0);
//		Iterator<Record> stuIter = pinfenO_id.iterator();
//		System.out.println(pinfenO_id);
//		while (stuIter.hasNext()) {// 循环被考核处室
//			Record record = stuIter.next();
//			for (pingfen p : ps) {
//				if (p.getId().equals(record.getStr("id"))) {
//					stuIter.remove();// 删除指定的处室（剩下的处室就是平均处室了）
//					break;
//				}
//			}
//		}
		System.out.println(pinfenO_id+"~~~~");
		for (Record org : orgs) {// 给个处室计算分
			System.out.println("!!!!!!!!!!!!"+org.getStr("short_name")+"的评分：");
			double score = 0.0;
			// 计算其余处室分-----------------------------------------
			List<Integer> code = new ArrayList<Integer>();
			for (Record r : orgs) {//（平均分）
				code.add(getScoreLead(org.getStr("id"), r.getStr("id"), t_id));
			}
			for(Integer dd:code){
				System.out.print(dd+";");
			}
			if (a.getType() == 1) {
				for (Integer i : code) {
					if (i == null) {
						i = 100;
					}
					score += i;
				}
				score = score / code.size();
			} else if (a.getType() == 2) {
				for (Integer i : code) {
					if (i == null) {
						i = 0;
					}
					score += i;
				}
				score = score / code.size();
			} else if (a.getType() == 3) {
				for (Integer i : code) {
					if (i > score) {
						score = i;
					}
				}
			} else if (a.getType() == 4) {
				for (Integer i : code) {
					if (i > score) {
						score = i;
					}
				}
			}
			score = score * Double.parseDouble(a.getCode()) / 100;
			System.out.println("\n全部处室总和分数:"+score);
			// 计算其余处室结束------------------------
			//----开始计算分协管分数
			score+=fxgScore(org.getStr("id"),t_id,c.getType())*Double.parseDouble(c.getCode()) / 100;;
			
			// 计算指定处室得分
			System.out.println("指标指定人数："+ps.size());
			
			for (pingfen p : ps) {
				Integer fen = 0;
				if(p.getType()==0){//指定的领导
					fen=getScoreOne(org.getStr("id"), p.getId(), t_id)==null?100:getScoreOne(org.getStr("id"), p.getId(), t_id);
					score += fen * Double.parseDouble(p.getCode()) / 100;
					System.out.println("指定领导："+fen);
				}else{
					//这里可以进一步的改成分组设置！
					if(p.getId().equals(Constant.TopLead)){//是上级领导
						List<Record> leads=Db.find("select * from users where organization_id=?",Constant.TopLead);
						System.out.println("领导数"+leads.size());
						Iterator<Record> l = leads.iterator();
						while(l.hasNext()){//删除指定领导指
							Record r=l.next();
							for(pingfen p1:ps){
								if(r.getStr("id").equals(p1.getId())){
									l.remove();
								}
							}
							for(Record f:Organization.dao.queryFxg(org.getStr("id"))){//删除分协管
								if(r.getStr("id").equals(f.getStr("uid"))){
									l.remove();
								}
							}
						}
						Integer f=0;
						for(Record r:leads){
							if(p.getType()==1||p.getType()==0){
								f+=getScoreOne(org.getStr("id"),r.getStr("id"),t_id)==null?100:getScoreOne(org.getStr("id"),r.getStr("id"),t_id);
							}else{
								f+=getScoreOne(org.getStr("id"),r.getStr("id"),t_id)==null?0:getScoreOne(org.getStr("id"),r.getStr("id"),t_id);
							}
						}
						System.out.println("领导数"+leads.size());
						score+=f/(double)leads.size()*Double.parseDouble(p.getCode()) / 100;
						System.out.println(org.getStr("short_name")+"其余上级领导平均分："+f/leads.size()*Double.parseDouble(p.getCode()) / 100);
					}else{//指定处室
						fen=getScoreLead(org.getStr("id"), p.getId(), t_id);
						if (fen == null) {
							if (p.getType() == 1) {
								fen = 100;
							} else {
								fen = 0;
							}
						}
						score += (double)fen * Double.parseDouble(p.getCode()) / 100;
					}
				}
			}
			//计算处室自评分!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			if(!b.getCode().equals("0")){
				double zpf=zhiping(org.getStr("id"),t_id,b.getType());
					score+=zpf*Double.parseDouble(b.getCode()) / 100;
				}
			System.out.println("总分："+score);
			Db.update("update task_organization  set score = ? where o_id = ? and t_id = ?", score,
					org.getStr("id"), t_id);
		}
	}
	
	/**
	 * @param o_id 处室id
	 * @param t_id 任务id
	 * @return 得到处室自评分
	 */
	public Double getZPF(String o_id,String t_id){
		List<pingfen> ps = getPingfensForTid(t_id);
		pingfen b=ps.get(1);
		//return zhiping(o_id, t_id, b.getType())*(Double.parseDouble(b.getCode())/100);
		return zhiping(o_id, t_id, b.getType());
	}
	
	/**
	 * @param tid 任务id
	 * @return 解析出来的权重模型list
	 */
	public List<pingfen> getPingfensForTid(String tid){
		String w=Db.findFirst("select b.weighter from task a left JOIN target b on (a.target_id = b.id) where a.id=?", tid).getStr("weighter");
		return getPingfens(w);
	}
	
	public static void main(String[] args) {
		Test2 test2=new Test2();
		//GradeManage.dao.pingfen("2014120910515107905996");
		System.out.println(GradeManage.dao.getScores(Constant.Personnel,"2014120910515107905996"));
	}
	
	/**
	 * @param o_id 被评分处室 
	 * @param t_id 任务ID
	 * @return 所有处室评分
	 */
	public List<pingfen> getScores(String o_id,String t_id){
		List<pingfen> ps = getPfList(Db.findFirst("select a.id,a.title,a.open,a.create_time,b.weighter from task a left JOIN target b on (a.target_id = b.id) where a.id=?", t_id));
		for(pingfen p:ps){//处室，领导分
			if(p.getType()==0){
				Integer code=getScoreOne(o_id,p.getId(),t_id);
				if(code==null){
					p.setScore((double)100);
				}else{
					p.setScore((double)code);
				}
			}else{
				if(p.getId().equals(Constant.TopLead)){//如果是
					List<Integer> codes=new ArrayList<Integer>();
					List<Record> leads=Db.find("select id from users where organization_id=?",Constant.TopLead);
					List<Record> fxgs=Organization.dao.queryFxg(o_id);
					Iterator<Record> l = leads.iterator();
					while(l.hasNext()){//删除指定领导指
						Record r=l.next();
						for(pingfen p1:ps){
							if(r.getStr("id").equals(p1.getId())){
								l.remove();
							}
						}
						for(Record f:fxgs){
							if(r.getStr("id").equals(f.getStr("uid"))){
								System.out.println(f.getStr("uid"));
								l.remove();
							}
						}
					}
					Integer f=0;
					for(Record r:leads){
						if(p.getType()==1){
							f+=getScoreOne(o_id,r.getStr("id"),t_id)==null?100:getScoreOne(o_id,r.getStr("id"),t_id);
						}else{
							f+=getScoreOne(o_id,r.getStr("id"),t_id)==null?0:getScoreOne(o_id,r.getStr("id"),t_id);
						}
					}
					System.out.println(f/(double)leads.size());
					p.setScore(f/(double)leads.size());
					
				}
				else{
					Integer score=getScoreLead(o_id, p.getId(), t_id);
					if(score==null){
						p.setMsg("未评分");
						if(p.getType()==1){
							score=100;
						}else{
							score=0;
						}
					}
					p.setScore((double)score);
				}
			}
		}
		pingfen p1=getPingfensForTid(t_id).get(2);
		
		p1.setScore(fxgScore(o_id, t_id, p1.getType()));
		ps.add(p1);
		pingfen p=new pingfen();
		p.setName("处室自评");
		p.setScore(getZPF(o_id, t_id));
		ps.add(p);
		return ps;
	}
	
	public Double leadScore(String oid,String tid,int type){
		
		
		return 100.0;
	}
	
	
	/**
	 * 
	 * @param oid 处室id
	 * @param tid 任务id
	 * @return 处室所有自评人的分数
	 */
	public List<Record> getZpForOrgs(String oid,String tid){
		List<pingfen> ps = getPingfensForTid(tid);
		pingfen p=ps.get(1);
		if(!p.getCode().equals("0")){
			List<Record> us=Db.find("select id,user_name from users where organization_id = ? and id !=(select lead from organization where id=?)",oid,oid);//得到处室所有普通人员
			for(Record u:us){
				Integer score=getScoreOne(oid, u.getStr("id"), tid);
				if(score==null){
					u.set("msg", "未评分");
					if(p.getType()==1){
						score=100;
					}else{
						score=0;
					}
				}else{
					u.set("msg", "");
				}
				u.set("score", score);
			}
			return us;
		}
		return null;
	}
	
	/*// 得到所有处室的评分模型
	public List<pingfen> getPingfesModel(String t_id) {
		List<Record> pinfenO_id = Organization.dao.querFroTask(t_id);// 查询被考核的处室；
		String weighter = Db.findFirst(
				"select weighter from target where id =(select target_id from task where id= ?)", t_id).get("weighter");// 得到权重
		// 得到权重
		List<pingfen> ps = GradeManage.dao.getPingfens(weighter);// 得到考核者的处室或个人群众
		List<pingfen> allp = new ArrayList<pingfen>();// 所有处室评分模型
		pingfen a = ps.get(0);// 没有指定的处室标准
		ps.remove(0);
		pingfen b = ps.get(0);// 处室自评标准
		ps.remove(0);
		Iterator<Record> stuIter = pinfenO_id.iterator();
		while (stuIter.hasNext()) {// 循环被考核处室
			Record record = stuIter.next();
			for (pingfen p : ps) {
				if (p.getId().equals(record.getStr("id"))) {
					stuIter.remove();
					;// 删除指定的处室（剩下的处室就是平均处室了）
					break;
				}
			}
		}
		for (Record o : pinfenO_id) {// 循环被考核处室(剩下所有处室)
			ps.add(new pingfen(o.getStr("id"), a.getType(), a.getCode(), a.getName()));
		}
		return ps;
	}*/
	/**
	 * 得到全部考核者的处室
	 */
	public List<pingfen> getPfList(Record t){
		List<Record> orgs = Organization.dao.querFroTask(t.getStr("id"));// 查询参与任务的处室
		List<pingfen> ps = GradeManage.dao.getPingfens(t.getStr("weighter"));// 指定的处室
		pingfen p1=ps.get(0);//全部处室
		ps.remove(0);
		pingfen p2=ps.get(0);//处室自评
		ps.remove(0);
		ps.remove(0);//分协管领导
		for (pingfen p : ps) {//删除指定的组织
			for (Record o : orgs) {
				if (p.getId().equals(o.get("id"))) {
					orgs.remove(o);
					break;
				}
			}
		}
		for(Record o : orgs){
			ps.add(new pingfen(o.getStr("id"), p1.getType(), p1.getCode(),o.getStr("short_name")));
		}
		return ps;
	}
	/**
	 * @param o_id 处室
	 * @param t_id 任务id
	 * @param type 类型
	 * @return 处室所有普通人员分
	 */
	public double zhiping(String o_id,String t_id,int type){
			List<Integer> scores=new ArrayList<Integer>();
			List<Record> users=Db.find("select id,user_name from users where organization_id = ? and id !=(select lead from organization where id=?)",o_id,o_id);//得到处室所有普通人员
			for(Record u:users){
				System.out.println(u.getStr("user_name")+getScoreOne(o_id,u.getStr("id"),t_id));
				scores.add(getScoreOne(o_id,u.getStr("id"),t_id));
			}
			System.out.println(scores+""+type);
		return getScore(scores,type);
	}
	
	/**
	 * @param o_id 处室
	 * @param t_id 任务id
	 * @param type 类型
	 * @return 处室所有普通人员分
	 */
	public List<Record> zhipings(String o_id,String t_id,int type){
			List<Record> users=Db.find("select id,user_name from users where organization_id = ? and id !=(select lead from organization where id=?)",o_id,o_id);//得到处室所有普通人员
			for(Record u:users){
				if(type==1){
					u.set("score", getScoreOne(o_id,t_id,u.getStr("id"))==null?100:getScoreOne(o_id,t_id,u.getStr("id")));
				}else{
					u.set("score", getScoreOne(o_id,t_id,u.getStr("id"))==null?0:getScoreOne(o_id,t_id,u.getStr("id")));
				}
			}
		return users;
	}

	/**
	 * @param o_id 被评处室
	 * @param u_id 评分者处室
	 * @param t_id 任务
	 * @return
	 */
	private Integer getScoreLead(String o_id, String u_id, String t_id) {
		Record record = Db.findFirst("select score  from grade where o_id = ? and u_o_id= ? and t_id = ? and lead= 0", o_id,u_id,
				t_id);
		return record == null ? null : record.getInt("score");
	}
	/**
	 * @return 处室自评总和
	 */
	private Integer getScoreA(String oid, String t_id) {
		BigDecimal score=Db.queryBigDecimal(
				"select sum(score) as score from grade where o_id=? and t_id=? and u_o_id =? and lead !=0",
				oid, t_id,oid);
		
		return score == null ? null : score.intValue();
	}
	/**
	 * @return 一个用户的评分
	 */
	public Integer getScoreOne(String o_id,String u_id,String t_id){
		Integer score=Db.queryInt("select score  from grade where o_id = ? and u_id= ? and t_id = ?",o_id,u_id,t_id);
		return score==null?null:score;
	}
	
	public Double fxgScore(String oid,String tid,Integer type ){
		List<Record> fxgs=Db.find("select uid from organization_fxg where oid=?",oid);//分协管领导集合
		if(fxgs.size()==0){
			return 100.0;
		}
		List<Integer> fcode=new ArrayList<Integer>();
		for(Record f:fxgs){
			fcode.add(getScoreOne(oid, f.getStr("uid"), tid));
		}
		return getScore(fcode, type);
	}
	
	public double getScore(List<Integer> code,int type){
		if(code.size()==0)return 0;
			double score=0;
			if (type == 1) {
			for (Integer i : code) {
				if (i == null) {
					i = 100;
				}
				score += i;
			}
			score = score / code.size();
		} else if (type == 2) {
			for (Integer i : code) {
				if (i == null) {
					i = 0;
				}
				score += i;
			}
			score = score / code.size();
		} else if (type == 3) {
			for (Integer i : code) {
				if (i > score) {
					score = i;
				}
			}
		} else if (type == 4) {
			for (Integer i : code) {
				if (i > score) {
					score = i;
				}
			}
		}
		return score;
	}
}
