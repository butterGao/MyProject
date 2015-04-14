package com.saitu.model;


import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
/**
 *记录
 */
@Entity
public class Record {
	private Integer id;
	private int b;//是否更新:1更新，0是未更新
	private String title;//标题
	private Date publishDate;//发布日期
	private Date updateDate;//需要更新的日期
	private String comment;//备注
	private String username;// 操作员
	private String result;// 处理结果
	private String source;//公告来源
	private String content;//内容
	private String path;//照片路径
	private Set<Route> routes=new HashSet<Route>();
	public Record() {
	}

	@Id
	@GeneratedValue
	public Integer getId() {
		return id;
	}
	public int getB() {
		return b;
	}
	
	public String getComment() {
		return comment;
	}
	public String getContent() {
		return content;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Basic()
	public Date getPublishDate() {
		return publishDate;
	}
	public String getResult() {
		return result;
	}
	public String getSource() {
		return source;
	}
	@Column(nullable=false)
	public String getTitle() {
		return title;
	}
	@Temporal(TemporalType.TIMESTAMP)
	public Date getUpdateDate() {
		return updateDate;
	}
	public String getUsername() {
		return username;
	}
	public void setB(int b) {
		this.b = b;
	}
	public void setComment(String comment) {
		if(comment==null){
			comment="";
		}
			
		this.comment = comment;
	}

	public void setContent(String content) {
		this.content = content;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public void setPublishDate(Date publishDate) {
		this.publishDate = publishDate;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	@ManyToMany(targetEntity=Route.class,fetch=FetchType.EAGER)
	public Set<Route> getRoutes() {
		return routes;
	}

	public void setRoutes(Set<Route> routes) {
		this.routes = routes;
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
		
		Record other = (Record) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id)){
			return false;
		}
		return true;
	}

}
