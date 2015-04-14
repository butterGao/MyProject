package com.sitemap.controller;
import static com.jfinal.core.Const.DEFAULT_FILE_CONTENT_TYPE;
import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.Map.Entry;
import com.jfinal.core.Controller;
import com.jfinal.core.JFinal;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.render.RenderException;
import com.sitemap.model.Organization;
import com.sitemap.model.Users;
import com.sitemap.system.Power;
import com.sitemap.util.Result;
import com.sitemap.util.TimeUtil;

/**
 * 基础Controller
 * 
 * @author 刘声凤 2012-9-3 下午10:37:28
 */
public abstract class BaseController extends Controller {
	protected int pageSize = 10;
	protected String tableName;

	@Override
	public void render(String view) {
		super.render(view);
	}

	/** 获取当前系统操作人 */
	public Users getCurrentUser() {
		return this.getSessionAttr("users");
	}/** 获取userid */
	public String getUserId(){
		try {
			return getCurrentUser().getStr("id");
		} catch (Exception e) {
			return null;
		}
	}

	/** 获取处室对象 */
	public Organization getCurrentOrg() {
		return this.getSessionAttr("org");
	}/** 获取处室id */
	public String getOrgId() {
		return getCurrentOrg().getStr("id");
	}

	/** 获取权限 */
	public Power getCurrentPower() {
		return this.getSessionAttr("power");
	}
	
	/**
	 * @return 页面传回来的值
	 */
	public Record getRecord() {
		Record record = new Record();
		Map<String, Object> map = new HashMap<String, Object>();
		for (Entry<String, String[]> set : getParaMap().entrySet()) {
			map.put(set.getKey(), set.getValue()[0]);
		}
		record.setColumns(map);
		return record;
	}


	public void goShow(String url) {
		String id = this.getPara("id");
		setAttr(tableName, Db.findById(tableName, id));
		render(url);
	}

	public void save() {
		try {
			String id = getPara("id");
			if (id.equals("")) {
				id = TimeUtil.getStringTime();
				Db.save(tableName, getRecord().set("id", id).set("create_time", TimeUtil.getNewDate()));
			} else {
				Db.update(tableName, getRecord().set("id", id).set("create_time", TimeUtil.getNewDate()));
			}
			renderJson(new Result(true, id));
		} catch (Exception e) {
			e.printStackTrace();
			renderJson(new Result());
		}
	}

	public String getUUID() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}

	public void goUrl() {
		redirect(getRequest().getServletContext().getContextPath() + "/" + getPara("url"));
	}

	public void del() {
		try {
			String id = getPara("id");
			Db.deleteById(tableName, id);
			renderJson(true);
		} catch (Exception e) {
			renderJson(false);
			e.printStackTrace();
		}
	}
}
