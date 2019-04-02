package com.ssm.controller;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.po.Task;
import com.ssm.po.User;
import com.ssm.service.TaskService;
import com.ssm.service.UserService;

/**
 * *****任务********
 * 用户发布新任务*
 * 用户读取自己发布的任务*
 * 用户读取自己接受的任务*
 * 用户确认任务完成*
 * 用户关闭未被人接受的任务*
 * 用户接受任务*
 * 读取任务的信息*
 * 搜索任务*
 * 
 * @author 
 *
 */

@Controller
@RequestMapping(value = "task/")
public class TaskController {

	@Resource(name = "taskService")
	public TaskService taskService;
	
	@Resource(name = "userService")
	public UserService userService;
	
	//发布新任务
	@RequestMapping("newtask.do")
	public String newtask(Task task, HttpServletRequest request, Model model) {
		User user = null;
		try {
			user = (User) request.getSession(false).getAttribute("nowuser");
		} catch (Exception e) {
			model.addAttribute("msg", "请检查登录状况");
			return "login";
		}
		try {
			if (user == null || user.getStuid() == 0) {
				model.addAttribute("msg", "发布失败-请检查登录状况");
				return "userNewtask";
			}
		} catch (Exception e) {
			model.addAttribute("msg", "发布失败-请检查登录状况");
			return "userNewtask";
		}
		if (user.getState() > 0) {
			model.addAttribute("msg", "发布失败-用户状态受限");
			return "userNewtask";
		}
		
		if (user.getMoney()<task.getReward()) {
			model.addAttribute("msg", "发布失败-余额不足-请联系管理员添加余额");
			return "userNewtask";
		}
		
		Task task2 = new Task(0, user.getStuid() + "", user.getName(), user.getSchoolid(), 0, task.getReward(),
				new Date(), new Date(), task.getTaskname(), task.getTaskcontext(), 0);
		
		user.setMoney(user.getMoney()-task2.getReward());
		int ruser = userService.updateUserInfo(user);
		if (ruser> 0) {
			int r = taskService.setNewTask(task2);
			if (r > 0) {
				
				model.addAttribute("msg", "发布成功");
				return getusertask(request, model);
			}else {
				model.addAttribute("msg", "余额已扣除-发布失败");
				return "userNewtask";
			}
		}else {
			model.addAttribute("msg", "发布失败");
			return "userNewtask";
		}

	}

	// 用户发布的
	@RequestMapping("getusertask.do")
	public String getusertask(HttpServletRequest request, Model model) {
		User user = null;
		try {
			user = (User) request.getSession(false).getAttribute("nowuser");
		} catch (Exception e) {
			model.addAttribute("msg", "请检查登录状况");
			return findtask("", "-1", 1, model);
		}
		int uid = 0;
		try {
			uid = user.getStuid();
			if (user == null || uid == 0) {
				model.addAttribute("msg", "请检查登录状况");
				return findtask("", "-1", 1, model);
			}
		} catch (Exception e) {
			model.addAttribute("msg", "请检查登录状况");
			return findtask("", "-1", 1, model);
		}
		List<Task> list = taskService.getUserTask(uid);
		model.addAttribute("list", list);
		return "userPtask";
	}

	// 用户接受的
	@RequestMapping("getuseratask.do")
	public String getuseratask(HttpServletRequest request, Model model) {
		User user = null;
		try {
			user = (User) request.getSession(false).getAttribute("nowuser");
		} catch (Exception e) {
			model.addAttribute("msg", "请检查登录状况");
			return findtask("", "-1", 1, model);
		}
		int uid = 0;
		try {
			uid = user.getStuid();
			if (user == null || uid == 0) {
				model.addAttribute("msg", "请检查登录状况");
				return findtask("", "-1", 1, model);
			}
		} catch (Exception e) {
			model.addAttribute("msg", "请检查登录状况");
			return findtask("", "-1", 1, model);
		}
		List<Task> list = taskService.getUserATask(uid);
		model.addAttribute("list", list);
		return "userAtask";
	}

	// to3.发布者点击确认
	@RequestMapping("taskok.do")
	public String taskok(String tidstr, HttpServletRequest request, Model model) {
		int tid = 0;
		try {
			tid = Integer.parseInt(tidstr);
		} catch (Exception e) {
			model.addAttribute("msg", "出现错误");
			System.out.println("11111111111");
			return getusertask(request, model);
		}
		if (tid == 0) {
			model.addAttribute("msg", "出现错误");
			System.out.println("22222222222222");
			return getusertask(request, model);
		}
		User user = null;
		try {
			user = (User) request.getSession(false).getAttribute("nowuser");
		} catch (Exception e) {
			model.addAttribute("msg", "请检查登录状况");
			return "login";
		}
		int uid = 0;
		try {
			uid = user.getStuid();
			if (user == null || uid == 0) {
				model.addAttribute("msg", "请检查登录状况");
				return getusertask(request, model);
			}
		} catch (Exception e) {
			model.addAttribute("msg", "请检查登录状况");
			return getusertask(request, model);
		}
		Task theTask = taskService.getTask(tid);
		if (!(uid + "").equals(theTask.getPublishUserId())) {
			model.addAttribute("msg", "出现错误");
			return getusertask(request, model);
		}
		theTask.setState(3);
		User auser = userService.getByUid(theTask.getAcceptUserId());
		auser.setMoney(auser.getMoney()+theTask.getReward());
		
		int ruser = userService.updateUserInfo(auser);
		if (ruser>0) {
			int r = taskService.updateTask(theTask);
			if (r > 0) {
				model.addAttribute("msg", "成功");
			} else {
				model.addAttribute("msg", "失败");
			}
		} else {
			model.addAttribute("msg", "失败，奖励无法到账-请联系管理员");
		}
		
		List<Task> list = taskService.getUserTask(uid);
		model.addAttribute("list", list);
		return "userPtask";
	}

