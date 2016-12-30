package com.hyq.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hyq.domain.Notice;
import com.hyq.domain.Page;
import com.hyq.domain.User;
import com.hyq.service.ApplyService;
import com.hyq.service.NoticeService;
import com.hyq.service.RoleService;
import com.hyq.service.UserService;
import com.hyq.util.ResponseUtil;
import com.hyq.util.UUIDUtil;
import com.hyq.vo.ResumeVo;
import com.hyq.vo.UserRole2;
import com.hyq.vo.User_Role;
import org.apache.log4j.Logger;
@Controller
public class UserController{
	@Autowired
	private UserService userService;
	@Autowired
	private ApplyService applyService;
	@Autowired
	private NoticeService noticeService;
	@Autowired
	private RoleService roleService;
	
	private Logger logger = Logger.getLogger(UserController.class);

	/**
	 * 进入用户管理界面
	 */
	@RequestMapping("/user/listAllUsersUI")
	public String listAllUsersUI() {
		return "admin/user/userManage";
	}
	
	/**
	 *管理员从后台添加一个用户
	 * @throws Exception 
	 */
	@RequestMapping("/user/addUserByAdmin")
	public void addUserByAdmin(User user,HttpServletResponse response) throws Exception{
		userService.saveInfoByAdmin(user);
		ResponseUtil.write2Brower(response, true);
	}
	
	
	/**
	 * 根据ids删除多条记录
	 * @throws Exception 
	 */
	@RequestMapping("/user/deleteByIds")
	public void deleteByIds(@RequestParam(value="ids",required=true)String ids,HttpServletResponse response) throws Exception{
		String[] idArr = ids.split(",");
		for(int i=0;i<idArr.length;i++){
			userService.deleteById(idArr[i]);
		}
		ResponseUtil.write2Brower(response,true);
	}

	/**
	 * 后台用户管理---列出用户表中 所有的用户
	 * 
	 * @throws Exception
	 */
	@RequestMapping("/user/listAllUsers")
	public void listAllUsers(
			@RequestParam("page") Integer page,
			@RequestParam("rows") Integer rows,
			@RequestParam(value = "roleId", required = false) Integer roleId, // 可选的两个查询条件
			@RequestParam(value = "truename", required = false) String truename,
			HttpServletResponse response) throws Exception {

		// 构造分页bean
		Integer totalRecord = null;
		Map<String, Integer> map = new HashMap<String, Integer>();
		List<User> userList = null;

		//根据是否有查询条件来查询数据
		if (roleId == null && truename == null) {
			totalRecord = userService.getTotalRecord();
		} else {
			UserRole2 role = new UserRole2(roleId, truename);
			userList = userService.getTotalRecordByRoleVo(role);
			totalRecord = userList.size();
		}

		// 封装数据
		Page pageBean = new Page(page, rows, totalRecord);
		map.put("startIndex", pageBean.getStartIndex());
		map.put("pageSize", pageBean.getPageSize());

		//如果没条件，就只是分页查询
		if (userList == null) {
			userList = userService.findByMap(map);
		}
		//构造结果
		JSONObject result = new JSONObject();
		result.put("rows", JSONArray.fromObject(userList));
		result.put("total", totalRecord);
		ResponseUtil.write2Brower(response, result);
	}

	/**
	 * 处理后台-添加角色 和 更新用户基本信息
	 * 
	 * @throws Exception
	 */
	@RequestMapping("/user/eidtUserInfoAndAssitRole")
	public void eidtUserInfoAndAssitRole(User_Role user_role,
			HttpServletResponse response) throws Exception {
		// 更新用户基本信息
		userService.updateUserBaseInfo(user_role);

		// 为用户授予角色
		roleService.setUserRole(user_role);

		// 返回成功结果
		ResponseUtil.write2Brower(response, true);
	}

