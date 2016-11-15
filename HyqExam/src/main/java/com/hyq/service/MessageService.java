package com.hyq.service;

import java.util.List;

import com.hyq.domain.Message;
import com.hyq.vo.MessageVO;
import com.hyq.vo.MessageVO2;
import com.hyq.vo.MessageVo3;

public interface MessageService {

	void saveMessage(Message message);

	List<MessageVo3> getMyMessageByIdAndNotGet(String accepterId);

	void setIsGotStatus(String accepterId);

	Integer getMyMessageTotalCount(String id);
	
	List<Message> getMyMessage(String accepterId);

	void sendMsgToAdmin(String msg, String accepterId, String sendId);

	/**
	 * 获取已读的所有消息
	 * @param accepterId 接受者id
	 * @return
	 */
	List<Message> getMessageByIdAndIsGot(String accepterId);

	/**
	 * 一对一的消息列表
	 * @param me
	 * @param you
	 * @return
	 */
	List<MessageVO2> getOne2OneMsg(MessageVO vo);

}
