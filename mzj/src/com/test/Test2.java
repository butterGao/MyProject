package com.test;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import net.loyin.jFinal.plugin.AutoTableBindPlugin;
import net.loyin.jFinal.plugin.TableNameStyle;
import net.loyin.util.PropertiesContent;
import com.alibaba.fastjson.JSON;
import com.jfinal.kit.JsonKit;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.activerecord.CaseInsensitiveContainerFactory;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.druid.DruidPlugin;
import com.sitemap.manager.GradeManage;
import com.sitemap.model.Organization;
import com.sitemap.model.Task;
import com.sitemap.model.Users;
import com.sitemap.system.PingfenCode;
import com.sitemap.system.pingfen;
import com.sitemap.util.TimeUtil;

public class Test2 {
	public Test2() {
		DruidPlugin druidPlugin = new DruidPlugin(PropertiesContent.get("jdbc.url"),
				PropertiesContent.get("jdbc.username"), PropertiesContent.get("jdbc.password"),
				PropertiesContent.get("jdbc.driver"));
		druidPlugin.start();
		ActiveRecordPlugin arp = new ActiveRecordPlugin(druidPlugin);
		arp.start();
		AutoTableBindPlugin autoTableBindPlugin = new AutoTableBindPlugin(druidPlugin, TableNameStyle.LOWER);
		autoTableBindPlugin.setShowSql(true);
		autoTableBindPlugin.setContainerFactory(new CaseInsensitiveContainerFactory());
		autoTableBindPlugin.start();
	}

	public static void main(String[] args) {
		Test2 t = new Test2();
		System.out.println(t.getScoreA("639668bb1c23f38447f92e79e9ade0af", "a"));
		System.out.println(t.getScore("a", "a", "a"));
		 t.ss();
		// 一.得到评分模型所有掺入这次任务的人和处室（1.全部处室的，2.指定处室的3.个人的。）
		// 二.根君评分模型 数据库查询 对当前处室的评分（有无？）
		// 三 记录当前分数。
	}

	public void ss() {
		String t_id = "201411061108480488fcd1";
		List<Record> pinfenO_id = Organization.dao.querFroTask(t_id);// 查询被考核的处室；
		List<Record> task = Organization.dao.querFroTask(t_id);// 查询被考核的处室；
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
		for (Record record : task) {// 给个处室计算分
			double score = 0;
			// 计算其余处室分-----------------------------------------
			List<Integer> code = new ArrayList<Integer>();
			for (Record r : pinfenO_id) {
				code.add(getScore(record.getStr("id"),r.getStr("id"),t_id));
			}
			if (a.getType() == 1) {
				for(Integer i:code){
					if(i==null){
						i=0;
					}
					score+=i;
				}
				score=score/code.size();
			} else if (a.getType() == 2) {
				for(Integer i:code){
					if(i==null){
						i=100;
					}
					score+=i;
				}
				score=score/code.size();
			} else if (a.getType() == 3) {
				for(Integer i:code){
					if(i>score){
						score=i;
					}
				}
			} else if (a.getType() == 4) {
				for(Integer i:code){
					if(i>score){
						score=i;
					}
				}
			}
			score=score*Integer.parseInt(a.getCode())/100;
			System.out.println("综合处室:"+score);
			//计算其余处室结束------------------------
			//计算指定处室得分
			for(pingfen p:ps){
				Integer fen=getScore(record.getStr("id"),p.getId(),t_id);
				if(fen==null){
					if(p.getType()==1){
						fen=0;
					}else{
						fen=100;
					}
				}
			score+=fen*Integer.parseInt(p.getCode())/100;
			}
			System.out.println(record.getStr("short_name")+score+"!!!!!!!!!!!!");
		//	Db.update("update task_organization  set score = ? where o_id = ? and t_id = ?",score, record.getStr("id"),t_id);
		}
		
		
	}

	private Integer getScore(String o_id,String u_id,String t_id){
		Record record=Db.findFirst("select score  from grade where o_id = ? and u_id= ? and t_id = ? ",o_id,u_id,t_id);
		return record==null?null:record.getInt("score");
	}
	
	// 获取处室打了多少分
	private double getScoreA(String oid, String t_id) {
		Double score = Db
				.findFirst(
						"select AVG(score) as score from grade where u_id in(select id from users where organization_id= ?) and t_id=?",
						oid, t_id).getDouble("score");
		return score == null ? 0 : score;
	}

	private double getScoreB(String oid, String t_id) {
		Double score = Db
				.findFirst(
						"select AVG(score) as score from grade where u_id in(select id from users where organization_id= ?) and t_id=?",
						oid, t_id).getDouble("score");
		return score == null ? 100 : score;
	}

	private int getScoreC(String oid, String t_id) {
		Integer score = Db
				.findFirst(
						"select max(score) as score from grade where u_id in(select id from users where organization_id= ?) and t_id=?",
						oid, t_id).getInt("score");
		return score == null ? 100 : score;
	}

	private int getScoreD(String oid, String t_id) {
		Integer score = Db
				.findFirst(
						"select min(score) as score from grade where u_id in(select id from users where organization_id= ?) and t_id=?",
						oid, t_id).getInt("score");
		return score == null ? 100 : score;
	}
}