	/**
	 * 处理后台- 更新角色和 用户基本信息
	 * 
	 * @throws Exception
	 */
	@RequestMapping("/user/eidtUserInfoAndUpdateRole")
	public String eidtUserInfoAndUpdateRole(User_Role user_role,
			HttpServletResponse response) throws Exception {
		// 更新用户基本信息
		userService.updateUserBaseInfo(user_role);

		// 为用户修改角色
		roleService.updateUserRole(user_role);

		// 返回成功结果
		//ResponseUtil.write2Brower(response, true);
		
		 return "admin/user/userManage";
		//TODO
	}

	/**
	 * 处理注册UI请求
	 * 
	 * @return
	 */
	@RequestMapping("/registerUI")
	public ModelAndView registerUI(HttpSession session) {
		// 生成uuid存入session
		session.setAttribute("token", UUIDUtil.getUUID());

		// 转发
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("foreground/registerUI");
		return modelAndView;

	}

	/**
	 * 处理注册请求
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/register")
	// @RequestParam(required=true) User user
	public String register(HttpSession session, HttpServletRequest request,
			@RequestParam(required = true) String formtoken, User user)
			throws Exception {
		// 判断是否是重复提交
		String sessionToken = (String) session.getAttribute("token");
		if (!formtoken.equals(sessionToken)) {
			request.setAttribute("message", "请勿重复提交！");
			return "message";
		}

		// 进行非法过滤

		// 存储用户
		userService.saveUser(user);

		// 清除session 中的token
		session.setAttribute("token", null);
		return "foreground/registerResult";

	}

	/**
	 * 处理登录UI请求
	 * 
	 * @return
	 */
	@RequestMapping("/loginUI")
	public ModelAndView loginUI(HttpSession session) {
		// 生成uuid存入session
		session.setAttribute("token", UUIDUtil.getUUID());

		// 转发
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("foreground/loginUI");
		return modelAndView;

	}

	/**
	 * 处理登录请求
	 * 
	 * @return
	 * @throws Exception
	 */
	// TODO 如何封装数据 如何过滤数据
	@RequestMapping("/login")
	public String login(HttpSession session, HttpServletRequest request,
			HttpServletResponse response, String formtoken, User user)
			throws Exception {
	    
	  logger.debug("登录请求 ： "+user);
	    
		// 判断是否是重复提交
		String sessionToken = (String) session.getAttribute("token");
		if (formtoken != null && !formtoken.equals(sessionToken)) {
			session.setAttribute("message", "请勿重复提交！");
		}

		// 登录用户
		User currentUser = userService.findUser(user);
		if (currentUser == null) {
			request.setAttribute("error", "用户名或密码错误!");
			request.setAttribute("user", user);
			return "forward:loginUI.action";
		}

		// 清除session 中的token
		session.setAttribute("token", null);
		session.setAttribute("currentUser", currentUser);

		// 把user存储在最大的作用域中
		@SuppressWarnings("unchecked")
		List<User> onlineList = (List<User>) session.getServletContext()
				.getAttribute("onlineUserList");
		if (onlineList == null) {
			onlineList = new ArrayList<User>();
		}
		// 把当前用户加入在线人员列表中。
		if (!onlineList.contains(currentUser)) {
			onlineList.add(currentUser);
			session.getServletContext().setAttribute("onlineUserList",
					onlineList);
		}
		// request.getRequestDispatcher("/WEB-INF/jsp/foreground/home.jsp").forward(request,
		// response);
		return "redirect:foreground/main.action";

	}

	/**
	 * 跳转 前台首页
	 * 
	 * @return
	 */

	@RequestMapping("/foreground/main")
	public String ToForeMain(HttpServletRequest request) {
		List<Notice> noticeList = noticeService.findAll();
		request.setAttribute("noticeList", noticeList);
		// 查询内容
		System.out.println("前台---去首页");
		return "forward:/index.jsp";
	}

