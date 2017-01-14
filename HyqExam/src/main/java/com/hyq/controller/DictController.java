package com.hyq.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hyq.service.DictService;
import com.hyq.util.SpringUtils;
@Controller
public class DictController{
	private Logger logger = Logger.getLogger(DictController.class);

	
	   
    @RequestMapping("/dict")
    public String test(Model model){
//        String value = RedisUtils.get("value");
//        model.addAttribute("message",value);
        DictService dictService = SpringUtils.getBean(DictService.class);
        model.addAttribute("message",dictService);
        return "message";
    }
	
	

}
