package com.hyq.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hyq.domain.Notice;
import com.hyq.domain.Page;
import com.hyq.domain.User;
import com.hyq.service.NoticeService;
import com.hyq.util.ResponseUtil;
import com.hyq.util.WordFilterUtil;
import com.hyq.vo.NoticeMoveVo;

/**
 * 公告模块
 * 
 * @author HYQ
 * 
 */
@Controller
@RequestMapping("/notice")
public class NoticeController {

	@Autowired
	private NoticeService noticeService;

	/**
	 * 去向发布公告页面
	 * 
	 * @return
	 */
	@RequestMapping("/addNoticeUI")
	public String addNoticeUI(
			@RequestParam(value = "noticeId", required = false) Integer id,
			HttpServletRequest request) {
		if (id == null) {
			return "admin/notice/addNoticeUI";
		} else {
			Notice notice = noticeService.findById(id);
			request.setAttribute("notice", notice);
			return "admin/notice/editNoticeUI";
		}
	}

	/**
	 * 发布公告请求
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/addNotice")
	public void addNotice(Notice notice, HttpSession session,
			HttpServletResponse response) throws Exception {
		
		//获取目前最大的位置
		Integer maxPosition = noticeService.getMaxPosition();
		
		// 封装数据
		notice.setDeployTime((new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
				.format(new Date())));
		User currentUser = (User) session.getAttribute("user");
		notice.setDeployer(currentUser == null ? "" : currentUser.getNickname());
		notice.setPosition(maxPosition + 1);
		

		// 保存
		Integer id = noticeService.saveNotice(notice);
		if (id == null || id < 0) {
			ResponseUtil.write2Brower(response, false);
		} else {
			ResponseUtil.write2Brower(response, true);
		}
	}

	/**
	 * 去向公告管理页面
	 * 
	 * @return
	 */
	@RequestMapping("/manageNoticeUI")
	public String manageNoticeUI() {
		return "admin/notice/manageNotice";
	}

	/**
	 * 列出所有公告 --公告管理
	 * 
	 * @return
	 * @throws Exception
	 *             前台参数 page 1 rows 40
	 */
	@RequestMapping("/listAllNotices")
	public void listAllNotices(
			@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "rows", required = false) Integer rows,
			HttpServletResponse response) throws Exception {
		// 查询出总的记录
		int totalRecord = noticeService.getTotalRecord();

		// 已知 页数 和每一页的显示条数
		Page pageBean = new Page(page, rows, totalRecord);

		// 条件
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startIndex", pageBean.getStartIndex()); // 起始坐标
		map.put("pageSize", pageBean.getPageSize()); // 取多少条

		// 传入条件查询
		List<Notice> noticeList = noticeService.findByMap(map);
		JSONObject result = new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(noticeList);

		// 封装前台参数
		result.put("rows", jsonArray);
		result.put("total", totalRecord);

		// 写出
		ResponseUtil.write2Brower(response, result);

	}

	/**
	 * 修改公告请求
	 * 
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/editNotice")
	public void editNotice(Notice notice, HttpSession session,
			@RequestParam(value="noticeId",required=true) Integer id,
			HttpServletResponse response,HttpServletRequest request) throws Exception {

		// 封装数据
		notice.setDeployTime((new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
				.format(new Date())));
		User currentUser = (User) session.getAttribute("user");
		notice.setDeployer(currentUser == null ? "" : currentUser.getNickname());
		notice.setId(id);

		Integer result = noticeService.updateNotice(notice);
		
		if (result == null || result < 0) {
			ResponseUtil.write2Brower(response, false);
		} else {
			ResponseUtil.write2Brower(response, true);
		}
		
		
	}

	
	/**
	 * 删除公告
	 * @param ids
	 * @throws Exception 
	 */
	@RequestMapping("/deleteByIds")
	public void deleteByIds(@RequestParam(value="ids",required=true)String ids,HttpServletResponse response) throws Exception
	{
		String[] idArr = ids.split(",");
		for(int i=0;i<idArr.length;i++)
		{
			noticeService.deleteById(Integer.parseInt(idArr[i]));
		}
		ResponseUtil.write2Brower(response,true);
		
	}
	
	@RequestMapping("/noticeDetail")
	public void noticeDetail(@RequestParam(value="noticeId") Integer id,HttpServletRequest request,HttpServletResponse response) throws Exception
	{
		//前一个版本的传输json的方式----丢弃
//		Notice  notice= noticeService.findById(id);
//		JSONObject result = new JSONObject();
//		result.put("rows", notice);
//		result.put("total", 1);
//		ResponseUtil.write2Brower(response, result);
		
		
		//第二种方式--直接传输html给页面。
		//查询数据
		Notice  notice= noticeService.findById(id);
		StringBuffer sb = new StringBuffer();
		sb.append("<ul>")
		.append("<li><span>公告id： </span>"+notice.getId()+"</li>")
		.append("<li><span>公告标题： </span>"+notice.getTitle()+"</li>")
		.append("<li><span>公告内容： </span>"+WordFilterUtil.filter(notice.getContent())+"</li>")
		.append("<li><span>发布时间： </span>"+notice.getDeployTime()+"</li>")
		.append("<li><span>发布人： </span>"+notice.getDeployer()+"</li>")
		.append("</ul>");
		
		ResponseUtil.write2Brower(response, sb);
	}
	
	
	@RequestMapping("/moveUp")
	public void moveUp(@RequestParam("position") Integer position,@RequestParam("noticeId") Integer id,HttpServletResponse response) throws Exception
	{
		//获取到当前需要上移的postion --ok
		//查找postion是当前postion - 1的那条记录
		Notice notice = noticeService.findByPosition(position - 1);
		 //构造VO --id是需要上移的noticeId,而postion是上一条记录的postion
		int oriResult = noticeService.updatePositionById(new NoticeMoveVo(id, notice.getPosition())); 
		int newResult = noticeService.updatePositionById(new NoticeMoveVo(notice.getId(), position));
		//如果记录为null 则说明是第一条记录，不能上移--但postion = 1在页面处理了，就不管了
		//如果记录不为null，则更新当前这个记录的postion为查询出来的postion，更新查询出来的postion为当前的postion
		if(oriResult>0 && newResult>0)
		{
			ResponseUtil.write2Brower(response, true);
		}else
		{
			ResponseUtil.write2Brower(response, false);
		}
	}
	
	@RequestMapping("/moveDown")
	public void moveDown(@RequestParam("position") Integer position,@RequestParam("noticeId") Integer id,HttpServletResponse response) throws Exception
	{
		//查找吓一条记录
		Notice notice = noticeService.findByPosition(position + 1);
		if(notice == null)
		{
			ResponseUtil.write2Brower(response,false);
			return;
		}
		int oriResult = noticeService.updatePositionById(new NoticeMoveVo(id, notice.getPosition())); 
		int newResult = noticeService.updatePositionById(new NoticeMoveVo(notice.getId(), position));
		//如果记录为null 则说明是第一条记录，不能上移--但postion = 1在页面处理了，就不管了
		//如果记录不为null，则更新当前这个记录的postion为查询出来的postion，更新查询出来的postion为当前的postion
		if(oriResult>0 && newResult>0)
		{
			ResponseUtil.write2Brower(response, true);
		}else
		{
			ResponseUtil.write2Brower(response, false);
		}
	}
}
