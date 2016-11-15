package com.hyq.util;

import java.util.UUID;

/**
 * UUID工具类
 * @author HYQ
 *
 */
public class UUIDUtil {
	/**
	 * 获取一个uuid
	 * @return
	 */
	public static String getUUID()
	{
		return UUID.randomUUID().toString();
	}

}
