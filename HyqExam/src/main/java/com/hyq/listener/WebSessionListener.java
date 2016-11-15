package com.hyq.listener;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.log4j.Logger;

/**
 * session的监听
 * 
 * @author HYQ
 * 
 */
public class WebSessionListener implements HttpSessionListener {

	private static Logger logger = Logger.getLogger(WebSessionListener.class);
	@Override
	public void sessionCreated(HttpSessionEvent se) {
		Integer count = (Integer) se.getSession().getServletContext()
				.getAttribute("userCount");
		if (count == null || "".equals(count)) {
			count = new Integer(1);
		} else {
			count = new Integer(count + 1);
		}
		
		logger.debug("创建session，当前人数"+count);
		se.getSession().getServletContext().setAttribute("userCount",count);

	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		Integer count = (Integer) se.getSession().getServletContext()
				.getAttribute("userCount");
		if(count!=null && count>0)
		{
			se.getSession().getServletContext().setAttribute("userCount",new Integer(count - 1));
			logger.info("销毁session，当前人数"+(count - 1));
		}
	}

}
