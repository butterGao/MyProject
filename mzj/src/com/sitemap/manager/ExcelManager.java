package com.sitemap.manager;
import java.util.List;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.sitemap.model.Organization;
import com.sitemap.system.Constant;
import com.sitemap.system.pingfen;
import com.sitemap.util.EXcelUtil;
import com.test.Test2;
/**
 * excel导出管理
 */
public class ExcelManager {
	public static void main(String[] args) {
		String a = "ssssss(";
		System.out.println(a.substring(0, a.indexOf("(")));
		;
		Test2 sTest2=new Test2();
		ExcelManager.exportAll("2014120910515107905996", "c:/aaads.xls");
	}
	/**
	 * 导出所有详情
	 */
	public static void exportAll(String t_id, String path) {
		List<Record> tasks = Db
				.find("select a.short_name,a.id,b.score from organization a,task_organization b where a.id=b.o_id and b.t_id = ? order by b.score desc",
						t_id);
		EXcelUtil e = new EXcelUtil(path);
		e.createSheet("全部处室综合得分");
		e.createRow(0);
		e.setCell(0, "序号");
		e.setCell(1, "处室");
		e.setCell(2, "分数");
		e.setCell(3, "加分项");
		e.setCell(4, "备注");
		for (int i = 0; i < tasks.size(); i++) {
			Record t = tasks.get(i);
			e.createRow(i + 1);
			e.setCell(0, i + 1);
			e.setCell(1, t.getStr("short_name"));
			e.setCell(2, t.getDouble("score"));
			e.setCell(3, "");
			e.setCell(4, "");
		}
		List<Record> orgs = Organization.dao.querFroTask(t_id);
		for (Record o : orgs) {
			List<pingfen> ps = GradeManage.dao.getScores(o.getStr("id"), t_id);
			e.createSheet(o.getStr("short_name")+"得分");
			e.createRow(0);
			e.setCell(1, "处室");
			e.setCell(2, "分数");
			e.setCell(3, "加分项");
			e.setCell(4, "备注");
			int index=0;
			for (int i = 0; i < ps.size()-1; i++) {
				e.createRow(++index);
				if(ps.get(i).getId().equals(Constant.TopLead)){
					e.setCell(1, ps.get(i).getName());
					e.setCell(2, ps.get(i).getScore());
					e.setCell(3, "");
					e.setCell(4,  ps.get(i).getMsg());
				}else if(ps.get(i).equals("003")){
					e.setCell(1, ps.get(i).getName());
					e.setCell(2, ps.get(i).getScore());
					e.setCell(3, "");
					e.setCell(4,  ps.get(i).getMsg());
				}else{
					e.setCell(1, ps.get(i).getName());
					e.setCell(2, ps.get(i).getScore());
					e.setCell(3, "");
					e.setCell(4,  ps.get(i).getMsg());
				}
			}
			e.createRow(++index);
			e.setCell(0, "处室自评");
			e.setCell(1, "自评总分");
			e.setCell(2, ps.get(ps.size()-1).getScore());
			
			List<Record> us=GradeManage.dao.getZpForOrgs(o.getStr("id"), t_id);
			for(int i=0;i<us.size();i++){
				e.createRow(i + 1+ps.size());
				e.setCell(1, us.get(i).getStr("user_name"));
				e.setCell(2, us.get(i).getInt("score"));
				e.setCell(3, "");
				e.setCell(4, us.get(i).getStr("msg"));
			}
		}
		e.exportXLS();
	}
	
	/**
	 * 导出单个处室详情
	 */
	public static EXcelUtil ExcelOrg(String oid, String tid, String path) {
		List<pingfen> ps = GradeManage.dao.getScores(oid, tid);
		EXcelUtil e = new EXcelUtil(path);
		e.createSheet(Db.findById("organization", oid).getStr("short_name"));
		e.createRow(0);
		e.setCell(1, "处室");
		e.setCell(2, "分数");
		e.setCell(3, "加分项");
		e.setCell(4, "备注");
		for (int i = 0; i < ps.size()-1; i++) {
			e.createRow(i + 1);
			e.setCell(1, ps.get(i).getName());
			e.setCell(2, ps.get(i).getScore());
			e.setCell(3, "");
			e.setCell(4, "");
		}
		e.createRow(ps.size());
		e.setCell(0, "处室自评");
		e.setCell(1, "自评总分");
		e.setCell(2, ps.get(ps.size()-1).getScore());
		
		List<Record> us=GradeManage.dao.getZpForOrgs(oid,tid);
		for(int i=0;i<us.size();i++){
			e.createRow(i + 1+ps.size());
			e.setCell(1, us.get(i).getStr("user_name"));
			e.setCell(2, us.get(i).getInt("score"));
			e.setCell(3, "");
			e.setCell(4, "");
		}
		return e;
	}

	private void setTitle() {
	}
}
