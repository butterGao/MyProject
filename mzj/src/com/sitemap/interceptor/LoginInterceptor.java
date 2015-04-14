package com.sitemap.interceptor;

import com.jfinal.aop.Interceptor;
import com.jfinal.core.ActionInvocation;
import com.jfinal.core.Controller;
/**
 * 登陆拦截器
 */
public class LoginInterceptor implements Interceptor{
	public void intercept(ActionInvocation ai) {
		Controller controller=ai.getController();
		if(controller.getAttr("users")==null||controller.getAttr("org")==null||controller.getAttr("power")==null){
			System.out.println(controller.getAttr("users"));
			controller.redirect(controller.getRequest().getServletContext().getContextPath()+"/users/login.jsp");
		}else{
			ai.invoke();
		}
	}
}