	// to1.发布者点击关闭删除取消
	@RequestMapping("taskclose.do")
	public String taskclose(String tidstr, HttpServletRequest request, Model model) {
		int tid = 0;
		try {
			tid = Integer.parseInt(tidstr);
		} catch (Exception e) {
			model.addAttribute("msg", "出现错误");
			return getusertask(request, model);
		}
		if (tid == 0) {
			model.addAttribute("msg", "出现错误");
			return getusertask(request, model);
		}
		User user = null;
		try {
			user = (User) request.getSession(false).getAttribute("nowuser");
		} catch (Exception e) {
			model.addAttribute("msg", "请检查登录状况");
			return "login";
		}
		int uid = 0;
		try {
			uid = user.getStuid();
			if (user == null || uid == 0) {
				model.addAttribute("msg", "请检查登录状况");
				return getusertask(request, model);
			}
		} catch (Exception e) {
			model.addAttribute("msg", "请检查登录状况");
			return getusertask(request, model);
		}
		Task theTask = taskService.getTask(tid);
		if (!(uid + "").equals(theTask.getPublishUserId())) {
			model.addAttribute("msg", "出现错误");
			return getusertask(request, model);
		}
		theTask.setState(1);
		int r = taskService.updateTask(theTask);
		if (r > 0) {
			user.setMoney(user.getMoney()+theTask.getReward());
			int ruser = userService.updateUserInfo(user);
			if (ruser> 0) {
				model.addAttribute("msg", "成功");
			}else {
				model.addAttribute("msg", "已关闭-奖励未返回，请与管理员联系");
			}
		} else {
			model.addAttribute("msg", "失败");
		}
		List<Task> list = taskService.getUserTask(uid);
		model.addAttribute("list", list);
		return "userPtask";
	}

	// to2.to2.点击接受任务
	@RequestMapping("taskaccept.do")
	public String taskaccept(String tidstr, HttpServletRequest request, Model model) {
		int tid = 0;
		try {
			tid = Integer.parseInt(tidstr);
		} catch (Exception e) {
			model.addAttribute("msg", "出现错误");
			return gettaskinfo(tidstr, request, model);
		}
		if (tid == 0) {
			model.addAttribute("msg", "出现错误");
			return gettaskinfo(tidstr, request, model);
		}
		User user = null;
		try {
			user = (User) request.getSession(false).getAttribute("nowuser");
		} catch (Exception e) {
			model.addAttribute("msg", "请检查登录状况");
			return gettaskinfo(tidstr, request, model);
		}
		int uid = 0;
		try {
			uid = user.getStuid();
			if (user == null || uid == 0) {
				model.addAttribute("msg", "请检查登录状况");
				return gettaskinfo(tidstr, request, model);
			}
		} catch (Exception e) {
			model.addAttribute("msg", "请检查登录状况");
			return gettaskinfo(tidstr, request, model);
		}
		Task theTask = taskService.getTask(tid);
		if ((uid + "").equals(theTask.getPublishUserId())) {
			model.addAttribute("msg", "不能接受自己的任务啊");
			return gettaskinfo(tidstr, request, model);
		}
		theTask.setAcceptUserId(uid);
		theTask.setState(2);
		int r = taskService.updateTask(theTask);
		if (r > 0) {
			model.addAttribute("msg", "成功");
		} else {
			model.addAttribute("msg", "失败");
		}
		return gettaskinfo(tidstr, request, model);
	}

	// 获取任务详细信息
	@RequestMapping("gettaskinfo.do")
	public String gettaskinfo(String tidstr,HttpServletRequest request, Model model) {
		int tid = 0;
		try {
			tid = Integer.parseInt(tidstr);
		} catch (Exception e) {
			model.addAttribute("msg", "出现错误");
			return "taskInfo";
		}
		Task theTask = taskService.getTask(tid);
		model.addAttribute("theTask", theTask);
		return "taskInfo";
	}
	
	//搜索任务
	@RequestMapping("list.do")
	public String findtask(String words, @RequestParam(required=true,defaultValue="-1") String schoolidstr,@RequestParam(required=true,defaultValue="1") Integer page , Model model) {
		
		model.addAttribute("words", words);
		model.addAttribute("schoolidstr", schoolidstr);
		
		int schoolid = -1;
		if (!schoolidstr.equals("-1")) {
			try {
				schoolid = Integer.parseInt(schoolidstr);
			} catch (Exception e) {
				System.err.println("err");
			}
		}
		
		if (words!=null) {
			words="%"+words+"%";
		}

		//这段代码表示，程序开始分页了，page默认值是1，每页记录数（pageSize）默认是3，意思是从第1页开始，每页显示3条记录
		//每页记录数可以自定义
		PageHelper.startPage(page, 6);
		List<Task> list = taskService.getTaskByKeysNoState(words, schoolid);
		PageInfo<Task>pageInfo = new PageInfo<Task>(list); //将集合封装到PageInfo
		//绑定数据，返回给页面
		model.addAttribute("p", pageInfo);
		
		
		return "index";
	}

}
