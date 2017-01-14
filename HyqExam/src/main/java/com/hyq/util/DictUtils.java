package com.hyq.util;

import java.util.List;

import com.hyq.domain.Dict;

public class DictUtils {
    
    /**
     * 根据类型获取字典列表
     * @param type
     * @return
     */
    public static List<Dict> getDictListByType(String type){
        return RedisUtils.getListByKey(type);
    }

}
