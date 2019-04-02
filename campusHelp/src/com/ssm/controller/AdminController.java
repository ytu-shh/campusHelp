package com.ssm.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.ssm.po.Admin;
import com.ssm.po.School;
import com.ssm.po.Task;
import com.ssm.po.User;
import com.ssm.service.AdminService;
import com.ssm.service.SchoolService;
import com.ssm.service.TaskService;
import com.ssm.service.UserService;

/**
 * ****管理员功能**** 
 * ------- 
 * 管理员登录 . 
 * 管理员个人信息更新 . 
 * 密码更新 . 
 * 添加管理员 . 
 * ------ 
 * 获取任务列表 .
 * 关闭待解决任务. 
 * ------ 
 * 获取用户列表 . 
 * 读取一个用户. 
 * 添加用户余额. 
 * 解除用户限制 . 
 * 添加用户限制 . 
 * ---------- 
 * 获取学校列表.
 * 读取单个学校信息 . 
 * 更新学校信息 . 
 * 添加院校.
 * 
 * @author
 *
 */
@Controller
@SessionAttributes({ "nowadmin" })
@RequestMapping(value = "admin/")
public class AdminController {

	@Resource(name = "adminService")
	public AdminService adminService;

	@Resource(name = "schoolService")
	public SchoolService schoolService;

	@Resource(name = "taskService")
	public TaskService taskService;

	@Resource(name = "userService")
	public UserService userService;

	// 登录
	@RequestMapping("adminlogin.do")
	public String adminlogin(String account, String password, Model model) {

		Admin admin = null;

		admin = adminService.login(account);

		if (admin == null) {
			model.addAttribute("msg", "登录账号不存在");//
			return "login";
		}

		if (password.equals(admin.getPassword())) {
			model.addAttribute("nowadmin", admin);
			return "adminIndex";
		} else {
			model.addAttribute("msg", "密码验证错误正确");
			return "login";
		}

	}

	// 更新
	@RequestMapping("update.do")
	public String update(HttpServletRequest request, Admin admin, Model model) {
		int r = adminService.updateAdminInfo(admin);
		if (r > 0) {
			model.addAttribute("msg", "更新成功，请重新登录");
			request.getSession(false).removeAttribute("nowadmin");
			return "login";
		}
		model.addAttribute("msg", "更新失败");
		return "adminUpdate";
	}

	// 更新
	@RequestMapping("updatepwd.do")
	public String updatepwd(HttpServletRequest request, String oldpassword, Admin admin, Model model) {
		System.out.println("9999999999999");
		Admin oldadmin = (Admin) request.getSession(false).getAttribute("nowadmin");
		System.out.println("6666666666666");
		System.out.println(oldadmin.getPassword());
		System.out.println(oldpassword);
		if (!oldadmin.getPassword().equals(oldpassword)) {
			model.addAttribute("msg", "原密码错误");
			return "adminPassword";
		}
		int r = adminService.updateAdminInfo(admin);
		if (r > 0) {
			model.addAttribute("msg", "修改成功，请重新登录");
			request.getSession(false).removeAttribute("nowadmin");
			return "login";
		}
		model.addAttribute("msg", "修改失败");
		return "adminPassword";
	}

	@RequestMapping("getadmin.do")
	public String getadmin(String aidstr, HttpServletRequest request, Model model) {
		int aid = 0;
		try {
			aid = Integer.parseInt(aidstr);
		} catch (Exception e) {
			model.addAttribute("msg", "出现错误");
			return "adminInfo";
		}
		if (aid == 0) {
			model.addAttribute("msg", "出现错误");
			return "adminInfo";
		}
		/*
		 * Admin admin = adminService.getByUid(stuid);
		 * model.addAttribute("theuser", user);
		 */
		return "adminInfo";
	}

	@RequestMapping("addadmin.do")
	public String addadmin(String account, HttpServletRequest request, Model model) {

		// 检查账号重复
		int countnum = adminService.getAccountCount(account);
		if (countnum > 0) {
			model.addAttribute("msg", account + "   该账号已经被使用");
			return "adminAddAdmin";
		}

		Admin admin = new Admin(0, account, "123456", account, new Date(), 0);

		int result = adminService.setAdmin(admin);

		if (result <= 0) {
			model.addAttribute("msg", "注册失败");
			return "adminAddAdmin";
		}

		model.addAttribute("msg", "注册成功，可以登录。默认密码：123456");

		return "adminAddAdmin";
	}

