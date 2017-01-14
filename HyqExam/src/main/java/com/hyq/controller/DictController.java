package com.hyq.controller;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hyq.domain.Dict;
import com.hyq.service.DictService;
import com.hyq.util.SpringUtils;
@Controller
public class DictController{
	private Logger logger = Logger.getLogger(DictController.class);

	@Autowired
	private DictService dictService;
	
	   
    @RequestMapping("/dict")
    public String test(Model model){
        Dict dict = new Dict();
        dict.setType("dict_edu");
         List<Dict> list = dictService.findListByType(dict);
         StringBuffer sb = new StringBuffer();
         for(Dict d : list){
             sb.append(d.getName()+" | ");
         }
        model.addAttribute("message",sb.toString());
        model.addAttribute("type","");
        return "message";
    }
    
    
    public String save(Dict dict){
        dictService.save(dict);
        return "";
    }
	
	

}
