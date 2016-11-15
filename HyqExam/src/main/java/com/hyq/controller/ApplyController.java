package com.hyq.controller;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hyq.domain.Apply;
import com.hyq.domain.ApplyInfo;
import com.hyq.domain.User;
import com.hyq.service.ApplyService;
import com.hyq.service.UserService;
import com.hyq.util.ApplyUtil;
import com.hyq.util.DateFormatUtil;
import com.hyq.util.ResponseUtil;
import com.hyq.vo.ApplyVO;
import com.hyq.vo.EnsureVo;

/**
 * 控制报名模块
 * 
 * @author HYQ
 * 
 */
@Controller
@RequestMapping("/apply")
public class ApplyController {

	@Autowired
	private ApplyService applyService;

	@Autowired
	private UserService userService;

	/**
	 * 管理员——发布报名信息UI
	 * 
	 * @return
	 */
	@RequestMapping("/addApplyInfoUI")
	public ModelAndView addApplayInfo() {
		// 查询出所有的报名信息
		List<ApplyInfo> list = applyService.findAllApplyInfo();

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("admin/apply/deployApplyInfo");
		modelAndView.addObject("applyInfoList", list);

		return modelAndView;
	}

	/**
	 * 发布报名信息
	 * 
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/deploy")
	public void deploy(ApplyInfo applyInfo, HttpServletRequest request,HttpServletResponse response) throws Exception {

		// 封装其他参数
		applyInfo.setStatus(ApplyInfo.APPLy_NotStart); // 默认为未开始
		
		//启动定时器来定时让报名开始 

		// 存储发布的报名信息
		applyService.saveApplyInfo(applyInfo);
		// 跳转到报名信息列表请求 如果是转发的话，在刷新页面的时候就会再次提交一条报名信息
		ResponseUtil.write2Brower(response, true);
	}

	/**
	 * 去往 报名信息 列表页面
	 * 
	 * @return
	 */
	@RequestMapping("toApplyList")
	public ModelAndView toapplyList() {
		// 查询出所有的报名信息
		List<ApplyInfo> applyInfoList = applyService.findAllApplyInfo();

		// 封装
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("admin/apply/applyList");
		modelAndView.addObject("applyInfoList", applyInfoList);

		// 返回
		return modelAndView;
	}

	/**
	 * 报名详细信息
	 * 
	 * @return
	 */
	@RequestMapping("/detail")
	public ModelAndView detail(
			@RequestParam(value = "applyId", required = true) Integer id) {
		ApplyInfo applyInfo = applyService.findApplyById(id);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("applyInfo", applyInfo);
		modelAndView.setViewName("admin/apply/applyDetail");

		return modelAndView;
	}

	/**
	 * 修改一个报名信息UI
	 * 
	 * @param id
	 *            ---报名信息id
	 * @return
	 */
	@RequestMapping("/editApplyUI")
	public ModelAndView editApplyUI(
			@RequestParam(value = "applyId", required = true) Integer id) {
		// 查询出要编辑的报名信息
		ApplyInfo applyInfo = applyService.findApplyById(id);
		// 查询出所有的报名信息
		// TODO 这里应该是查询出除了本轮的项目
		List<ApplyInfo> list = applyService.findAllApplyInfo();
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("admin/apply/deployApplyInfo");

		modelAndView.addObject("applyInfoList", list);
		modelAndView.addObject("applyInfo", applyInfo);
		return modelAndView;

	}

	/**
	 * 修改一个报名信息
	 * 
	 * @param id
	 *            ---报名信息id
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/edit")
	public void edit(ApplyInfo applyInfo,HttpServletResponse response) throws Exception {

		// // 封装其他参数
		applyInfo.setStatus(ApplyInfo.APPLy_RUNNING); // 默认为进行中
		System.out.println(applyInfo);

		// 修改报名信息
		applyService.updateApplyInfo(applyInfo);
		
		ResponseUtil.write2Brower(response, true);


	}

	/**
	 * 删除一个报名信息
	 * 
	 * @param id
	 *            ---报名信息id
	 */
	@RequestMapping("/deleteApply")
	public String deleteApply(@RequestParam("applyId") Integer id) {

		// 修改报名信息
		applyService.deleteApplyInfoById(id);

		// // 跳转到报名信息列表请求 如果是转发的话，在刷新页面的时候就会再次提交一条报名信息
		return "redirect:toApplyList.action?";
	}

