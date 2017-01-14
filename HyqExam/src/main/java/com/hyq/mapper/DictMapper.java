package com.hyq.mapper;

import java.util.List;

import com.hyq.domain.Dict;

public interface DictMapper {

    List<Dict> findListByType(Dict dict);
}
