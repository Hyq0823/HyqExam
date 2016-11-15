package com.hyq.mapper;

import java.util.List;

import com.hyq.domain.Message;
import com.hyq.vo.MessageVO;
import com.hyq.vo.MessageVO2;
import com.hyq.vo.MessageVo3;

public interface MessageMapper {

	void saveMessage(Message message);

	List<MessageVo3> getMyMessageByIdAndNotGet(String accepterId);

	void setIsGotStatus(String accepterId);

	Integer getMyMessageTotalCount(String userId);

	List<Message> getMyMessage(String accepterId);

	List<Message> getMessageByIdAndIsGot(String id);
	
	
	List<MessageVO2> getOne2OneMsg(MessageVO vo);

}
