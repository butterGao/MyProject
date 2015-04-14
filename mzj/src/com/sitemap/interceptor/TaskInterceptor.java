package com.sitemap.interceptor;

import com.jfinal.aop.Interceptor;
import com.jfinal.core.ActionInvocation;
import com.jfinal.core.Controller;
import com.sitemap.system.Power;
/**
 * 任务模块访问拦截
 */
public class TaskInterceptor implements Interceptor{

	public void intercept(ActionInvocation ai) {
		Controller controller=ai.getController(); 
		Power power=controller.getAttr("power");
		if(power==null || !power.isTask()){
			controller.redirect(controller.getRequest().getServletContext().getContextPath()+"/users/login.jsp");
		}else{
			ai.invoke();
		}
	}
}