	/**
	 * 审核报名信息
	 * 
	 * @param id
	 *            ---报名信息id
	 */
	@RequestMapping("/ensureStu")
	public ModelAndView ensureStu(
			@RequestParam("applyInfoId") Integer applyInfoId) {

		// // 跳转到报名信息列表请求 如果是转发的话
		// 在刷新页面的时候就会再次提交一条报名信息
		// 从报名表中找出 考生的报名信息id 是applyInfoId的id

		// 查询报名情况
		List<EnsureVo> enSureList = applyService.getTreeTableInfo(applyInfoId);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("admin/apply/enSure");
		modelAndView.addObject("enSureList", enSureList);
		// 为了导出考生能获取infoID
		modelAndView.addObject("applyInfoId", applyInfoId);

		// 跳转到审核页面
		return modelAndView;

	}

	/**
	 * 通过 审核
	 * 
	 * @param id
	 *            ---报名信息id
	 */
	@RequestMapping("/ensure_pass")
	public String ensure_pass(@RequestParam("applyId") Integer applyId,
			@RequestParam("applyInfoId") Integer applyInfoId) {

		// 修改用户的审核状态
		applyService.modifyApplyPass(applyId);

		// 再次查询需要审核的其他信息
		// 跳转到审核页面
		return "redirect:ensureStu.action?applyInfoId=" + applyInfoId;

	}

	/**
	 * 未通过 审核
	 * 
	 * @param id
	 *            ---报名信息id
	 */
	@RequestMapping("/ensure_fail")
	public String ensure_fail(@RequestParam("applyId") Integer applyId,
			@RequestParam("applyInfoId") Integer applyInfoId) {

		// 修改用户的审核状态
		applyService.modifyApplyFail(applyId);

		// 再次查询需要审核的其他信息
		// 跳转到审核页面
		return "redirect:ensureStu.action?applyInfoId=" + applyInfoId;
	}

	@RequestMapping("/aaa")
	public String aaa() {

		return "1";
	}

	/**
	 * 导出一个报名信息下的所有报名考生
	 * 
	 * @param applyId
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("/exportStu")
	public void exportStu(@RequestParam("applyInfoId") Integer applyInfoId,
			HttpServletResponse response) throws IOException {
		// 查询报名情况
		List<EnsureVo> enSureList = applyService.getTreeTableInfo(applyInfoId);

		// 1、创建工作薄
		Workbook wb = new HSSFWorkbook();
		// 2 创建sheet页
		Sheet sheet = wb.createSheet("考生报名信息"); // 这里应该是具体的报名名称
		// 3创建头部
		Row row_header = sheet.createRow(0);

		// 用三个实体的数据作为头部
		String[] headers = { "昵称", "真实姓名", "电话", "邮箱", "报名标题", "报名开始时间",
				"报名结束时间", "考生状态 " };
		for (int i = 0; i < headers.length; i++) {
			Cell cell = row_header.createCell(i);
			cell.setCellValue(headers[i]);
		}

		// 加入具体的数据
		for (int i = 0; i < enSureList.size(); i++) {
			EnsureVo vo = enSureList.get(i);
			User user = vo.getUser();
			ApplyInfo info = vo.getApplyInfo();
			Apply apply = vo.getApply();

			Row row = sheet.createRow(i + 1); // 从第二行开始创建
			
			//创建列
			for (int col = 0; col < headers.length; col++) {
				Cell cell = row.createCell(col); // 从第0列开始创建
				if (col == 0) {
					cell.setCellValue(user.getNickname());
				} else if (col == 1) {
					cell.setCellValue(user.getTruename());
				} else if (col == 2) {
					cell.setCellValue(user.getPhone());
				} else if (col == 3) {
					cell.setCellValue(user.getEmail());
				} else if (col == 4) {
					cell.setCellValue(info.getTitle());
				} else if (col == 5) {
					cell.setCellValue(info.getStartTime().toString());
				} else if (col == 6) {
					cell.setCellValue(info.getEndTime().toString());
				} else if (col == 7) {
					cell.setCellValue(apply.getApplyStatus());
				}
			}

		}

		// 写给浏览器
		response.setContentType("application/vnd.ms-excel;charset=utf-8");
		response.setHeader("Content-Disposition","attachment;filename="
				+ new String("报名信息表.xls".getBytes("utf-8"), "iso8859-1"));
		wb.write(response.getOutputStream());
		response.getOutputStream().flush();

	}

	// ====================前台请求======================
	/**
	 * 前台——请求报名列表
	 * 
	 * @return
	 */
	@RequestMapping("/applyList")
	public ModelAndView applyList() {
		// 查询出所有的报名信息
		List<ApplyInfo> applyInfoList = applyService.findAllApplyInfo();

		// 查询我的报名信息
		// List<ApplyInfo> myApplyList = applyService

		// 封装
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("foreground/apply/mainApply");
		modelAndView.addObject("applyInfoList", applyInfoList);

		// 返回
		return modelAndView;
	}

