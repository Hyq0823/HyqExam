package com.hyq.util;

import com.hyq.domain.Apply;

public class ApplyUtil {
	
	/**
	 * 
	 * @param isHandConfirm 传入 yes 或者no
	 * @return
	 */
	public static String checkStatus(String isHandConfirm)
	{
		if(isHandConfirm!=null)
		{
			if("no".equals(isHandConfirm))
			{
				return Apply.PASS;
			}else if("yes".equals(isHandConfirm))
			{
				return Apply.STANDBY_ENSURE;
			}
		}
		
		//如果传入参数为空或者不是no或yes，就失败
		return Apply.FAIL;
	}

}
