package com.hyq.mapper;

import java.util.List;

import com.hyq.domain.Apply;
import com.hyq.domain.ApplyInfo;
import com.hyq.vo.ApplyVO;
import com.hyq.vo.EnsureVo;
import com.hyq.vo.ResumeVo;

public interface ApplyMapper {

	/**
	 * 加入 发布的报名信息
	 * @param applyInfo
	 */
	void insertApplyInfo(ApplyInfo applyInfo);

	/**
	 * 查询所有报名信息
	 * @return
	 */
	List<ApplyInfo> getAllApplyInfo();

	/**
	 * 根据id查询详细信息
	 * @param id
	 * @return
	 */
	ApplyInfo getApplyById(Integer id);
	
	/**
	 * 插入考试报名数据 到报名表中
	 * @param apply
	 */
	void insertApply(Apply apply);

	
	 /**
	  * 判断是否已经报过名了
	  * @param applyVo
	  * @return
	  */
	Integer isApplyed(ApplyVO applyVo);

	/**
	 * 修改报名信息
	 * @param applyInfo
	 */
	void updateInfo(ApplyInfo applyInfo);

	/**
	 * 根据id删除一条记录
	 * @param id
	 */
	void deleteById(Integer id);


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
	 * 在t_apply表中通过这三个参数确定上一个用户简历的Userid
	 * @param userId
	 * @param applyId
	 * @param infoId
	 * @return
	 */
	String findBeforeOne(ResumeVo resumeVo);

	String findAfterOne(ResumeVo resumeVo);

	List<ApplyInfo> getTopApplyList();

	List<ApplyInfo> getChildrenByParentId(Integer id);
	
}
