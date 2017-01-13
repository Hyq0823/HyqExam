package com.hyq.util;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

public class RedisUtils {
    private static JedisPool jedisPool = SpringUtils.getBean("jedisPool");
    private static Jedis jedis = jedisPool.getResource();
    
    public static String get(String key){
        return jedis.get(key);
    }
    

}
