package com.sitemap.model;
import java.util.List;
import com.jfinal.plugin.activerecord.Model;
import com.sun.org.apache.bcel.internal.generic.Select;

/**
 * 人员信息
*	+-----------------+--------------+------+-----+---------+-------+
*	| Field           | Type         | Null | Key | Default | Extra |
*	+-----------------+--------------+------+-----+---------+-------+
*	| id              | varchar(32)  | NO   | PRI | NULL    |       |
*	| user_name       | varchar(255) | YES  |     | NULL    | 用户名称   |
*	| login_name      | varchar(255) | YES  |     | NULL    | 登陆账号   |
*	| password        | varchar(255) | YES  |     | NULL    |       |
*	| organization_id | varchar(32)  | YES  | MUL | NULL    | 对应组织    |
*	| number          | int(11)      | YES  |     | NULL    | 员工号        |
*	| role            | int(11)      | YES  |     | NULL    | 角色           |
*	+-----------------+--------------+------+-----+---------+-------+
 */
public class Users extends Model<Users> {
	private static final long serialVersionUID = 392480615204310843L;
	public static Users dao = new Users();
	
	public static String user_name = "user_name";
	public static String login_name = "login_name";
	public static String password = "password";
	public static String role = "role";
	public static String organizationId = "organization_id";
	public static String number = "number";
	
	/**
	 * @param organizationId 处室id
	 * @return 所有处室下的用户
	 */
	public List<Users> queryForOrganization(String organizationId) {
		return find("select * from users where organization_id = ? order by number", new Object[] { organizationId });
	}
	/**
	 * 用户名是否存在
	 */
	public boolean isExistName(String name){
		if(findFirst("select * from users where login_name = ?",new Object[]{name})!=null)return true;
		return false;
	}
	/**
	 * 根据用户名密码得到用户
	 */
	public Users checkoutPass(String name,String pass){
		return findFirst("select * from users where login_name = ? and password ='"+pass+"'",new Object[]{name});
	}
	
	public Users checkoutPass(String name){
		return findFirst("select * from users where login_name = ?",name);
	}
	
	/**
	 * @return 领导局人员
	 */
	public List<Users> queryLead() {
		return find("select * from users where organization_id='c504c59b8a9fd8c1129dc62cdb51ef41'");
	}
	/**
	 * @return 组织处人员
	 */
	public List<Users> queryOrganization() {
		return find("select * from users where organization_id='639668bb1c23f38447f92e79e9ade0af'");
	}
}