	@RequestMapping("gettasks.do")
	public String gettasks(String words, @RequestParam(required = true, defaultValue = "-1") String schoolidstr,
			Model model) {
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
		if (words != null) {
			words = "%" + words + "%";
		} else {
			words = "%%";
		}
		List<Task> list = taskService.getTaskByKeys(words, schoolid);
		model.addAttribute("list", list);
		return "adminTask";
	}

	// to1.管理员点击关闭删除取消
	@RequestMapping("taskclose.do")
	public String taskclose(String tidstr, String words,
			@RequestParam(required = true, defaultValue = "-1") String schoolidstr, HttpServletRequest request,
			Model model) {
		int tid = 0;
		try {
			tid = Integer.parseInt(tidstr);
		} catch (Exception e) {
			model.addAttribute("msg", "出现错误");
			return gettasks(words, schoolidstr, model);
		}
		if (tid == 0) {
			model.addAttribute("msg", "出现错误");
			return gettasks(words, schoolidstr, model);
		}
		Admin admin = null;
		try {
			admin = (Admin) request.getSession(false).getAttribute("nowadmin");
			int uid = 0;
			uid = admin.getAid();
			if (admin == null || uid == 0) {
				model.addAttribute("msg", "请检查登录状况");
				return gettasks(words, schoolidstr, model);
			}
		} catch (Exception e) {
			model.addAttribute("msg", "请检查登录状况");
			return "login";
		}

		Task theTask = taskService.getTask(tid);

		theTask.setState(1);
		int r = taskService.updateTask(theTask);
		if (r > 0) {
			model.addAttribute("msg", "成功");
		} else {
			model.addAttribute("msg", "失败");
		}

		return gettasks(words, schoolidstr, model);
	}

	// 获取用户信息
	@RequestMapping("getusers.do")
	public String getusers(String userstr, Model model) {
		model.addAttribute("keys", userstr);
		if (userstr != null) {
			userstr = "%" + userstr + "%";
		} else {
			userstr = "%%";
		}
		List<User> list = userService.getByLikeNameAccount(userstr);
		model.addAttribute("list", list);
		return "adminUser";
	}

	// 读取一个用户,添加余额时使用
	@RequestMapping("getuser.do")
	public String getuser(String stuidstr, Model model) {
		int stuid = 0;
		try {
			stuid = Integer.parseInt(stuidstr);
		} catch (Exception e) {
			model.addAttribute("msg", "出现错误");
			return "userInfo";
		}
		if (stuid == 0) {
			model.addAttribute("msg", "出现错误");
			return "userInfo";
		}
		User user = userService.getByUid(stuid);
		model.addAttribute("theuser", user);
		return "adminUserMoney";
	}

	// 添加用户余额
	@RequestMapping("addusermoney.do")
	public String addusermoney(String moneystr, String stuidstr, Model model) {
		double money = 0.00;
		try {
			money = Double.parseDouble(moneystr);
		} catch (Exception e) {
			model.addAttribute("msg", "金额出现错误");
			return getuser(stuidstr, model);
		}

		if (stuidstr == null) {
			model.addAttribute("msg", "出现错误");
			return getuser(stuidstr, model);
		} else {
			if (stuidstr.length() == 0) {
				model.addAttribute("msg", "出现错误");
				return getuser(stuidstr, model);
			}
		}
		int stuid = 0;
		try {
			stuid = Integer.parseInt(stuidstr);
			if (stuid == 0) {
				model.addAttribute("msg", "出现错误");
				return getuser(stuidstr, model);
			}
		} catch (Exception e) {
			model.addAttribute("msg", "出现错误");
			return getuser(stuidstr, model);
		}

		User theUser = userService.getByUid(stuid);
		theUser.setMoney(theUser.getMoney() + money);

		int r = userService.updateUserInfo(theUser);
		if (r > 0) {
			model.addAttribute("msg", "修改成功");
		} else {
			model.addAttribute("msg", "修改失败");
		}
		return getuser(stuidstr, model);
	}

