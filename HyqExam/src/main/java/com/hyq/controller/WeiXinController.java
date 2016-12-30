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
public class WeiXinController{
	private Logger logger = Logger.getLogger(WeiXinController.class);
	@Autowired
	private UserService userService;
	
	
	@RequestMapping("/callback")
	public String callback(HttpServletRequest request,HttpServletResponse response) throws Exception{
			//授权获取code
			String code = request.getParameter("code");
			if(StringUtil.isNotEmpty(code)){
				
				//通过code换取网页授权access_token
				String appId = SysUtils.getPropertyByName("wexin.appid");
				String appSecret = SysUtils.getPropertyByName("wexin.appSecret");
				logger.debug("获取到应用appid:"+appId);
				logger.debug("获取到应用appSecret:"+appSecret);
				
				//获取openid
				String url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid="+appId+"&secret="+appSecret+"&code="+code+"&grant_type=authorization_code";
				
				logger.debug("获取微信的acces_token票据url:"+url);
				String access_data = HttpUtils.doGet(url);
				
				logger.info("通过code换取的结果 :"+access_data);
				
				JSONObject token = JSONObject.fromObject(access_data);
				if(token.has("openid")){
					String openId = token.getString("openid");
					String access_token = token.getString("access_token");
					
					//拉取用户信息
					String getUserInfoUrl = "https://api.weixin.qq.com/sns/userinfo?access_token="+access_token+"&openid="+openId+"&lang=zh_CN";
					String uInfo = HttpUtils.doGet(getUserInfoUrl);
					
					//解决微信返回用户信息乱码
					uInfo = new String(uInfo.getBytes("iso-8859-1"),"utf-8");
					
					JSONObject jsonUinfo = JSONObject.fromObject(uInfo);
					logger.info("拉取用户信息响应结果： "+jsonUinfo);
					
					if(jsonUinfo.has("openid")){
						String open_id = jsonUinfo.getString("openid");
						String nickname = jsonUinfo.getString("nickname");
						int sex = jsonUinfo.getInt("sex");
						String province = jsonUinfo.getString("province");
						String city = jsonUinfo.getString("city");
						String country = jsonUinfo.getString("country");
						String headimgurl = jsonUinfo.getString("headimgurl");
						String  unionid = "";
						if(jsonUinfo.has("unionid")){
							unionid = token.getString("unionid");
						}
						User user = new User();
						user.setAddress(province+city+country);
						user.setSex(sex+"");
						user.setNickname(nickname);
						user.setOther(headimgurl);
						user.setIdCardNumber(open_id);
						user.setEmail(unionid);
						
						//userService.saveUser(user);
						
						logger.info("拉取用户信息 : "+user.toString());
						logger.debug("微信登录成功!");
//						request.setAttribute("id",user.getId());
//						request.setAttribute("nickname",nickname);
						request.getSession().setAttribute("currentUser",user);
						//跳转页面
						return "foreground/home";
						
					}else{
						String error_code = token.getString("errcode");
						String error_msg = token.getString("errmsg");
						request.setAttribute("message",error_code + "msg:-->"+error_msg);
						return "noPrivilege";
					}
				}else{
					String error_code = token.getString("errcode");
					String error_msg = token.getString("errmsg");
					request.setAttribute("message",error_code + "msg:-->"+error_msg);
					return "noPrivilege";
				}
				
				
			}else{
				request.setAttribute("message","没有授权微信同意登录");
				return "noPrivilege";
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
                  logger.info("校验成功！返回："+echostr);
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
