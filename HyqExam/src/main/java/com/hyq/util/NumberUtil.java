package com.hyq.util;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.hyq.domain.Privilege;

public class NumberUtil {

	/**
	 * 获取一个权限集合的id
	 * @param privileges
	 * @return
	 */
	public static Set<Integer> getIdsFromList(List<Privilege> privileges) {
		Set<Integer> sets = new HashSet<Integer>();
		for(Privilege p : privileges)
		{
			sets.add(p.getId());
		}
		return sets;
	}
	

}
