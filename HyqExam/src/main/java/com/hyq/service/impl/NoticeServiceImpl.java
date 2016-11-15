package com.hyq.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hyq.domain.Notice;
import com.hyq.mapper.NoticeMapper;
import com.hyq.service.NoticeService;
import com.hyq.vo.NoticeMoveVo;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeMapper noticeMapper;
	
	@Override
	public Integer saveNotice(Notice notice) {
		return noticeMapper.saveNotice(notice);
	}

	@Override
	public List<Notice> findByMap(Map<String, Object> map) {
		return noticeMapper.findByMap(map);
	}

	@Override
	public int getTotalRecord() {
		return noticeMapper.findTotalRecord();
	}

	@Override
	public Notice findById(Integer id) {
		return noticeMapper.getById(id);
	}

	@Override
	public Integer updateNotice(Notice notice) {
		return noticeMapper.updateNotice(notice);
	}

	@Override
	public void deleteById(Integer id) {
		noticeMapper.deleteById(id);
	}

	@Override
	public List<Notice> findAll() {
		return noticeMapper.getAll();
	}

	@Override
	public Notice findByPosition(Integer i) {
		return noticeMapper.findByPosition(i);
	}

	@Override
	public Integer updatePositionById(NoticeMoveVo vo) {
		return noticeMapper.updatePositionById(vo);
	}

	@Override
	public Integer getMaxPosition() {
		return noticeMapper.getMaxPosition();
	}

}
