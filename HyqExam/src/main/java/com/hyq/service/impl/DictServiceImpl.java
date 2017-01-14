package com.hyq.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hyq.domain.Dict;
import com.hyq.mapper.DictMapper;
import com.hyq.service.DictService;

@Service
public class DictServiceImpl implements DictService{

    @Autowired
    private DictMapper dictMapper;
    @Override
    public List<Dict> findListByType(Dict dict) {
        return dictMapper.findListByType(dict);
    }
	

}
