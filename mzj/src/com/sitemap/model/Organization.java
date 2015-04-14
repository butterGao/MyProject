package com.sitemap.model;
import java.util.List;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;

/**
 * 组织结构
 *
 */
public class Organization extends Model<Organization> {
	private static final long serialVersionUID = -4612818513499949967L;
	public static Organization dao = new Organization();
	/**
	 * 名称
	 */
	public static String name="name";
	/**
	 * 编号 (long)
	 */
	public static String code="code";
	/**
	 * 简易名称
	 */
	public static String shortName="short_name";
	/**
	 * 排序码(int)
	 */
	public static String orderNum="order_num";
	
	/**
	 * @return 所有组织机构
	 */
	public List<Organization> query(){
		return find("select * from organization order by order_num");
	}
	/**
	 * @return 所有组织机构
	 */
	public List<Record> queryEasy(){
		return Db.find("select id,short_name from organization order by order_num");
	}
	/**
	 * 
	 * @param taskid 任务id
	 * @return 参与任务的处室
	 */
	public List<Record> querFroTask(String taskid){
		return Db.find("select id,short_name from organization where id in (select o_id from task_organization where t_id = ?) order by order_num",taskid);
	}
	
	public List<Record> queryFxg(String oid){
		return Db.find("select uid from organization_fxg where oid=?",oid);
	}
	
	public String getOrgLead(String o_id){
		return Db.findFirst("select id from users where organization=? and order_num=0",o_id).getStr("id");
	}
}
