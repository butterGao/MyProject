package com.saitu.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import org.apache.commons.lang.StringUtils;
@Entity
public class Users {
	private String user;
	private String pass;
	@Id
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
}
