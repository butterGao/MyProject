package com.saitu.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
/**
 * 站点更改
 * @author Administrator
 *
 */
@Entity 
public class Station {
	private int id;
	private String name;//更改站点路线的名称
	private int count;
	private Date datetime;
	@Id 
	@GeneratedValue 
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	
	public String getName() {
		return name;
	}
	
	@Temporal(TemporalType.TIMESTAMP)
	public Date getDatetime() {
		return datetime;
	}
	public void setDatetime(Date datetime) {
		this.datetime = datetime;
	}
	public void setName(String name) {
		this.name = name;
	}
	

}
