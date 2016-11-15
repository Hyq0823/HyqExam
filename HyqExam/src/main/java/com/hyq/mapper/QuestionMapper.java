package com.hyq.mapper;

import java.util.List;
import java.util.Map;

import com.hyq.domain.BaseQuestion;
import com.hyq.domain.JudgeQuestion;
import com.hyq.domain.KnowLegePoint;
import com.hyq.domain.MutiChoiceQuestion;
import com.hyq.domain.QuestionType;
import com.hyq.domain.SingleChoiceQuestion;
import com.hyq.domain.WdQuestion;
import com.hyq.vo.QuestionLikeVo;
import com.hyq.vo.QuestionVo;

public interface QuestionMapper {

	List<QuestionType> findAllQuestionTypes();

	void saveSingleChoice(SingleChoiceQuestion singleChoiceQuestion);
	
	void saveTopKpoint(KnowLegePoint kp);
	
	List<KnowLegePoint> getTopList();
	
	void saveSimpleKpoint(KnowLegePoint kp);

	List<KnowLegePoint> getChildsByTopId(Integer id);
	
	
	void editKpointById(KnowLegePoint knowLegePoint);
	
	void deleteKpointById(Integer id);
	
	void saveJudgeQuestion(JudgeQuestion judgeQuestion);
	void saveWdQuestion(WdQuestion wdQuestion);
	
	void saveMutiChoic(MutiChoiceQuestion mutiChoiceQuestion);
	List<KnowLegePoint> getTopKpoint();

	List<BaseQuestion> getAllBaseQuestions();
	Integer getTotalRecord(QuestionLikeVo vo);
	
	void deleteQuestiosByIdAndTypeId(QuestionVo questionVo);
	
	List<BaseQuestion> findByMap(Map<String, Object> map);
	
	Integer getSingleTableRecord(QuestionLikeVo vo);
}
