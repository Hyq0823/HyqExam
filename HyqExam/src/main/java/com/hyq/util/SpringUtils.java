package com.hyq.util;
import javax.swing.Spring;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;


@Service
@Lazy(false)
/**
 * 获取bean的工具类（通过注入applicationCotnext）
 * @author hyq
 *
 */
public class SpringUtils implements ApplicationContextAware,DisposableBean
{
    private static Logger logger = LoggerFactory.getLogger(SpringUtils.class);
	public static  ApplicationContext applicationContext = null;
	
	@SuppressWarnings("unchecked")
	public static <T> T getBean(String beanName){
		isInjected();
		return (T) applicationContext.getBean(beanName);
	}
	
	public static <T> T getBean(Class<T> requiredType){
		isInjected();
		return applicationContext.getBean(requiredType);
	}

	
	@Override
	public void destroy() throws Exception {	
		System.out.println("springUtils工具类清除注入的applicationContext");
		SpringUtils.applicationContext = null;
	}

	@Override
	public void setApplicationContext(ApplicationContext applicationContext)
			throws BeansException {
		logger.info("springUtils工具类注入的applicationContex: {}",applicationContext);
		SpringUtils.applicationContext = applicationContext;
	}
	
	/**
	 * 判断是否注入
	 * @return
	 */
	public static void isInjected(){
		if(SpringUtils.applicationContext == null){
			throw new RuntimeException("springUtils applicationContext is not injected!");
		}
	}

	public static void main(String[] args) {
		System.out.println(applicationContext);
	}
	

}
