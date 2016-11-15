package com.hyq.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hyq.domain.Message;
import com.hyq.domain.User;
import com.hyq.service.MessageService;
import com.hyq.service.RoleService;
import com.hyq.service.UserService;
import com.hyq.util.ResponseUtil;
import com.hyq.vo.MessageVO;
import com.hyq.vo.MessageVO2;
import com.hyq.vo.MessageVo3;

@Controller
@RequestMapping("/message")
public class MessageController {
	private Logger logger = Logger.getLogger(MessageController.class);

	@Autowired
	private UserService userService;

	@Autowired
	private MessageService messageService;
	
	@Autowired
	private RoleService roleService;

	/**
	 * 显示在线人员列表
	 * 
	 * @param response
	 * @param session
	 * @throws Exception
	 */
	@RequestMapping("/onlineList")
	public void onlineList(HttpServletResponse response, HttpSession session)
			throws Exception {
		JSONObject result = new JSONObject();
		List<User> onlineUserList = (List<User>) session.getServletContext()
				.getAttribute("onlineUserList");
		User user = (User) session.getAttribute("currentUser");
		if (user == null) {
			ResponseUtil.write2Brower(response,
					"<script>alert('请先登录!');</script>");
			return;
		}

		result.put("total", onlineUserList.size());
		result.put("rows", JSONArray.fromObject(onlineUserList));
		ResponseUtil.write2Brower(response, result);
	}

	/**
	 * 显示聊天界面
	 * 
	 * @return
	 */
	@RequestMapping("/chatUI")
	public ModelAndView chatUI(@RequestParam("uid") String[] userIds,
			HttpSession session) {
		List<User> accepterList = new ArrayList<User>();
		StringBuilder sb = new StringBuilder();
		// 封装数据
		for (int i = 0; i < userIds.length; i++) {
			User accepter = userService.getUseDetailrById(userIds[i]);
			accepterList.add(accepter);
			if (i == userIds.length - 1) {
				sb.append(userIds[i]);
			} else {
				sb.append(userIds[i] + ",");
			}
		}
		User sender = (User) session.getAttribute("currentUser");

		// 装载数据
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("accepterList", accepterList);
		modelAndView.addObject("userIds", sb);
		modelAndView.addObject("sender", sender);

		modelAndView.setViewName("admin/message/chatUI");
		return modelAndView;
	}

	/**
	 * 发送消息
	 * 
	 * @throws Exception
	 */
	@RequestMapping("/sendMsg")
	public void sendMsg(Message message, HttpServletResponse response)
			throws Exception {

		message.setSendTime(new SimpleDateFormat("yyy-hh-mm HH:mm:ss").format(
				new Date()).toString());
		message.setIsGet(false);

		String[] ids = message.getUserIds();
		for (int i = 0; i < ids.length; i++) {
			// 设置为不同的接受者
			message.setAccepter(new User(ids[i]));
			messageService.saveMessage(message);
		}
		ResponseUtil.write2Brower(response, true);
	}

	/**
	 * 接受消息
	 * 
	 * @throws Exception
	 */
	@RequestMapping("/getMsg")
	public void getMsg(@RequestParam("myId") String accepterId,
			HttpServletResponse response) throws Exception {
		List<MessageVo3> messageList = messageService
				.getMyMessageByIdAndNotGet(accepterId);
		logger.info("获取我的消息 消息集合大小:"+messageList.size());

		if (messageList != null && messageList.size() > 0) {
			logger.info("写出消息给浏览器！");
			messageService.setIsGotStatus(accepterId);
			ResponseUtil.write2Brower(response,
					JSONArray.fromObject(messageList));
		} else {
			logger.info("没有我的消息，写出[无]");
			ResponseUtil.write2Brower(response, "[{content:'无'}]");
		}
	}

	/**
	 * 后台-实时监测是否有消息
	 * 
	 * @throws Exception
	 */
	@RequestMapping("/checkMyMsg")
	public void checkMyMsg(@RequestParam("id") String id,
			HttpServletResponse response) throws Exception {
		// 获取消息的数量
		Integer messageCount = messageService.getMyMessageTotalCount(id);
		ResponseUtil.write2Brower(response, messageCount);
	}

	/**
	 * 我的消息列表
	 */
	@RequestMapping("/myMsgList")
	public ModelAndView myMsgList(@RequestParam("id") String accepterId) {
		// 查询消息
		List<Message> msgList = messageService.getMyMessage(accepterId);

		// 设置为已读
		messageService.setIsGotStatus(accepterId);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("msgList", msgList);
		modelAndView.setViewName("admin/message/myMsgList");
		return modelAndView;
	}

	/**
	 * 前台给管理员发送消息
	 * @throws Exception
	 */
	@RequestMapping("/sendMsgToAdmin")
	public void sendMsgToAdmin(@RequestParam("msg") String msg,
			@RequestParam("sendId") String sendId,
			HttpServletResponse response,
			@RequestParam("adminId") String adminId) throws Exception {
		// 在前台列出所有的管理员，用户点击发送后到这个方法
		// String accepterId = "8201945c-1ef0-11e6-ba54-5cf9dd5e9d93";
		messageService.sendMsgToAdmin(msg, adminId, sendId);
		ResponseUtil.write2Brower(response, true);
	}

	/**
	 * 前台--发送站内信页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/sendMsgUI")
	public String sendMsgUI(HttpSession session, HttpServletResponse response,
			HttpServletRequest request) throws Exception {


		// 查询出所有的管理员 ---后期改为从角色表中查询出来--可能是多个
		String adminId = "8201945c-1ef0-11e6-ba54-5cf9dd5e9d93";
		 List<User> admins = roleService.getAllAdminList();
		User admin = userService.getUseDetailrById(adminId);
		request.setAttribute("admins", admins);


		// 查询出我的所有消息
		//List<Message> readedMsgList = messageService
	//			.getMessageByIdAndIsGot(user.getId());
	//	request.setAttribute("readedMsgList", readedMsgList);
		return "foreground/message/chatUI";

	}

	/**
	 * 
	 * @param me
	 *            我的id
	 * @param you
	 *            对方的id 我要接收对方发给我的历史消息(已读的) 一对一
	 * @throws Exception
	 * 
	 */
	@RequestMapping("/getMyReadedMsgByOnePerson")
	public void getMyReadedMsgByOnePerson(@RequestParam("me") String me,
			@RequestParam("you") String you, HttpServletResponse response)
			throws Exception {
		MessageVO vo = new MessageVO(me, you);
		
		//只需要发送时间、发送内容就行了
		List<MessageVO2> msgList = messageService.getOne2OneMsg(vo);
		
		if (msgList != null && msgList.size() > 0) {
			ResponseUtil.write2Brower(response, JSONArray.fromObject(msgList));
		} else {
			ResponseUtil.write2Brower(response, "[{content:'无'}]");
		}
	}

}
