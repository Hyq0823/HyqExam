package com.hyq.util;

import java.util.List;

import com.hyq.domain.Dict;
import com.hyq.service.DictService;

import net.sf.json.JSONArray;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

public class RedisUtils {
    private static JedisPool jedisPool = SpringUtils.getBean("jedisPool");
    private static DictService dictService = SpringUtils.getBean(DictService.class);
    
    public static Jedis getJedis(){
        Jedis jedis = null;
        try{
           jedis = jedisPool.getResource();
        }catch(Exception e){
          if(jedis!=null){
              jedis.close();
          }
        }
        return jedis;
    }
    

    /**
     * 
     * @param type
     * @param dicts
     * @return
     */
    public static String setListByType(String type, List<Dict> dicts){
        Jedis jedis = getJedis();
        if(jedis == null  || StringUtil.isEmpty(type) || dicts ==null || dicts.size() == 0 ){
            throw new RuntimeException("jedis is null or list null");
        }
        String values = JSONArray.fromObject(dicts).toString();
        return jedis.set(type, values);
    }
    
    /**
     * 通过type获得字典列表
     * @param type
     * @return
     */
    @SuppressWarnings("unchecked")
    public static List<Dict> getListByKey(String type){
        Jedis jedis = getJedis();
        if(jedis==null){
            throw new RuntimeException("jedis is null or  not exists the type:"+type);
        }
        List<Dict> dictLists = null;
        if(jedis.exists(type)){
           String dictStr = jedis.get(type);
           JSONArray array = JSONArray.fromObject(dictStr);
           return (List<Dict>) JSONArray.toCollection(array,Dict.class);
        }else{//如果不存在,就从db中拿去
            Dict dict = new Dict();
            dict.setType(type);
            dictLists = dictService.findListByType(dict);
            if(dictLists!=null && dictLists.size() > 0){//缓存起来
                setListByType(type, dictLists);
            }
        }
        return dictLists; 
    }
    public static void main(String[] args) {
      
    }
    

}
