package com.saitu.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class Floatw {
	private int id;
	private String urlone;
	private String urltow;
	private String urlthree;
	private int stutrs;//0关闭，1显示
	private String path;
	private String urlss;
	private String info;
	
	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}

	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public String getUrlone() {
		return urlone;
	}
	public void setUrlone(String urlone) {
		this.urlone = urlone;
	}
	public String getUrltow() {
		return urltow;
	}
	public void setUrltow(String urltow) {
		this.urltow = urltow;
	}
	public String getUrlthree() {
		return urlthree;
	}
	public void setUrlthree(String urlthree) {
		this.urlthree = urlthree;
	}
	public int getStutrs() {
		return stutrs;
	}
	public void setStutrs(int stutrs) {
		this.stutrs = stutrs;
	}
	public String getUrlss() {
		return urlss;
	}
	public void setUrlss(String urlss) {
		this.urlss = urlss;
	}
}
