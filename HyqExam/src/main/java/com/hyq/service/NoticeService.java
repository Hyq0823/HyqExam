package com.hyq.service;

import java.util.List;
import java.util.Map;

import com.hyq.domain.Notice;
import com.hyq.vo.NoticeMoveVo;



public interface NoticeService {

	/**
	 * 保存--公告
	 * @param notice
	 */
	Integer saveNotice(Notice notice);

	/**
	 * 按条件列出公告
	 * @return
	 */
	List<Notice> findByMap(Map<String, Object> map);

	/**
	 * 获取公告的总记录数
	 * @return
	 */
	int getTotalRecord();

	Notice findById(Integer id);

	Integer updateNotice(Notice notice);

	void deleteById(Integer i);

	List<Notice> findAll();

	Notice findByPosition(Integer i);

	Integer updatePositionById(NoticeMoveVo vo);

	Integer getMaxPosition();



}
