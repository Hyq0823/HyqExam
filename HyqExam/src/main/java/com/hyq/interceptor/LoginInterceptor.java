package com.hyq.interceptor;

import java.io.InputStream;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.ibatis.io.Resources;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.hyq.domain.User;
import com.hyq.util.XMLUtil;

/**
 * 拦截 没有 配置在public.xml文件中的url路径
 * @author HYQ
 * public.xml中配置的是 不用登录就能访问的路径。
 *
 */
public class LoginInterceptor implements HandlerInterceptor {
	private Logger logger = Logger.getLogger(LoginInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {

		// return false表示拦截，不向下执行
		// return true表示放行
		// Hyq_Exam/foreground/main.action
		
		//首先判断是否已经登录，如果是 直接放行
		User user = (User) request.getSession().getAttribute("currentUser");
		if(user !=null)
		{
			logger.debug("已经登录!登录拦截器直接放行!请求url"+request.getRequestURI());
			return true;
		}
		
		
		String uri = request.getRequestURI();
		String realUri = "";

		// 如果带有? 则先去掉问号
		int questionPoint = uri.indexOf("?");
		if (questionPoint > -1) {
			uri = uri.substring(0, questionPoint);
		}

		// 去掉.action
		int pointPos = uri.indexOf(".action");
		if (pointPos > -1) {
			uri = uri.substring(0, pointPos);
		}

		// 去掉项目名
		String root = request.getContextPath();
		if (uri.indexOf(root) > -1) {
			 realUri = uri.substring(root.length());
		}
		
		// 查询配置文件的所有公共的uri
		InputStream in = Resources.getResourceAsStream("config/public.xml");
		Set<String> urlSets = XMLUtil.getPublicUrlNodeList(in);
		
		// 匹配 则放行
		if(urlSets.contains(realUri)){
			logger.debug("配置文件url匹配到"+realUri+"放行!");
			return true;
		}else //否则就让其去登录
		{
			logger.debug("配置文件url没有匹配到"+realUri+"拦截!");
			request.getRequestDispatcher("/loginUI.action").forward(request, response);
			return false;
		}

		// 如果是去登录则放行，否则往下

		// 查找出所有需要登录后才能执行的模块

		// 判断当前这个路径是否是在这些模块中。

	}

	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

	}

	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {

	}

}
