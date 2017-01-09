package com.hyq.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import net.sf.json.JSONObject;

public class WeiXinUtils {
	 // 与接口配置信息中的Token要一致
    private static String token = "hyq";
    
   private static  String appId = SysUtils.getPropertyByName("wexin.appid");
   private static String appSecret = SysUtils.getPropertyByName("wexin.appSecret");
	
    /**
     * 验证签名
     * 
     * @param signature
     * @param timestamp
     * @param nonce
     * @return
     */
    public static boolean checkSignature(String signature, String timestamp,
            String nonce) {
        String[] arr = new String[] { token, timestamp, nonce };
        // 将token、timestamp、nonce三个参数进行字典序排序
        //Arrays.sort(arr);
        sort(arr);
        StringBuilder content = new StringBuilder();
        for (int i = 0; i < arr.length; i++) {
            content.append(arr[i]);
        }
        MessageDigest md = null;
        String tmpStr = null;

        try {
            md = MessageDigest.getInstance("SHA-1");
            // 将三个参数字符串拼接成一个字符串进行sha1加密
            byte[] digest = md.digest(content.toString().getBytes());
            tmpStr = byteToStr(digest);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        content = null;
        // 将sha1加密后的字符串可与signature对比，标识该请求来源于微信
        return tmpStr != null ? tmpStr.equals(signature.toUpperCase()) : false;
    }

    /**
     * 将字节数组转换为十六进制字符串
     * 
     * @param byteArray
     * @return
     */
    private static String byteToStr(byte[] byteArray) {
        String strDigest = "";
        for (int i = 0; i < byteArray.length; i++) {
            strDigest += byteToHexStr(byteArray[i]);
        }
        return strDigest;
    }

    /**
     * 将字节转换为十六进制字符串
     * 
     * @param mByte
     * @return
     */
    private static String byteToHexStr(byte mByte) {
        char[] Digit = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A',
                'B', 'C', 'D', 'E', 'F' };
        char[] tempArr = new char[2];
        tempArr[0] = Digit[(mByte >>> 4) & 0X0F];
        tempArr[1] = Digit[mByte & 0X0F];

        String s = new String(tempArr);
        return s;
    }

    public static void sort(String a[]) {
        for (int i = 0; i < a.length - 1; i++) {
            for (int j = i + 1; j < a.length; j++) {
                if (a[j].compareTo(a[i]) < 0) {
                    String temp = a[i];
                    a[i] = a[j];
                    a[j] = temp;
                }
            }
        }
    }

    /**
     * 通过code换取票据
     * @param code
     * @return
     * @throws Exception
     */
	public static JSONObject code4AccessToken(String code) throws Exception {
		//获取openid
		String url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid="+appId+"&secret="+appSecret+"&code="+code+"&grant_type=authorization_code";
//		logger.debug("获取微信的acces_token票据url:"+url);
		String access_data = HttpUtils.doGet(url);
//		logger.info("通过code换取的结果 :"+access_data);
		return JSONObject.fromObject(access_data);
	}

	/**
	 * 通过access_token和用户openid拉取用户信息
	 * @param access_token
	 * @param openId
	 * @return
	 * @throws Exception
	 */
	public static JSONObject tokenAndOpenId4UserInfo(String access_token, String openId) throws Exception {
		//拉取用户信息
		String getUserInfoUrl = "https://api.weixin.qq.com/sns/userinfo?access_token="+access_token+"&openid="+openId+"&lang=zh_CN";
		String uInfo = HttpUtils.doGet(getUserInfoUrl);
		//解决微信返回用户信息乱码
		uInfo = new String(uInfo.getBytes("iso-8859-1"),"utf-8");
		return JSONObject.fromObject(uInfo);
	}
}
