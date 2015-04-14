package com.saitu.action;

import javax.annotation.Resource;
import com.saitu.dao.UsersDao;
import com.saitu.model.Users;

public class LoginAction extends BaseAction{
	private boolean b;
	private String msg;
	private String user;
	private String pass;
	private UsersDao usersDao;
	
	public String login(){
		System.out.println("login"+user+pass);
		if(usersDao.uniqueResult("from Users u where u.user=? and u.pass=?", new Object[]{user,pass})!=null){
			session.put("users", usersDao.uniqueResult("from Users u where u.user=? and u.pass=?", new Object[]{user,pass}));
			b=true;
		}
		return SUCCESS;
	}
	
	
	public boolean isB() {
		return b;
	}
	
	public void setB(boolean b) {
		this.b = b;
	}
	
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}

	@Resource
	public void setUsersDao(UsersDao usersDao) {
		this.usersDao = usersDao;
	}
}