	// 解除用户限制
	@RequestMapping("useropen.do")
	public String useropen(String keys, String stuidstr, Model model) {
		if (stuidstr == null) {
			model.addAttribute("msg", "出现错误");
			return getusers(keys, model);
		} else {
			if (stuidstr.length() == 0) {
				model.addAttribute("msg", "出现错误");
				return getusers(keys, model);
			}
		}
		int stuid = 0;
		try {
			stuid = Integer.parseInt(stuidstr);
			if (stuid == 0) {
				model.addAttribute("msg", "出现错误");
				return getusers(keys, model);
			}
		} catch (Exception e) {
			model.addAttribute("msg", "出现错误");
			return getusers(keys, model);
		}

		User theUser = userService.getByUid(stuid);
		theUser.setState(0);

		int r = userService.updateUserInfo(theUser);
		if (r > 0) {
			model.addAttribute("msg", "修改成功");
		} else {
			model.addAttribute("msg", "修改失败");
		}
		return getusers(keys, model);
	}

	// 限制用户
	@RequestMapping("userclose.do")
	public String userclose(String keys, String stuidstr, Model model) {
		if (stuidstr == null) {
			model.addAttribute("msg", "出现错误");
			return getusers(keys, model);
		} else {
			if (stuidstr.length() == 0) {
				model.addAttribute("msg", "出现错误");
				return getusers(keys, model);
			}
		}
		int stuid = 0;
		try {
			stuid = Integer.parseInt(stuidstr);
			if (stuid == 0) {
				model.addAttribute("msg", "出现错误");
				return getusers(keys, model);
			}
		} catch (Exception e) {
			model.addAttribute("msg", "出现错误");
			return getusers(keys, model);
		}

		User theUser = userService.getByUid(stuid);
		theUser.setState(1);

		int r = userService.updateUserInfo(theUser);
		if (r > 0) {
			model.addAttribute("msg", "修改成功");
		} else {
			model.addAttribute("msg", "修改失败");
		}
		return getusers(keys, model);
	}

	// 读取全部院校
	@RequestMapping("getschools.do")
	public String getschools(Model model) {

		List<School> list = schoolService.getAllSchools();

		model.addAttribute("list", list);

		return "adminSchool";
	}

	// 读取一个院校信息
	@RequestMapping("getschool.do")
	public String getschool(String schoolidstr, Model model) {
		if (schoolidstr == null) {
			model.addAttribute("msg", "出现错误");
			return "adminSchoolSetting";
		} else {
			if (schoolidstr.length() == 0) {
				model.addAttribute("msg", "出现错误");
				return "adminSchoolSetting";
			}
		}
		int schoolid = 0;
		try {
			schoolid = Integer.parseInt(schoolidstr);
			if (schoolid == 0) {
				model.addAttribute("msg", "出现错误");
				return "adminSchoolSetting";
			}
		} catch (Exception e) {
			model.addAttribute("msg", "出现错误");
			return getschools(model);
		}

		School theSchool = schoolService.getSchoolByID(schoolid);

		if (theSchool != null) {
			model.addAttribute("theSchool", theSchool);
		} else {
			model.addAttribute("msg", "读取失败");
		}
		return "adminSchoolSetting";
	}

	// 更新院校
	@RequestMapping("updateschool.do")
	public String updateschool(School school, Model model) {

		int r = 0;

		r = schoolService.updateSchool(school);

		if (r > 0) {
			model.addAttribute("msg", "修改成功-刷新页面重新加载显示");
		} else {
			model.addAttribute("msg", "修改失败");
		}

		School theSchool = schoolService.getSchoolByID(school.getSchoolid());

		model.addAttribute("theSchool", theSchool);

		return "adminSchoolSetting";
	}

	// 更新院校
	@RequestMapping("addschool.do")
	public String addschool(String name, Model model) {

		if (name == null) {
			model.addAttribute("msg", "添加失败");
			return "adminSchoolAdd";
		} else {
			if (name.length() == 0) {
				model.addAttribute("msg", "添加失败");
				return "adminSchoolAdd";
			}
		}

		School theSchool = new School(0, name, new Date(), 0);

		int r = 0;

		r = schoolService.setSchool(theSchool);

		if (r > 0) {
			model.addAttribute("msg", "添加成功");
			model.addAttribute("flag", "添加成功");
			return "adminSchoolAdd";
		} else {
			model.addAttribute("msg", "添加失败");
			return "adminSchoolAdd";
		}
	}

	@org.springframework.web.bind.annotation.InitBinder
	public void InitBinder(ServletRequestDataBinder bin) {
		bin.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"), true));
	}

}
