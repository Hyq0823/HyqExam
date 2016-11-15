package com.hyq.service.impl;

import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hyq.domain.BaseQuestion;
import com.hyq.domain.JudgeQuestion;
import com.hyq.domain.KnowLegePoint;
import com.hyq.domain.MutiChoiceQuestion;
import com.hyq.domain.QuestionType;
import com.hyq.domain.SingleChoiceQuestion;
import com.hyq.domain.WdQuestion;
import com.hyq.mapper.QuestionMapper;
import com.hyq.service.QuestionService;
import com.hyq.vo.QuestionLikeVo;
import com.hyq.vo.QuestionVo;

@Service
public class QustionServiceImpl implements QuestionService 
{
	@Autowired
	private QuestionMapper questionMapper;

	@Override
	public List<QuestionType> findAllQuestionTypes() {
		return questionMapper.findAllQuestionTypes();
	}

	@Override
	public void saveSingleChoice(SingleChoiceQuestion singleChoiceQuestion) {
		questionMapper.saveSingleChoice(singleChoiceQuestion);
	}

	@Override
	public void saveTopKpoint(KnowLegePoint kp) {
		questionMapper.saveTopKpoint(kp);
	}

	@Override
	public List<KnowLegePoint> getTopList() {
		return questionMapper.getTopList();
	}

	@Override
	public void saveSimpleKpoint(KnowLegePoint kp) {
		questionMapper.saveSimpleKpoint(kp);
	}

	@Override
	public JSONArray listAll2JsonArray() {
		JSONArray totalArray = new JSONArray();
		JSONObject o = null;
		
		List<KnowLegePoint> topList = questionMapper.getTopList();
		for(int i=0;i<topList.size();i++){
			o = new JSONObject();
			KnowLegePoint top = topList.get(i);
			List<KnowLegePoint> children = questionMapper.getChildsByTopId(top.getId());
			
			//设置顶级图表
			if(children!=null && children.size()>0){
				o.put("children",children);
			}
			o.put("id",top.getId());
			o.put("text",top.getText());
			o.put("description",top.getDescription());
			totalArray.add(o);
		}
		return totalArray;
	}

	@Override
	public List<KnowLegePoint> getChildsByTopId(Integer id) {
		return questionMapper.getChildsByTopId(id);
	}

	@Override
	public void editKpointById(KnowLegePoint knowLegePoint) {
		questionMapper.editKpointById(knowLegePoint);
	}

	@Override
	public void deleteKpointById(Integer id) {
		questionMapper.deleteKpointById(id);
	}

	@Override
	public void saveJudgeQuestion(JudgeQuestion judgeQuestion) {
		questionMapper.saveJudgeQuestion(judgeQuestion);
	}

	@Override
	public void saveWdQuestion(WdQuestion wdQuestion) {
		questionMapper.saveWdQuestion(wdQuestion);
	}

	@Override
	public void saveMutiChoic(MutiChoiceQuestion mutiChoiceQuestion) {
		questionMapper.saveMutiChoic(mutiChoiceQuestion);
	}

	@Override
	public List<KnowLegePoint> getTopKpoint() {
		return questionMapper.getTopKpoint();
	}

	@Override
	public JSONArray getAllQuestions2Array() {
		List<BaseQuestion> questions = questionMapper.getAllBaseQuestions();
		return JSONArray.fromObject(questions);
	}

	@Override
	public Integer getTotalRecord(QuestionLikeVo vo) {
		return questionMapper.getTotalRecord(vo);
	}

	@Override
	public void deleteQuestiosByIdAndTypeId(QuestionVo questionVo) {
		questionMapper.deleteQuestiosByIdAndTypeId(questionVo);
	}

	@Override
	public List<BaseQuestion> findByMap(Map<String, Object> map) {
		return questionMapper.findByMap(map);
	}

	@Override
	public Integer getSingleTableRecord(QuestionLikeVo vo) {
		return questionMapper.getSingleTableRecord(vo);
	}



}
