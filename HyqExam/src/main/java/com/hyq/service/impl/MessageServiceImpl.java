package com.hyq.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hyq.domain.Message;
import com.hyq.domain.User;
import com.hyq.mapper.MessageMapper;
import com.hyq.service.MessageService;
import com.hyq.vo.MessageVO;
import com.hyq.vo.MessageVO2;
import com.hyq.vo.MessageVo3;
@Service
public class MessageServiceImpl implements MessageService 
{
	@Autowired
	private MessageMapper messageMapper;

	@Override
	public void saveMessage(Message message) {
		messageMapper.saveMessage(message);
	}
	
	

	@Override
	public List<MessageVo3> getMyMessageByIdAndNotGet(String accepterId) {
		return messageMapper.getMyMessageByIdAndNotGet(accepterId);
	}

	@Override
	public void setIsGotStatus(String accepterId) {
		messageMapper.setIsGotStatus(accepterId);
	}

	@Override
	public Integer getMyMessageTotalCount(String id) {
		if(id==null || "".equals(id))
		{
			return 0;
		}else
		{
			return messageMapper.getMyMessageTotalCount(id);
		}
	}

	@Override
	public List<Message> getMyMessage(String accepterId) {
		return messageMapper.getMyMessage(accepterId);
	}

	@Override
	public void sendMsgToAdmin(String msg, String accepterId, String sendId) {
		Message message = new Message();
		//封装消息
		message.setSender(new User(sendId));
		message.setAccepter(new User(accepterId));
		message.setContent(msg);
		message.setSendTime(new SimpleDateFormat("yyyy-mm-dd HH:mm:ss").format(new Date()));
		message.setIsGet(false);
		
		messageMapper.saveMessage(message);
	}

	@Override
	public List<Message> getMessageByIdAndIsGot(String id) {
		return messageMapper.getMessageByIdAndIsGot(id);
	}

	@Override
	public List<MessageVO2> getOne2OneMsg(MessageVO vo) {
		return messageMapper.getOne2OneMsg(vo);
	}



}