	/**
	 * 处理注销请求
	 * 
	 * @return
	 */
	@RequestMapping("/logout")
	@SuppressWarnings("unchecked")
	public String logout(HttpSession session) {
		User currentUser = (User) session.getAttribute("currentUser");
		List<User> onlineList = (List<User>) session.getServletContext()
				.getAttribute("onlineUserList");

		if (onlineList != null && onlineList.size() > 0
				&& onlineList.contains(currentUser)) {
			onlineList.remove(currentUser);
			session.getServletContext().setAttribute("onlineUserList",
					onlineList);
		}

		session.invalidate();
		return "foreground/home";
	}

	/**
	 * 处理-查看用户详细信息
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/userInfo")
	public String userInfo(HttpSession session) throws Exception {
		User user = (User) session.getAttribute("currentUser");
		// 获取用户的详细信息
		user = userService.getUserDetailInfo(user);

		session.setAttribute("currentUser", user);
		return "foreground/user/userInfo";
	}

	/**
	 * 前台——用户基本详细信息
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/base")
	public void DetailBaseInfo(User user, HttpServletResponse response,
			HttpSession session) throws Exception {
		try {
			User u = (User) session.getAttribute("currentUser");
			user.setId(u.getId());
			userService.saveBaseInfo(user);

			ResponseUtil.write2Brower(response, "保存信息成功!");
		} catch (Exception e) {
			ResponseUtil.write2Brower(response, "保存信息失败!");
			e.printStackTrace();
		}
	}

	/**
	 * 前台——用户教育信息
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/edu")
	public void DetailEduInfo(
			@RequestParam(value = "eduData", required = true) String data,
			HttpServletResponse response, HttpSession session) throws Exception {
		try {
			User user = (User) session.getAttribute("currentUser");
			if (user == null) {
				// 后面采用拦截来处理
				ResponseUtil.write2Brower(response, "您尚未登录!");
				return;
			}
			user.setEducation(data);
			userService.saveBaseInfo(user);
			ResponseUtil.write2Brower(response, "保存信息成功!");

			// 再把数据带过去，页面作为显示
		} catch (Exception e) {
			ResponseUtil.write2Brower(response, "保存信息失败!");
			e.printStackTrace();
		}
	}

	/**
	 * 前台——用户教育信息
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/exp")
	public void DetailExpInfo(
			@RequestParam(value = "exp", required = true) String exp,
			HttpServletResponse response, HttpSession session) throws Exception {
		try {
			User user = (User) session.getAttribute("currentUser");
			if (user == null) {
				// 后面采用拦截来处理
				ResponseUtil.write2Brower(response, "您尚未登录!");
				return;
			}
			// 保存职位经历
			user.setEmplore(exp);
			userService.saveBaseInfo(user);
			ResponseUtil.write2Brower(response, "保存信息成功!");

			// 再把数据带过去，页面作为显示
		} catch (Exception e) {
			ResponseUtil.write2Brower(response, "保存信息失败!");
			e.printStackTrace();
		}
	}

	/**
	 * 前台——用户医疗执业资格
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/doc")
	public void DetailDocInfo(
			@RequestParam(value = "doc", required = true) String doc,
			HttpServletResponse response, HttpSession session) throws Exception {
		try {
			User user = (User) session.getAttribute("currentUser");
			if (user == null) {
				// 后面采用拦截来处理
				ResponseUtil.write2Brower(response, "您尚未登录!");
				return;
			}
			// 保存职位经历
			user.setDoctorInfo(doc);
			userService.saveBaseInfo(user);
			ResponseUtil.write2Brower(response, "保存执业信息成功!");

			// 再把数据带过去，页面作为显示
		} catch (Exception e) {
			ResponseUtil.write2Brower(response, "保存信息失败!");
			e.printStackTrace();
		}
	}

	/**
	 * 前台——其他想说的
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/other")
	public void DetailOtherInfo(
			@RequestParam(value = "other", required = true) String other,
			HttpServletResponse response, HttpSession session) throws Exception {
		try {
			User user = (User) session.getAttribute("currentUser");
			if (user == null) {
				// 后面采用拦截来处理
				ResponseUtil.write2Brower(response, "您尚未登录!");
				return;
			}
			// 保存其他想说的
			user.setOther(other);
			userService.saveBaseInfo(user);
			ResponseUtil.write2Brower(response, "保存信息成功!");

			// 再把数据带过去，页面作为显示
		} catch (Exception e) {
			ResponseUtil.write2Brower(response, "保存信息失败!");
			e.printStackTrace();
		}
	}

	// ================================后台============================================================

	/**
	 * 处理后台登录UI请求
	 * 
	 * @return
	 */
	@RequestMapping("/background/loginRequest")
	public ModelAndView BackgroundLoginRequest(HttpSession session) {
		// 生成uuid存入session
		session.setAttribute("token", UUIDUtil.getUUID());

		// 转发
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("admin/adminLoginUI");
		return modelAndView;
	}

