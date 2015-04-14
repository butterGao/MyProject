package com.sitemap.controller;

import static com.jfinal.core.Const.DEFAULT_FILE_CONTENT_TYPE;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import com.jfinal.aop.Before;
import com.jfinal.core.JFinal;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.render.RenderException;
import com.sitemap.interceptor.TaskInterceptor;
import com.sitemap.manager.ExcelManager;
import com.sitemap.manager.GradeManage;
/**
 * 考评结果功能
 */
public class CountController extends BaseController{
	public void index(){
		render("/admin/jgtj.jsp");
	}
	
	public void order(){
		render("/admin/count_order.jsp");
	}
	
	/**
	 * 导出escel
	 */
	@Before(TaskInterceptor.class)
	public void download(){
		 renderFile(new File(getRequest().getSession().getServletContext().getRealPath("/excel/"+getPara("t_id")+".xls")));
		 return ;
	}
	/**
	 * 导出处室详情
	 */
	@Before(TaskInterceptor.class)
	public void exportOrg(){
		getResponse().addHeader("Content-disposition", "attachment; filename=" + getPara("filename"));
        String contentType = JFinal.me().getServletContext().getMimeType("filename");
        if (contentType == null) {
        	contentType = DEFAULT_FILE_CONTENT_TYPE;		// "application/octet-stream";
        }
        
        getResponse().setContentType(contentType);
        InputStream inputStream = null;
        OutputStream outputStream = null;
        try {
            outputStream = getResponse().getOutputStream();
            ExcelManager.ExcelOrg(getPara("oid"), getPara("tid"), "").exportXLS(outputStream);
            
        }
        catch (Exception e) {
        	throw new RenderException(e);
        }
        finally {
            if (inputStream != null) {
                try {
					inputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
            }
            if (outputStream != null) {
            	try {
					outputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
            }
        }
		return ;
	}
	
	/**
	 * 统计过后的任务
	 */
	public void tasks(){    
		setAttr("task", Db.find("select id,title,create_time,open from task where count= 1 "));
		setAttr("size", Db.find("select id,title,create_time,open from task where count= 1 ").size());
		setAttr("type", "count");
		render("/admin/task_list.jsp");
	}
	/**
	 * 处室自评分详情
	 */
	public void qeuryZp(){
		renderJson(GradeManage.dao.getZpForOrgs(getPara("oid"), (getPara("tid"))));
	}
	
	/**
	 * 评分详情
	 */
	public void show(){
		String t_id = getPara("id");
		getUserId();
//		if(Db.queryLong("select count(1) from organization_fxg where uid =?",getUserId())>0){
//			setAttr("lists",Db.find("select id,short_name from organization where id in (seleect oid from organization_fxg where uid=?)",getUserId()));
//		}else{}
		setAttr("lists",Db.find("select a.short_name,a.id,b.score from organization a,task_organization b where a.id=b.o_id and b.t_id = ? order by b.score desc",t_id));
		
		setAttr("t_id", t_id);
		render("/admin/count_list.jsp");
	}
}
