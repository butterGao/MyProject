package com.saitu.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.mysql.jdbc.Blob;

@Entity
public class Entry {
	private int id;
	private String content;// 内容
	private String title;// 标题
	private Date creatTime;// 创建时间
	private int categoryid;// 所属分类
	private String path;// 图片路径
	private int types;
	private Integer chenguo = 0;// 属于成果展示的ID
	private Indexs indexs;

	public Entry() {
	}

	public Entry(int id, String title, Date creatTime, int categoryid, String path, int types) {
		this.id = id;
		this.title = title;
		this.creatTime = creatTime;
		this.categoryid = categoryid;
		this.path = path;
		this.types = types;
	}

	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	@Lob
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Temporal(TemporalType.TIMESTAMP)
	public Date getCreatTime() {
		return creatTime;
	}

	public void setCreatTime(Date creatTime) {
		this.creatTime = creatTime;
	}

	public int getCategoryid() {
		return categoryid;
	}

	public void setCategoryid(int categoryid) {
		this.categoryid = categoryid;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public int getTypes() {
		return types;
	}

	public void setTypes(int types) {
		this.types = types;
	}

	public Integer getChenguo() {
		return chenguo;
	}

	public void setChenguo(Integer chenguo) {
		try {
			if (chenguo == null) {
				chenguo = 0;
			}
		} catch (Exception e) {

		}
		this.chenguo = chenguo;
	}

	@OneToOne(mappedBy = "entry", fetch = FetchType.LAZY)
	public Indexs getIndexs() {
		return indexs;
	}

	public void setIndexs(Indexs indexs) {
		this.indexs = indexs;
	}
}