	/**
	 * 处理后台管理员登录请求
	 * 
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	// TODO 如何封装数据 如何过滤数据
	@RequestMapping("/loginAdmin")
	public String loginAdmin(HttpSession session, HttpServletRequest request,
			HttpServletResponse response, String formtoken, User user)
			throws Exception {
		// 判断是否是重复提交
		String sessionToken = (String) session.getAttribute("token");
		if (formtoken != null && !formtoken.equals(sessionToken)) {
			request.setAttribute("message", "请勿重复提交！");
			return "message";
		}

		// 登录用户
		User currentUser = userService.findUser(user);
		if (currentUser == null) {
			request.setAttribute("error", "用户名或密码错误!");
			request.setAttribute("user", user);
			return "admin/adminLoginUI";
		}

		// 清除session 中的token
		session.setAttribute("token", null);
		session.setAttribute("currentUser", currentUser);

		// 把user存储在最大的作用域中
		List<User> onlineList = (List<User>) session.getServletContext()
				.getAttribute("onlineUserList");
		if (onlineList == null) {
			onlineList = new ArrayList<User>();
		}
		// 把当前用户加入在线人员列表中。
		if (!onlineList.contains(currentUser)) {
			onlineList.add(currentUser);
			session.getServletContext().setAttribute("onlineUserList",
					onlineList);
		}

		return "redirect:/Background/home.action";

	}

	/**
	 * 跳转首页
	 * 
	 * @return
	 */

	@RequestMapping("/Background/home")
	public String ToMain() {
		// 查询内容
		System.out.println("后台---去首页");
		return "admin/main";
	}

	/**
	 * 审核考生时，点击用户简历
	 * 
	 * @param userId
	 *            -- 用于查询用户的详细信息
	 * @param applyId
	 *            用于计算上下一个简历
	 * @param infoId
	 *            用于计算上下一个简历
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/userResume")
	public ModelAndView userResume(@RequestParam("uid") String userId,
			@RequestParam("aid") Integer applyId,
			@RequestParam("infoId") Integer infoId, HttpServletResponse response)
			throws Exception {
		if (userId == null || "".equals(userId)) {
			System.out.println("无效的参数");
		}
		// 构造vo
		ResumeVo resumeVo = new ResumeVo(userId, applyId, infoId);

		// 查询上一个 和下一个 如果是第一个或最后一个，查询出来是null
		String beforeUserId = applyService.findBeforeOne(resumeVo);
		String afterUserId = applyService.findAfterOne(resumeVo);

		// 通过user的id查询user的详细信息
		User user = userService.getUseDetailrById(userId);

		// 封装信息到model
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("admin/student/resume");
		modelAndView.addObject("user", user);

		// 封装下一个User的id和上一个user的id,如果没有就设置为null
		modelAndView.addObject("before", beforeUserId);
		modelAndView.addObject("after", afterUserId);

		modelAndView.addObject("applyId", applyId);
		modelAndView.addObject("infoId", infoId);

		// 跳转到用户简历的审核界面界面
		return modelAndView;
	}

}
