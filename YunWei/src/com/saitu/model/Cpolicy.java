package com.saitu.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
/**
 * 分类
 * @author Administrator
 */
@Entity
public class Cpolicy {
		private  int id;
		private String title;
		private String eng;
		private int sunxu;
		private String url; 
		@Id 
		@GeneratedValue 
		public int getId() { 
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}
		public String getTitle() {
			return title;
		}
		public void setTitle(String title) {
			this.title = title;
		}
		public String getEng() {
			return eng;
		}
		public void setEng(String eng) {
			this.eng = eng;
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
