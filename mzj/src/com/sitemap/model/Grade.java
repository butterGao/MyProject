package com.sitemap.model;
import java.util.List;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

/**
 * 评分
 */
public class Grade {
	public static Grade dao = new Grade();
	/**
	 * 考核组织
	 */
	public static String o_id = "o_id";
	/**
	 * 评分人
	 */
	public static String u_id = "u_id";
	/**
	 * 考核任务
	 */
	public static String t_id = "t_id";
	/**
	 * 分数
	 */
	public static String score = "score";
	/**
	 * 
	 * @param tid 任务id
	 * @param uid 用户id
	 * @return 用户为某个任务所有组织的评分
	 */
	public List<Record> queryForTaskAndUsers(String tid, String uid) {
		return Db.find("select a.score,b.name from grade a inner join organization b on a.o_id=b.id where a.t_id = ? and a.u_id= ?", new Object[] { tid, uid });
	}
	/**
	 * @param oid
	 * @param tid
	 * @param uid
	 * @return 用户对单个处室完成任务评分
	 */
	public List<Record> queryscore(String oid, String tid,String uid) {
		return Db.find("select a.score,b.name from grade a inner join organization b on a.o_id=b.id where a.t_id = ? and a.u_id= ? and a.o_id = ?", new Object[] { tid, uid ,oid});
	}
}
