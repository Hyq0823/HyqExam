package com.hyq.service.impl;

import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hyq.domain.Apply;
import com.hyq.domain.ApplyInfo;
import com.hyq.mapper.ApplyMapper;
import com.hyq.service.ApplyService;
import com.hyq.util.DateFormatUtil;
import com.hyq.vo.ApplyVO;
import com.hyq.vo.EnsureVo;
import com.hyq.vo.ResumeVo;

@Service
public class ApplyServiceImpl implements ApplyService{
	@Autowired
	private ApplyMapper applyMapper;

	@Override
	public void saveApplyInfo(ApplyInfo applyInfo) {
		applyMapper.insertApplyInfo(applyInfo);
	}

	@Override
	public List<ApplyInfo> findAllApplyInfo() {
		return applyMapper.getAllApplyInfo();
	}

	@Override
	public ApplyInfo findApplyById(Integer id) {
		return applyMapper.getApplyById(id);
	}

	@Override
	public void saveApply(Apply apply) {
		applyMapper.insertApply(apply);
	}

	@Override
	public boolean isApplyed(ApplyVO applyVo) {
		Integer id = applyMapper.isApplyed(applyVo);
		return id == null ? false : true;
		// 如果id不是null,说名已经报过了
	}

	@Override
	public void updateApplyInfo(ApplyInfo applyInfo) {
		applyMapper.updateInfo(applyInfo);
	}

	@Override
	public void deleteApplyInfoById(Integer id) {
		applyMapper.deleteById(id);
	}

	@Override
	public List<EnsureVo> getTreeTableInfo(Integer applyInfoId) {
		return applyMapper.getTreeTableInfo(applyInfoId);
	}

	@Override
	public void modifyApplyPass(Integer applyId) {
		applyMapper.modifyApplyPass(applyId);
	}

	@Override
	public void modifyApplyFail(Integer applyId) {
		applyMapper.modifyApplyFail(applyId);
	}

	@Override
	public String findBeforeOne(ResumeVo resumeVo) {
		return applyMapper.findBeforeOne(resumeVo);
	}

	@Override
	public String findAfterOne(ResumeVo resumeVo) {
		return applyMapper.findAfterOne(resumeVo);
	}
	@Override
	public JSONArray getApplyInfo2JsonArray(List<ApplyInfo> applyInfoList) {
		JSONArray array = new JSONArray();
		JSONObject result = null;

		for (ApplyInfo applyInfo : applyInfoList) {
			result = new JSONObject();
			result.put("id", applyInfo.getId());
			result.put("title", applyInfo.getTitle());
			result.put("description", applyInfo.getDescription());
			result.put("startTime",applyInfo.getStartTime());
			result.put("endTime",applyInfo.getEndTime());
			result.put("status", applyInfo.getStatus());
			result.put("isHandConfirm", applyInfo.getIsHandConfirm());
			result.put("parentId", applyInfo.getParentId());
			array.add(result);
		}
		return array;
	}

	@Override
	public List<ApplyInfo> getTopApplyList() {
		return applyMapper.getTopApplyList();
	}

	/**
	 * 1、每一个实体 封装
	 * 2、每一层  封装
	 * 3、总集合 封装
	 */
	@Override
	public JSONArray getAll2JsonArrayByTopList(List<ApplyInfo> topList,JSONArray total) {
		JSONObject result = null;
		JSONArray  floor = new JSONArray();
		for (int i = 0; topList.size() > 0 && i < topList.size(); i++) {
			ApplyInfo applyInfo = topList.get(i);
			
			result = new JSONObject();
			result.put("id", applyInfo.getId());
			result.put("text", applyInfo.getTitle());

			List<ApplyInfo> children = applyMapper
					.getChildrenByParentId(applyInfo.getId());
			if (children != null && children.size() > 0) {// 还有子级
				// 存储上级
				JSONArray lastArray = getAll2JsonArrayByTopList(children,total);// 最底层返回的是result
				if (lastArray != null && lastArray.size()>0){
					result.put("children", lastArray); //封装到 1_1_1 和它的child:1_1_1_1
					if(applyInfo.getParentId() == -1){
						total.add(result);
					}
				}
				
				//在每一层中加入这个，传给下一位
			}
			floor.add(result);
		}
		//return JSONArray.fromObject(result);// 如果顶层没有子级，返回null
		return floor;
	}

}
