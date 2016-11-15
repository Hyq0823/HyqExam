package com.hyq.listener;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.hyq.domain.Privilege;
import com.hyq.service.PrivilegeService;

public class PrivilegeDataListener implements ServletContextListener 
{

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		
	}

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		//在servletContext加载的时候 读取配置文件从，
		ServletContext application = sce.getServletContext();
		//获取spring创建的容器对象
		ApplicationContext ac =  WebApplicationContextUtils.getWebApplicationContext(application);
		PrivilegeService privilegeService = (PrivilegeService) ac.getBean("privilegeService");
		List<Privilege> pList = privilegeService.findTopPrivilege();
		
	}

}
