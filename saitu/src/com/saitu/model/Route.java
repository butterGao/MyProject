package com.saitu.model;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * 路线
 */
@Entity 
public class Route {
	private Integer id;// 线路ID
	private String name;// 线路名称
	private Date overDate;// 临时路期限
	private String path;// 照片路径
	private String phone;// 电话
	private String state;// 路线状态
	private Date updateDate;// 最近一次更新时间
	private String comment;
	private int zhandian=0;
	private Set<Record> records=new HashSet<Record>();
	public Route() {
	}
	public Route(int id, String name, String phone, String path, String state,
			Date overDate, Date updateDate) {
		this.id = id;
		this.name = name;
		this.phone = phone;
		this.path = path;
		this.state = state;
		this.overDate = overDate;
		this.updateDate = updateDate;
	}
	@Id
	@GeneratedValue
	public Integer getId() {
		return id;
	}

	public String getName() {
		return name;
	}
	@Temporal(TemporalType.TIMESTAMP)
	public Date getOverDate() {
		return overDate;
	}
	public String getPath() {
		return path;
	}
	public String getPhone() {
		return phone;
	}
	public String getState() {
		return state;
	}
	@Temporal(TemporalType.TIMESTAMP)
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setOverDate(Date overDate) {
		this.overDate = overDate;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public void setState(String state) {
		if (state == null) {
			this.state = "正常运行";
		}
		this.state = state;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	@ManyToMany(mappedBy="routes",targetEntity=Record.class,fetch=FetchType.EAGER)
	public Set<Record> getRecords() {
		return records;
	}

	public void setRecords(Set<Record> records) {
		this.records = records;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		return prime * result + ((id == null) ? 0 : id.hashCode());
	}
	
	@Override
	public boolean equals(Object obj) {
		if (this == obj) return true;
		if (obj == null) return false;
		if (getClass() != obj.getClass()) return false;
		
		Route other = (Route) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id)){
			return false;
		}
		return true;
	}

	public String getComment() {
		return comment;
	}

	public int getZhandian() {
		return zhandian;
	}

	public void setZhandian(int zhandian) {
		this.zhandian = zhandian;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}


}