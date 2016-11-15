package com.hyq.util;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

/**
 * reponse工具类
 * @author HYQ
 *
 */
public class ResponseUtil {
	public static void write2Brower(HttpServletResponse response,Object o) throws Exception
	{
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out=response.getWriter();
		out.println(o.toString());
		out.flush();
		out.close();
	}

}