	/**
	 * 前台-请求一个报名
	 * 
	 * @param applyInfoId
	 *            报名信息id
	 * @param isHandConfim
	 *            是否手动确认
	 * @param response
	 * @param session
	 * @throws Exception
	 */
	@RequestMapping("/applyRequest")
	public void applyRequest(@RequestParam("infoId") Integer applyInfoId,
			@RequestParam("hand") String isHandConfirm,
			HttpServletResponse response, HttpSession session) throws Exception {

		// 判断用户是否登录 如果没登录必须先去登录
		User currentUser = (User) session.getAttribute("currentUser");
		if (currentUser == null) {
			ResponseUtil.write2Brower(response, "您还未登录,请先登录!");
			return;
		}

		// 先检测用户信息是否完善
		// TODO 测试时，暂时先不要
		boolean flag = userService.isCompleteInfo(currentUser);
		if (!flag) // 如果没有完善
		{
			ResponseUtil.write2Brower(response, "报名前请完善您的详细信息!");
			return;
		}
		// 检测用户是否具有这轮报名权限

		// 判断用户是否已经报过名了
		boolean isApplyed = applyService.isApplyed(new ApplyVO(applyInfoId,
				currentUser.getId()));
		if (isApplyed) // 如果已经报过了这个名
		{
			ResponseUtil.write2Brower(response, "您已经报过了,请不要重复报名!");
			return;
		}

		// 检测报名是否需要手动审核
		Apply apply = new Apply();
		apply.setUserId(currentUser.getId()); // 考生id
		apply.setApplyInfoId(applyInfoId);// 报名信息id
		apply.setApplyStatus(ApplyUtil.checkStatus(isHandConfirm));// 报名考生状态
																	// 待审核、已通过、未通过

		// 保存报名数据
		applyService.saveApply(apply);

		// 报名成功
		ResponseUtil.write2Brower(response, "报名成功!");
	}
	
	//=========================修改======================================
	//改为json的报名
	/**
	 * 去报名页面
	 * @return
	 */
	@RequestMapping("/lookApplyInfo")
	public String lookApplyInfo()
	{
		return "admin/apply/applyList2";
	}
	
	/**
	 * 获取json数据
	 * @throws Exception 
	 */
	@RequestMapping("/getApplyInfoList")
	public void getApplyInfoList(HttpServletResponse response) throws Exception
	{
		// 查询出所有的报名信息
		List<ApplyInfo> applyInfoList = applyService.findAllApplyInfo();
		JSONArray array = applyService.getApplyInfo2JsonArray(applyInfoList);
		ResponseUtil.write2Brower(response,array);
	}
	
	/**
	 * 删除1个/多个报名信息
	 * @param ids
	 * @throws Exception 
	 */
	@RequestMapping("/deleteByIds")
	public void deleteByIds(@RequestParam(value="ids",required=true)String ids,HttpServletResponse response) throws Exception
	{
		String[] idArr = ids.split(",");
		for(int i=0;i<idArr.length;i++)
		{
			applyService.deleteApplyInfoById((Integer.parseInt(idArr[i])));
		}
		ResponseUtil.write2Brower(response,true);
		
	}

	
	
	
	
	/**
	 * 获取数状的报名列表
	 * @throws Exception 
	 */
	@RequestMapping("/getTreeApplyInfos")
	public void getTreeApplyInfos(HttpServletResponse response) throws Exception{
		//递归的获取 报名列表
		 List<ApplyInfo> topList  = applyService.getTopApplyList();
		 JSONArray total = new JSONArray();
		 
		 JSONObject defaultChoice = new JSONObject();
		 defaultChoice.put("id",-1);
		 defaultChoice.put("text","无(默认)");
		 defaultChoice.put("checked",true);
		 total.add(defaultChoice);
		 
		 JSONArray array = applyService.getAll2JsonArrayByTopList(topList,total);
		 ResponseUtil.write2Brower(response, total);
	}
	
	

}
