package com.saitu.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
/**
 * 连接信息
 */
@Entity
public class Link {
	private int id;
	private String name;
	private String url;
	private int sunxu;
	private String info;
	private String path;
	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getSunxu() {
		return sunxu;
	}
	public void setSunxu(int sunxu) {
		this.sunxu = sunxu;
	}
	
	
}
