package com.sitemap.model;

import java.util.List;
import com.jfinal.plugin.activerecord.Model;

/**
 *指标
 */
public class Target extends Model<Target>{
	private static final long serialVersionUID = -6618051203230822755L;
	public static Target dao=new Target();
	
	/**
	 * 权重
	 */
	public static String weighter="weighter";
	/**
	 * 标题
	 */
	public static String title="title";
	/**
	 * 内容
	 */
	public static String content="content";
	
	/**
	 * 
	 * @return 所有指标（id，标题，创建时间）
	 */
	public List<Target> queryEasy(){
		return find("select id,title,create_time from target");
	}
}
