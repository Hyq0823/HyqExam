package com.hyq.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hyq.domain.User;
import com.hyq.service.UserService;
import com.hyq.util.HttpUtils;
import com.hyq.util.StringUtil;
import com.hyq.util.SysUtils;
import com.hyq.util.WeiXinUtils;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/weixin")
public class WeiXinController {
	private Logger logger = Logger.getLogger(WeiXinController.class);
	@Autowired
	private UserService userService;

	@RequestMapping("/callback")
	public String callback(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String code = request.getParameter("code");
		if (StringUtil.isNotEmpty(code)) {
			// 通过code换取网页授权access_token
			JSONObject token = WeiXinUtils.code4AccessToken(code);
			if (token.has("openid")) {
				String openId = token.getString("openid");
				String access_token = token.getString("access_token");
//				User weixin_user = userService.getUserByOpenId(openId);
				// 拉取用户信息
				JSONObject jsonUinfo = WeiXinUtils.tokenAndOpenId4UserInfo(access_token, openId);
				logger.info("拉取用户信息响应结果： " + jsonUinfo);
				User weixin_user  = (User) JSONObject.toBean(jsonUinfo, User.class);

				if (jsonUinfo.has("openid")) {
					String open_id = jsonUinfo.getString("openid");
					String nickname = jsonUinfo.getString("nickname");
					int sex = jsonUinfo.getInt("sex");
					String province = jsonUinfo.getString("province");
					String city = jsonUinfo.getString("city");
					String country = jsonUinfo.getString("country");
					String headimgurl = jsonUinfo.getString("headimgurl");
					String unionid = "";
					if (jsonUinfo.has("unionid")) {
						unionid = token.getString("unionid");
					}
					User user = new User();
					user.setAddress(province + city + country);
					user.setSex(sex + "");
					user.setNickname(nickname);
					user.setOther(headimgurl);
					user.setIdCardNumber(open_id);
					user.setEmail(unionid);

					// userService.saveUser(user);

					logger.info("拉取用户信息 : " + user.toString());
					logger.debug("微信登录成功!");
					// request.setAttribute("id",user.getId());
					// request.setAttribute("nickname",nickname);
					request.getSession().setAttribute("currentUser", user);
					// 跳转页面
					return "foreground/home";

				} else {
					String error_code = token.getString("errcode");
					String error_msg = token.getString("errmsg");
					request.setAttribute("message", error_code + "msg:-->" + error_msg);
					return "noPrivilege";
				}
			} else {
				String error_code = token.getString("errcode");
				String error_msg = token.getString("errmsg");
				request.setAttribute("message", error_code + "msg:-->" + error_msg);
				return "noPrivilege";
			}

		} else {
			request.setAttribute("message", "没有授权微信同意登录");
			return "noPrivilege";
		}
	}

	/**
	 * 微信接口
	 * 
	 */
	@RequestMapping("/auth")
	public void auth(HttpServletRequest request, HttpServletResponse response) {
		// 微信加密签名
		String signature = request.getParameter("signature");
		// 时间戳
		String timestamp = request.getParameter("timestamp");
		// 随机数
		String nonce = request.getParameter("nonce");
		// 随机字符串
		String echostr = request.getParameter("echostr");
		PrintWriter out = null;
		try {
			out = response.getWriter();
			// 通过检验signature对请求进行校验，若校验成功则原样返回echostr，表示接入成功，否则接入失败
			if (WeiXinUtils.checkSignature(signature, timestamp, nonce)) {
				logger.info("校验成功！返回：" + echostr);
				out.print(echostr);
			} else {
				logger.error("校验失败!");
			}
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		} finally {
			if (out != null) {
				out.close();
			}

		}

	}

}
