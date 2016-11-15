package com.hyq.service;

import java.util.List;

import net.sf.json.JSONArray;

import com.hyq.domain.Apply;
import com.hyq.domain.ApplyInfo;
import com.hyq.vo.ApplyVO;
import com.hyq.vo.EnsureVo;
import com.hyq.vo.ResumeVo;

public interface ApplyService {

	/**
	 * 保存--发布的报名信息
	 * @param applyInfo
	 */
	void saveApplyInfo(ApplyInfo applyInfo);

	/**
	 * 查询所有的报名信息
	 * @return
	 */
	List<ApplyInfo> findAllApplyInfo();

	/**
	 * 根据id查询报名详细信息
	 * @param id
	 * @return
	 */
	ApplyInfo findApplyById(Integer id);
	
	
	
	//========================报名表==========================
	/**
	 * 保存报名表的信息
	 * @param apply
	 */
	void saveApply(Apply apply);

	/**
	 * 判断是否已经报过名了
	 * @param applyVo
	 * @return
	 */
	boolean isApplyed(ApplyVO applyVo);

	/**
	 * 修改报名信息
	 * @param applyInfo
	 */
	void updateApplyInfo(ApplyInfo applyInfo);

	/**
	 * 删除一条报名信息
	 * @param id
	 */
	void deleteApplyInfoById(Integer id);
	

	/**
	 * 查找出一个报名模块下面的所有报名考生基本信息
	 * @param applyInfoId
	 * @return
	 */
	List<EnsureVo> getTreeTableInfo(Integer applyInfoId);

	/**
	 * 考生通过审核
	 * @param applyId
	 */
	void modifyApplyPass(Integer applyId);
	
	/**
	 * 考生没有 通过审核
	 * @param applyId
	 */
	void modifyApplyFail(Integer applyId);

	/**
	 * 在t_apply中通过这三个参数确定上一个用户简历的Userid
	 * @param userId
	 * @param applyId
	 * @param infoId
	 * @return
	 */
	String findBeforeOne(ResumeVo resumeVo);

	String findAfterOne(ResumeVo resumeVo);

	/**
	 * 转换为json数组
	 * 格式化时间类型
	 * @param applyInfoList
	 * @return
	 */
	JSONArray getApplyInfo2JsonArray(List<ApplyInfo> applyInfoList);

	List<ApplyInfo> getTopApplyList();

	JSONArray getAll2JsonArrayByTopList(List<ApplyInfo> topList,JSONArray total);

}
