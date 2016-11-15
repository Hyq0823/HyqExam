package com.hyq.mapper;

import java.util.List;
import java.util.Map;

import com.hyq.domain.Notice;
import com.hyq.vo.NoticeMoveVo;



public interface NoticeMapper {
	public Integer saveNotice(Notice notice);

	public int findTotalRecord();

	public List<Notice> findByMap(Map<String, Object> map);

	public Notice getById(Integer id);

	public Integer updateNotice(Notice notice);

	public void deleteById(Integer id);

	public List<Notice> getAll();

	public Notice findByPosition(Integer i);

	public Integer updatePositionById(NoticeMoveVo vo);

	public Integer getMaxPosition();
	
	
	

}
