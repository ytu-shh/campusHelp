package com.ssm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.ssm.util.JsonUtil;
import com.ssm.po.School;
import com.ssm.po.User;
import com.ssm.service.SchoolService;
import com.ssm.service.UserService;

/**
 * 注销登录*
 * 异步读取院校列表*
 * 读取一个用户信息*
 * @author 
 *
 */
@Controller
@SessionAttributes({ "nowuser","nowadmin"})
@RequestMapping(value = "common/")
public class CommonController {

	@Resource(name = "schoolService")
	public SchoolService schoolService;
	
	@Resource(name = "userService")
	public UserService userService;
	
	// 注销
	@RequestMapping("logout.do")
	public String logout(HttpServletRequest request, Model model) {
		model.addAttribute("msg", "已退出");
		request.getSession(false).removeAttribute("nowuser");
		request.getSession(false).removeAttribute("nowadmin");
		return "login";
	}
	
	@RequestMapping("getallschools.do")
	public void getallschools(HttpServletResponse response) throws IOException{
		System.out.println("000000000000000000000000000000000");
		List<School> list = schoolService.getAllSchoolsNoState();
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html");
		String list_String = JsonUtil.list2json(list);
		PrintWriter out = response.getWriter();
		out.println(list_String);
		out.flush();
		out.close();
	}
	
	@RequestMapping("getuser.do")
	public String getuser(String stuidstr,HttpServletRequest request,Model model) {
		int stuid = 0;
		try {
			stuid = Integer.parseInt(stuidstr);
		} catch (Exception e) {
			model.addAttribute("msg", "出现错误");
			return "userInfo";
		}
		if (stuid==0) {
			model.addAttribute("msg", "出现错误");
			return "userInfo";
		}
		User user = userService.getByUid(stuid);
		model.addAttribute("theuser", user);
		return "userInfo";
	}
	
	
	
}
