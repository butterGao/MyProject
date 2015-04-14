package com.saitu.action;

import java.io.File;
import java.util.List;
import java.util.Map;

import com.saitu.dao.LinkDao;
import com.saitu.model.Link;
import com.saitu.util.FileUpload;
import com.saitu.util.PageModel;

public class LinkAction extends BaseAction{
		private LinkDao linkDao;
		private int id;
		private int order;
		private Link link;
		private List links;
		private int[] ids;
		private File file;
		private int p;
		
		
		public String list(){
			links=linkDao.getLinks();
			 return SUCCESS;
		}
		public String swap(){
			linkDao.swop(id, order);
			return "back";
		}
		public String edit(){
			link=linkDao.get(id);
			return SUCCESS;
		}
		public String update()throws Exception{
			link.setPath(linkDao.get(link.getId()).getPath());
			link.setSunxu(linkDao.get(link.getId()).getSunxu());
			if (file != null) {
				String s=FileUpload.upLoad(file);
				link.setPath(s);
			}
			linkDao.update(link);
			return "back";
		}
		public String add() throws Exception{
			link.setSunxu((int)linkDao.getCount());
			if (file != null) {
				String s=FileUpload.upLoad(file);
				link.setPath(s);
			}
			linkDao.save(link);
			return "back";
		}
		public String delete(){
			linkDao.delete(id);
			return "back";
		}
		public void setLinkDao(LinkDao linkDao) {
			this.linkDao = linkDao;
		}
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}
		public Link getLink() {
			return link;
		}
		public void setLink(Link link) {
			this.link = link;
		}

		public int getP() {
			return p;
		}

		public void setP(int p) {
			this.p = p;
		}

		public int[] getIds() {
			return ids;
		}

		public void setIds(int[] ids) {
			this.ids = ids;
		}


		public File getFile() {
			return file;
		}

		public void setFile(File file) {
			this.file = file;
		}

		public int getOrder() {
			return order;
		}

		public void setOrder(int order) {
			this.order = order;
		}
		public List getLinks() {
			return links;
		}
		public void setLinks(List links) {
			this.links = links;
		}
		
}
