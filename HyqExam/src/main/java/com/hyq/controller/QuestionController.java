package com.hyq.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hyq.domain.BaseQuestion;
import com.hyq.domain.JudgeQuestion;
import com.hyq.domain.KnowLegePoint;
import com.hyq.domain.MutiChoiceQuestion;
import com.hyq.domain.Page;
import com.hyq.domain.QuestionType;
import com.hyq.domain.SingleChoiceQuestion;
import com.hyq.domain.WdQuestion;
import com.hyq.service.QuestionService;
import com.hyq.util.ResponseUtil;
import com.hyq.vo.QuestionLikeVo;
import com.hyq.vo.QuestionVo;

@Controller
@RequestMapping("/question")
public class QuestionController
{

	@Autowired
	private QuestionService questionService;
	
	/**
	 * 去向添加试题界面
	 */
	@RequestMapping("/addQuestionUI.action")
	public String addQuestionUI()
	{
		return "admin/question/addQuestionUI";
	}
	
	/**
	 * 获取问题类型  列表
	 * @throws Exception 
	 */
	@RequestMapping("/getQuestionTypes")
	public void getQuestionTypes(HttpServletResponse response) throws Exception
	{
		List<QuestionType> questionTypes = questionService.findAllQuestionTypes();
		JSONArray array = new JSONArray();
		JSONObject result = new JSONObject();
		JSONObject value = new JSONObject();
		result.put("id",-1);
		result.put("name","请选择题目类型...");
		result.put("selected", true);
		
		array.add(result);
		array.addAll(JSONArray.fromObject(questionTypes));
		ResponseUtil.write2Brower(response,array);
	}
	
	/**
	 * 获取封装到combobox的所有知识点
	 */
	@RequestMapping("/getComboboxKpoint")
	public String getComboboxKpoint(HttpServletResponse response)
	{
		return "forward:listAllKpoint.action";
	}
	
	
	
	/**
	 * 知识点管理UI 界面
	 * @return
	 */
	@RequestMapping("/knowledgePointUI")
	public String knowledgePointUI()
	{
		return "admin/question/knowLegePointView";
	}
	
	/**
	 * 添加顶级知识点
	 * @throws Exception 
	 */
	@RequestMapping("/addTopKp")
	public void addTopKp(KnowLegePoint kp,HttpServletResponse response) throws Exception
	{
		questionService.saveTopKpoint(kp);
		ResponseUtil.write2Brower(response, true);
	}
	
	/**
	 * 添加普通  （二级）知识点
	 * @throws Exception 
	 */
	@RequestMapping("/addSimpleKp")
	public void addSimpleKp(KnowLegePoint kp,HttpServletResponse response) throws Exception
	{
		questionService.saveSimpleKpoint(kp);
		ResponseUtil.write2Brower(response, true);
	}
	
	/**
	 * 获取顶级的知识点
	 * @throws Exception 
	 */
	@RequestMapping("/getTopList")
	public void getTopList(HttpServletResponse response) throws Exception{
		List<KnowLegePoint> topList = questionService.getTopList();
		
		JSONObject result = new JSONObject();
		JSONArray array = new JSONArray();
		result.put("id",-1);
		result.put("name","无(默认)");
		result.put("selected",true);
		array.add(result);
		array.addAll(topList);
		
	
		ResponseUtil.write2Brower(response,array);
	}
	
	/**
	 * 列出所有的知识点
	 * @throws Exception 
	 */
	@RequestMapping("/listAllKpoint")
	public void listAllKpoint(HttpServletResponse response) throws Exception
	{
		JSONArray array = questionService.listAll2JsonArray();
		ResponseUtil.write2Brower(response, array);
	}
	
	
	/**
	 * 修改一个知识点
	 * @throws Exception 
	 */
	@RequestMapping("/editKpoint")
	public void editKpoint(@RequestParam(value="id",required=true) Integer id,
			@RequestParam(value="text",required=true) String text,
			@RequestParam(value="description",required=true) String description,
			HttpServletResponse response) throws Exception
	{
		//完成修改 where id = id
		questionService.editKpointById(new KnowLegePoint(id, text, description));
		ResponseUtil.write2Brower(response, true);
	}
	
	
	/**
	 * 删除一个知识点
	 * @throws Exception 
	 */
	@RequestMapping("/deleteKpoint")
	public void deleteKpoint(@RequestParam(value="id",required=true) Integer id,HttpServletResponse response) throws Exception
	{
		questionService.deleteKpointById(id);
		ResponseUtil.write2Brower(response, true);
	}
	
	
	/**
	 * 添加单项选择题
	 * @throws Exception 
	 */
	@RequestMapping("/addSingleChoiceQuestion")
	public void addSingleChoiceQuestion(SingleChoiceQuestion singleChoiceQuestion,HttpServletResponse response) throws Exception
	{
		//存储单项选择题
		 questionService.saveSingleChoice(singleChoiceQuestion);
		//PointId  -- fail
		ResponseUtil.write2Brower(response, true);
		
	}
	/**
	 * 添加判断题
	 * @throws Exception 
	 */
	@RequestMapping("/addJudgeQuestion")
	public void addJudgeQuestion(JudgeQuestion judgeQuestion,HttpServletResponse response) throws Exception
	{
		//存储判断题
		 questionService.saveJudgeQuestion(judgeQuestion);
		ResponseUtil.write2Brower(response, true);
	}
	
