package com.sitemap.model;
import java.util.List;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;
public class Task extends Model<Task> {
	private static final long serialVersionUID = 1L;
	public static Task dao = new Task();
/**
 * @param id 指标名称
 * @return 权重
 */
	public String getWeighter(String id) {
		return Db.findFirst("select weighter from target where id = ? ", id).getStr("weighter");
	}
	
	public long queryCountForOid(String id){
		return Db.queryLong("select count(1) from task where id in (select t_id from task_organization where o_id = ?)",id);
	}
	/**
	 * 根据条件查询任务条数（必须给处室ID）
	 * @param where 查询条件
	 * @param parm 参数（id，.....）
	 * @return  条数
	 */
	public long queryCountForWhere(String where,Object... parm){
		return Db.queryLong("select count(1) from task where id in (select t_id from task_organization where o_id = ?) "+where,parm);
	}
	
	
	public List<Record> queryTaskForOid(String id){
		return Db.find("select id,title,create_time from task where id in (select t_id from task_organization where o_id = ?) order by create_time desc",id);
	}
	/**
	 *  根据条件查询任务（必须给处室ID）
	 * @param where 查询条件
	 * @param parm 参数（id，.....）
	 * @return 符合条件的24条任务id，时间，标题，开关，
	 */
	public List<Record> queryTaskForWhere(String where,Object... parm){
		return Db.find("select id,title,open,create_time,count,commit,zjStart,zjEnd,khStart,khEnd,mbStart,mbEnd from task where id in (select t_id from task_organization where o_id = ?) "
				+ where+" order by create_time desc LIMIT 0,24",parm);
	}
	/**
	 * 查询符合条件的处室（只需给条件）
	 * @param where
	 * @param parm
	 * @return
	 */
	public List<Record> queryTaskWhere(String where,Object... parm){
		return Db.find("select id,open,create_time from task where 1=1 "+where,parm);
	}
}
