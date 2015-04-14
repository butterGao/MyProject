package com.saitu.listener;

import java.util.TimerTask;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import org.omg.CORBA.PRIVATE_MEMBER;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import com.saitu.dao.LogincountDao;
import com.saitu.model.LoginCount;
import com.saitu.util.Tasks;

public class LoginListener implements ServletContextListener{
	private LogincountDao ldDao;
	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		
	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		 ldDao=(LogincountDao)this.getObjectFromApplication(arg0.getServletContext(),
				"logincountDao");
		try {
			// 定时任务
			Tasks.startDayForTime(new TimerTask() {
				public void run() {
					try {
						LoginCount lCount=ldDao.get(2);
						lCount.setCount(0);
						ldDao.update(lCount);
					} catch (Exception e) {
						// TODO: handle exception
					}
				};
			}, "23:59:59", 24);
		} catch (Exception e) {
			System.out.println("Running  : contextInitialized(): " + "定时任务开启失败!!!!");
			e.printStackTrace();
		}
	}
	 private Object getObjectFromApplication(ServletContext servletContext,String beanName){  
	        //通过WebApplicationContextUtils 得到Spring容器的实例。  
	        ApplicationContext application=WebApplicationContextUtils.getWebApplicationContext(servletContext);  
	        //返回Bean的实例。  
	        return application.getBean(beanName);  
	    }  
}
