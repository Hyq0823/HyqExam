package com.hyq.interceptor;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.hyq.domain.Privilege;
import com.hyq.domain.User;
import com.hyq.service.PrivilegeService;

/**
 * 权限拦截器
 * @author HYQ
 * 因为要把权限拦截放在登录拦截后面，所以这个拦截的是已经登录了的请求
 *
 */
public class PrivilegeInterceptor implements HandlerInterceptor
{
	@Autowired
	private PrivilegeService privilegeService;

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		
		//ServletContext application = request.getServletContext();
	//	ApplicationContext ac =  WebApplicationContextUtils.getWebApplicationContext(application);
	//	PrivilegeService privilegeService = (PrivilegeService) ac.getBean("privilegeService");
	//
		System.out.println(privilegeService);
		
		//获取所有的  权限列表 AllPlist  ------------事先加载到application中 
		List<String> urls = privilegeService.getAllUrl();
		
		//获取当前访问路径，并做处理
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
		//如果不在 AllPlist中，说明这个路径不需要控制，放行
		if(!urls.contains(realUri))
		{
			return true;
		}else//else 在列表中，说明要控制
		{
			
			//获取当前用户
			User currentUser = (User) request.getSession().getAttribute("currentUser");
			//获取当前用户的  自身权限列表      ------------------这个也需要事先加载
			List<String> userUrls = privilegeService.getUsersPrivilegeUrlByUserId(currentUser.getId());
			
			//如果自身权限列表为空，则表示无权限
			if(userUrls == null || userUrls.size()<1)
			{
				response.sendRedirect(request.getContextPath()+"/noPrivilege.jsp");
				return false;
			}
			
			//判断当前访问的路径是否在权限列表中
			for(String url : userUrls)
			{
				//如果在，放行
				if(urls.contains(url))
				{
					return true;
				}else{//如果不在，拦截，跳转到没有权限页面
					response.sendRedirect("/noPrivilege.jsp");
					return false;
				}
			}
		}
		return true;
		
		
		

		
		
		
		//另一种 思考方式：
		//if(有权限)  放行
		//else 拦截
		
		//把逻辑减少到  只需要关系判断是否有权限就行了
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
