<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>登录</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/layui/css/layui.css">
</head>

<body>
	<div class="layui-layout layui-layout-admin">
		<div class="layui-header">
			<div class="layui-logo">校园即时服务平台</div>
			<!-- 头部区域（可配合layui已有的水平导航） -->
			<ul class="layui-nav layui-layout-left">
				<li class="layui-nav-item"><a href="">任务中心</a></li>
			</ul>
			<ul class="layui-nav layui-layout-right">
				<li class="layui-nav-item"><a href="register.jsp">注册</a></li>
				<li class="layui-nav-item"><a href="login.jsp">登录</a></li>
			</ul>
		</div>

		<div class="layui-side layui-bg-black">
			<div class="layui-side-scroll">
				<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
				<ul class="layui-nav layui-nav-tree" lay-filter="test">
					<li class="layui-nav-item layui-this"><a href="">校园即时服务平台</a></li>
				</ul>
			</div>
		</div>

		<!-- 内容主体区域-->
		<div class="layui-body ">

			<div style="padding: 30px;" class="layui-fluid">
				<div class="layui-row">
					<div class="layui-col-md12">
						<span class="layui-badge-dot"></span> <span
							class="layui-badge-dot layui-bg-orange"></span> <span
							class="layui-badge-dot layui-bg-green"></span> <span
							class="layui-badge-dot layui-bg-cyan"></span> <span
							class="layui-badge-dot layui-bg-blue"></span> <span
							class="layui-badge-dot layui-bg-black"></span> <span
							class="layui-badge-dot layui-bg-gray"></span>
						<fieldset class="layui-elem-field layui-field-title"
							style="margin-top: 30px;">
							<legend>登录</legend>
						</fieldset>
					</div>
				</div>

				<div class="layui-row">
					<div class="layui-col-md3">&nbsp;</div>
					<div class="layui-col-md6">
						<fieldset class="layui-elem-field">
							<legend>输入信息</legend>
							<div class="layui-field-box">
								<div class="layui-tab">
									<ul class="layui-tab-title">
										<li class="layui-this">普通用户登录</li>
										<li>管理员登录</li>
									</ul>
									<div class="layui-tab-content">
										<div class="layui-tab-item layui-show">
											<form id="loginform" class="layui-form layui-form-pane"
												action="user/login.do" method="post">

												<div class="layui-form-item">
													<label class="layui-form-label">学号</label>
													<div class="layui-input-inline">
														<input type="text" name="studentid" lay-verify="studentid"
															placeholder="请输入" autocomplete="off" class="layui-input">
													</div>
												</div>

												<div class="layui-form-item">
													<label class="layui-form-label">密码</label>
													<div class="layui-input-inline">
														<input type="password" name="password" placeholder="请输入密码"
															lay-verify="password" autocomplete="off"
															class="layui-input">
													</div>
													<div class="layui-form-mid layui-word-aux">请务必记住密码</div>
												</div>

												<div class="layui-form-item">
													<button class="layui-btn" lay-submit="loginform"
														lay-filter="loginform">登录</button>
												</div>

											</form>
										</div>
										<div class="layui-tab-item">
											<form id="adminform" class="layui-form layui-form-pane"
												action="admin/adminlogin.do" method="post">

												<div class="layui-form-item">
													<label class="layui-form-label">管理员账号</label>
													<div class="layui-input-inline">
														<input type="text" name="account" lay-verify="account"
															placeholder="请输入" autocomplete="off" class="layui-input">
													</div>
												</div>

												<div class="layui-form-item">
													<label class="layui-form-label">密码</label>
													<div class="layui-input-inline">
														<input type="password" name="password" placeholder="请输入密码"
															lay-verify="password" autocomplete="off"
															class="layui-input">
													</div>
												</div>

												<div class="layui-form-item">
													<button class="layui-btn" lay-submit="adminform"
														lay-filter="adminform">登录</button>
												</div>

											</form>
										</div>
									</div>
								</div>

							</div>
						</fieldset>
					</div>
				</div>
			</div>
		</div>

		<c:if test="${!empty msg }">
			<script type="text/javascript">
				alert("${msg }");
			</script>
		</c:if>

		<div class="layui-footer">
			<!-- 底部固定区域 -->
			©  - 校园即时服务平台办公电话：6666666
		</div>
	</div>

</body>

<script src="${pageContext.request.contextPath }/layui/layui.all.js"></script>
<script>
	layui.use([ 'form', 'laydate' ], function() {
		var form = layui.form,
			layer = layui.layer,
			laydate = layui.laydate;

		//日期
		laydate.render({
			elem : '#date'
		});
		laydate.render({
			elem : '#date1'
		});

		//自定义验证规则
		form.verify({
			studentid : function(value) {
				if (value.length < 5) {
					return '学号至少是得5个字符的啊';
				}
			},
			account : function(value) {
				if (value.length < 5) {
					return '账号至少是得5个字符的啊';
				}
			},
			password : [ /(.+){6,12}$/, '密码是6到12位的哦' ]
		});

		//监听提交
		form.on('submit(loginform)', function(data) {
			/*layer.alert(JSON.stringify(data.field), {
				title : '最终的提交信息'
			})*/
		//return false;
		});
		
		//监听提交
		form.on('submit(adminform)', function(data) {
			/*layer.alert(JSON.stringify(data.field), {
				title : '最终的提交信息'
			})*/
			//return false;
		});

	});
</script>

</html>
