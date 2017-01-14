package com.hyq.service;

import java.util.List;

import net.sf.json.JSONArray;

import com.hyq.domain.Apply;
import com.hyq.domain.ApplyInfo;
import com.hyq.domain.Dict;
import com.hyq.vo.ApplyVO;
import com.hyq.vo.EnsureVo;
import com.hyq.vo.ResumeVo;

public interface DictService {

    List<Dict> findListByType(Dict dict);

    void save(Dict dict);

	
}
