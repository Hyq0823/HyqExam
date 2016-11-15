package com.hyq.controller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hyq.domain.Notice;
import com.hyq.domain.Page;
import com.hyq.domain.Privilege;
import com.hyq.domain.Role;
import com.hyq.service.PrivilegeService;
import com.hyq.service.RoleService;
import com.hyq.util.NumberUtil;
import com.hyq.util.ResponseUtil;

@Controller
@RequestMapping("/role")
public class RoleController {
	@Autowired
	private RoleService roleService;
	
	@Autowired
	private PrivilegeService privilegeService;
	
	@RequestMapping("/roleManage")
	/**
	 * 角色管理页面
	 * @return
	 */
	public ModelAndView roleManage()
	{
		ModelAndView modelAndView  = new ModelAndView();
		modelAndView.setViewName("admin/role/manageRole");
		return modelAndView;
	}
	
	
	/**
	 * 列出所有的角色
	 * @throws Exception 
	 */
	@RequestMapping("/listAllRoles")
	public void listAllRoles(
			@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "rows", required = false) Integer rows,
			HttpServletResponse response) throws Exception
	{
		
			// 查询出总的记录
				int totalRecord = roleService.getTotalRecord();

				// 已知 页数 和每一页的显示条数
				Page pageBean = new Page(page, rows, totalRecord);

				// 条件
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("startIndex", pageBean.getStartIndex()); // 起始坐标
				map.put("pageSize", pageBean.getPageSize()); // 取多少条

				// 传入条件查询
				List<Notice> noticeList = roleService.findByMap(map);
				JSONObject result = new JSONObject();
				JSONArray jsonArray = JSONArray.fromObject(noticeList);

				// 封装前台参数
				result.put("rows", jsonArray);
				result.put("total", totalRecord);

				// 写出
				ResponseUtil.write2Brower(response, result);
		
		
		
	}

	
	/**
	 * 添加一个角色
	 * @throws Exception 
	 */
	@RequestMapping("/addRole")
	public void addRole(Role role,HttpServletResponse response) throws Exception
	{
		Integer result = roleService.addRole(role);
		if(result>0)
		{
			ResponseUtil.write2Brower(response, true);
		}else
		{
			ResponseUtil.write2Brower(response, false);
		}
	}
	
	/**
	 * 修改一个角色
	 * @throws Exception 
	 */
	@RequestMapping("/edit")
	public void edit(Role role,HttpServletResponse response) throws Exception
	{
		Integer result = roleService.updateRole(role);
		if(result>0){
			ResponseUtil.write2Brower(response, true);
		}else{
			ResponseUtil.write2Brower(response, false);
		}
	}
	
	
	/**
	 * 删除角色
	 * @param ids
	 * @throws Exception 
	 */
	@RequestMapping("/user/deleteByIds")
	public void deleteByIds(@RequestParam(value="ids",required=true)String ids,HttpServletResponse response) throws Exception
	{
		String[] idArr = ids.split(",");
		for(int i=0;i<idArr.length;i++)
		{
			roleService.deleteById(Integer.parseInt(idArr[i]));
		}
		ResponseUtil.write2Brower(response,true);
		
	}
	
	/**
	 * 获取已经存在的角色-便于通过角色来查找信息。
	 * 从user_role表中查找
	 * @throws Exception 
	 */
	@RequestMapping("/getExistRoleList")
	public void getExistRoleList(HttpServletResponse response) throws Exception
	{
		//查询出所有【已选】 【不重复】 角色
		List<Role> roleList = roleService.findExistRoleList();
		
		//构造combobox的第一行
		JSONObject o = new JSONObject();
		JSONArray array = new JSONArray();
		o.put("id",-1);
		o.put("name","请选择...");
		o.put("selected",true);

		array.add(o);
		array.addAll(JSONArray.fromObject(roleList));
		ResponseUtil.write2Brower(response, array);
	}
	
	
	/**
	 * ---》1、产生权限树
	 * ---》2、回显已选的权限
	 * @throws Exception 
	 */
	@RequestMapping("/showSelectedRowTree")
	public void showSelectedRowTree(@RequestParam(value="roleId",required=true) Integer roleId,HttpServletResponse response) throws Exception
	{
		//查询顶级权限
		List<Privilege> topPrivilegeList =  privilegeService.findTopPrivilege();
		
		//2 - 查询本角色已有的权限
		List<Privilege> privileges = privilegeService.findPrivilegeListByRoleId(roleId);
		Set<Integer> myPids = NumberUtil.getIdsFromList(privileges);
		
		//递归 所有权限数据到totalArray中
		JSONArray totalArray = new JSONArray();
		findArray(topPrivilegeList, null, totalArray,myPids);
		
		//写出
		ResponseUtil.write2Brower(response, totalArray);
	}
	
	
	/**
	 * 为角色 分配权限
	 * @param ids  权限ids
	 * @param roleId  角色id
	 * @param response
	 * @throws Exception 
	 */
	@RequestMapping("/assistPrivilege")
	public void assistPrivilege(@RequestParam(value="ids",required=true)String ids,
			@RequestParam(value="roleId",required=true) Integer roleId ,HttpServletResponse response) throws Exception
	{
		privilegeService.applyPrivilege4Role(ids,roleId);
		ResponseUtil.write2Brower(response, true);
	}

/**
 * 递归--产生json数据的权限树
 * @param topPrivilegeList
 * @param now
 * @param totalArray
 * @param set
 * @return
 */
private  JSONArray findArray(List<Privilege> topPrivilegeList,Privilege now,JSONArray totalArray,Set set) {
	JSONObject value = null;
	for(Privilege p :topPrivilegeList)
	{
		value = new JSONObject();
		List<Privilege> childList = privilegeService.finChildPrivilegeList(p.getId());
		if(childList.size()>0)
		{
			JSONArray arr = this.findArray(childList,p,totalArray,set);
			value.put("text", p.getName());
			value.put("id",p.getId());
			value.put("children",arr);
				if (p.getParentId() == null) {
					if(set.contains(value.getInt("id"))){
						value.put("checked",true);
					}
					totalArray.add(value);
				}
			
		}else
		{
				value.put("id",p.getId());
				value.put("text", p.getName());
		}
	}
	Integer id = (Integer) value.get("id");
	if(set.contains(id))
	{
		if(value!=null)
			value.put("checked",true);
	}	
	return JSONArray.fromObject(value);
}
	//产生权限树
	private void GetPrivilegeTreeList(List<Privilege> topPrivilegeList,int level) {
		for(int i=0;i<level;i++)
		{
			System.out.println("-");
		}
		for(int index=0;index<topPrivilegeList.size();index++)
		{
			Privilege p = topPrivilegeList.get(index);
			System.out.println(p.getName());
			//找这个权限的子权限  
			List<Privilege> childrens = privilegeService.finChildPrivilegeList(p.getParentId());
			level++;
			GetPrivilegeTreeList(childrens, level);
			
		}
	}
}
