package com.hyq.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

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
@Controller
@RequestMapping("/weixin")
public class WeiXinController{
	private Logger logger = Logger.getLogger(WeiXinController.class);
	@Autowired
	private UserService userService;
	
	
	@RequestMapping("/callback")
	public void callback(HttpServletRequest request,HttpServletResponse response){
		PrintWriter out = null;
		try{
			//授权获取code
			String code = request.getParameter("code");
			out = response.getWriter();
			if(StringUtil.isNotEmpty(code)){
				
				//通过code换取网页授权access_token
				String appId = SysUtils.getPropertyByName("wexin.appid");
				String appSecret = SysUtils.getPropertyByName("wexin.appSecret");
				logger.debug("获取到应用appid:"+appId);
				logger.debug("获取到应用appSecret:"+appSecret);
				
				//获取openid
				String url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid="+appId+"&secret="+appSecret+"&code="+code+"&grant_type=authorization_code";
				logger.debug("获取微信的acces_token票据:"+url);
				JSONObject token = JSONObject.fromObject(url);
				if(token.has("openid")){
					String openId = token.getString("openid");
					String access_token = token.getString("access_token");
					
					//拉取用户信息
					String getUserInfoUrl = "https://api.weixin.qq.com/sns/userinfo?access_token="+access_token+"&openid="+openId+"&lang=zh_CN";
					String uInfo = HttpUtils.doGet(getUserInfoUrl);
					JSONObject jsonUinfo = JSONObject.fromObject(uInfo);
					if(jsonUinfo.has("openid")){
						String open_id = token.getString("openid");
						String nickname = token.getString("nickname");
						String sex = token.getString("sex");
						String province = token.getString("province");
						String city = token.getString("city");
						String country = token.getString("country");
						String headimgurl = token.getString("headimgurl");
						String  unionid = "";
						if(jsonUinfo.has("unionid")){
							unionid = token.getString("unionid");
						}
						User user = new User();
						user.setAddress(province+city+country);
						user.setSex(sex);
						user.setNickname(nickname);
						user.setOther(headimgurl);
						user.setIdCardNumber(open_id);
						user.setEmail(unionid);
						userService.saveUser(user);
						
						logger.debug("微信登录成功!");
						request.setAttribute("id",user.getId());
						request.setAttribute("nickname",nickname);
						request.getRequestDispatcher("/login.action").forward(request, response);
						
					}else{
						String error_code = token.getString("errcode");
						String error_msg = token.getString("errmsg");
						request.setAttribute("message",error_code + "msg:-->"+error_msg);
						request.getRequestDispatcher("/noPrivilege.jsp").forward(request, response);
					}
				}else{
					String error_code = token.getString("errcode");
					String error_msg = token.getString("errmsg");
					request.setAttribute("message",error_code + "msg:-->"+error_msg);
					request.getRequestDispatcher("/noPrivilege.jsp").forward(request, response);
				}
				
				
			}else{
				request.setAttribute("message","没有授权微信同意登录");
				request.getRequestDispatcher("/noPrivilege.jsp").forward(request, response);
			}
		}catch(Exception e){
			
		}finally{
			if(out!=null){
				out.close();
			}
		}
	}
	

	/**
	 * 微信接口
	 * 
	 */
	@RequestMapping("/auth")
	public void auth(HttpServletRequest request,HttpServletResponse response) {
		  // 微信加密签名  
        String signature = request.getParameter("signature");  
        // 时间戳  
        String timestamp = request.getParameter("timestamp");  
        // 随机数  
        String nonce = request.getParameter("nonce");  
        // 随机字符串  
        String echostr = request.getParameter("echostr"); 
        PrintWriter out = null;
        try{
        	   out = response.getWriter();  
              // 通过检验signature对请求进行校验，若校验成功则原样返回echostr，表示接入成功，否则接入失败  
              if (WeiXinUtils.checkSignature(signature, timestamp, nonce)) {  
                  out.print(echostr);  
              }else{
            	  logger.error("校验失败!");
              } 
        }catch (Exception e) {
        	logger.error(e.getMessage(),e);
		}finally{
			if(out!=null){
				out.close();
			}
			
		}
       
	}


}