	/**
	 * 添加问答题
	 * @throws Exception 
	 */
	@RequestMapping("/addWdQuestion")
	public void addWdQuestion(WdQuestion wdQuestion,HttpServletResponse response) throws Exception
	{
		questionService.saveWdQuestion(wdQuestion);
		ResponseUtil.write2Brower(response, true);
	}
	
	/**
	 * 添加多项选择题
	 * @throws Exception 
	 */
	@RequestMapping("/addMutiChoiceQuestion")
	public void addMutiChoiceQuestion(MutiChoiceQuestion mutiChoiceQuestion,HttpServletResponse response) throws Exception
	{
		questionService.saveMutiChoic(mutiChoiceQuestion);
		ResponseUtil.write2Brower(response, true);
	}
	
	
	/**
	 * 试题管理
	 * @return
	 */
	@RequestMapping("/manageQuestion")
	public ModelAndView manageQuestion()
	{
		//查询一级知识点
		List<KnowLegePoint> kpList = questionService.getTopKpoint();
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("kpList",kpList);
		modelAndView.setViewName("admin/question/manageQuestion");
		
		return modelAndView;
	}
	
	/**
	 * 查询所有的试题
	 * @throws Exception 
	 */
	@RequestMapping("/getAllQuestions")
	public void getAllQuestions(
			@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "rows", required = false) Integer rows,
			@RequestParam(value="type",required=false) String type,
			@RequestParam(value="level",required=false) String level,
			@RequestParam(value="point",required=false) String point,
			HttpServletResponse response) throws Exception
	{
		Integer totalRecord = null;
		Integer typeId	= null;
		// 查询出总的记录
			if(type!=null&&!"全部".equals(type)){//单表查询
			
				if("单项选择题".equals(type)){
					typeId = 1;
				}else if("判断题".equals(type)){
					typeId = 2;
				}else if("问答题".equals(type)){
					typeId = 3;
				}else if("多项选择题".equals(type)){
					typeId = 4;
				}
				QuestionLikeVo vo = new QuestionLikeVo("全部".equals(typeId)?null : typeId, "全部".equals(level)? null:level, "全部".equals(point)?null : point);
				totalRecord = questionService.getSingleTableRecord(vo);
			}else{ //多表操作
				QuestionLikeVo v = new QuestionLikeVo("全部".equals(level)? null:level, "全部".equals(point)?null : point);
			totalRecord = questionService.getTotalRecord(v);
			}
			// 已知 页数 和每一页的显示条数
			Page pageBean = new Page(page, rows, totalRecord);

			// 条件
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("startIndex", pageBean.getStartIndex()); // 起始坐标
			map.put("pageSize", pageBean.getPageSize()); // 取多少条
			
			//其他参数--在xml中控制
			map.put("typeId","全部".equals(typeId)?null : typeId);
			map.put("level","全部".equals(level)? null:level);
			map.put("point","全部".equals(point)?null : point);

			// 传入条件查询
			List<BaseQuestion> noticeList = questionService.findByMap(map);
			JSONObject result = new JSONObject();
			JSONArray jsonArray = JSONArray.fromObject(noticeList);

			// 封装前台参数
			result.put("rows", jsonArray);
			result.put("total",totalRecord);

			// 写出
			ResponseUtil.write2Brower(response, result);
			
	}
	
	/**
	 * 根据id和typeId删除多条记录
	 * @throws Exception 
	 */
	@RequestMapping("/deleteByIdandTypeId")
	public void deleteByIdandTypeId(HttpServletResponse response,@RequestParam(value="ids",required=true)String ids) throws Exception
	{
		Integer id = null;
		Integer typeId = null;
		String[] items = ids.split(",");//1@1,1@3,2@2  //id@typeId
		for(String s : items){
			String[] values = s.split("@");//1@1
			id = Integer.parseInt(values[0]);
			typeId = Integer.parseInt(values[1]);
			questionService.deleteQuestiosByIdAndTypeId(new QuestionVo(id, typeId)); //删除
		}
		ResponseUtil.write2Brower(response, true);
	}
	/**
	 * 分类筛选题目
	 */
	@RequestMapping("/limitByTypeId")
	public void limitByTypeId(@RequestParam(value="typeId") Integer typeId,
			@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "rows", required = false) Integer rows){
		System.out.println();
		
	}
	
}
