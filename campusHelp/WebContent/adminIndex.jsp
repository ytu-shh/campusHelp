<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 引入el表达式 -->
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 后台传过来的时间类型数据经过它格式化 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>管理员中心</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" href="<%=basePath%>layui/css/layui.css">
<c:if test="${empty nowadmin }">
	<script type="text/javascript">
		alert("请先登录");
		window.location.href="<%=basePath%>login.jsp"; 
	</script>
</c:if>
</head>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<div class="layui-header">
			<div class="layui-logo">校园即时服务平台</div>
			<!-- 头部区域（可配合layui已有的水平导航） -->
			<ul class="layui-nav layui-layout-left">
				<li class="layui-nav-item"><a href="adminIndex.jsp">管理员中心</a></li>
				<li class="layui-nav-item"><a href="admin/getusers.do">用户管理</a></li>
				<li class="layui-nav-item"><a href="admin/getschools.do">平台管理</a></li>
			</ul>
			<ul class="layui-nav layui-layout-right">
				<li class="layui-nav-item"><a href="javascript:;">

						${nowadmin.account } </a>
					<dl class="layui-nav-child">
						<dd>
							<a href="adminIndex.jsp">个人信息</a>
						</dd>
						<dd>
							<a href="adminPassword.jsp">安全设置</a>
						</dd>
					</dl></li>
				<li class="layui-nav-item"><a href="common/logout.do">退了</a></li>
			</ul>
		</div>

		<div class="layui-side layui-bg-black">
			<div class="layui-side-scroll">
				<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
				<ul class="layui-nav layui-nav-tree" lay-filter="test">

					<li class="layui-nav-item layui-nav-itemed"><a href="javascript:;">平台管理</a>
						<dl class="layui-nav-child">
							<dd>
								<a href="admin/getschools.do">院校管理</a>
							</dd>
							<dd>
								<a href="admin/gettasks.do">任务管理</a>
							</dd>
						</dl></li>
						
					<li class="layui-nav-item layui-nav-itemed"><a href="javascript:;">用户管理</a>
						<dl class="layui-nav-child">
							<dd>
								<a href="admin/getusers.do">用户维护</a>
							</dd>
						</dl></li>

					<li class="layui-nav-item layui-nav-itemed"><a class=""
						href="javascript:;">管理员中心</a>
						<dl class="layui-nav-child">
							<dd class="layui-this">
								<a href="adminIndex.jsp">个人信息</a>
							</dd>
							<dd>
								<a href="adminPassword.jsp">安全设置</a>
							</dd>
							<dd>
								<a href="adminAddAdmin.jsp">添加管理员</a>
							</dd>
						</dl></li>

				</ul>
			</div>
		</div>
		<!-- 内容主体区域-->
		<div class="layui-body">
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
							<legend>个人信息</legend>
						</fieldset>
					</div>
				</div>

				<div class="layui-row">
					<div class="layui-col-md1">&nbsp;</div>
					<div class="layui-col-md10">
						<fieldset class="layui-elem-field">
							<legend>信息</legend>
							<!--  <div class="layui-field-box">-->
								<table class="layui-table" lay-size="lg" lay-skin="line" style="margin-bottom: 0px;">
									<colgroup>
										<col width="150">
										<col width="200">
										<col>
									</colgroup>
									<thead>
										<tr>
											<th>&nbsp;</th>
											<th>&nbsp;</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>编号</td>
											<td>${nowadmin.aid }</td>
										</tr>
										<tr>
											<td>登录账号</td>
											<td>${nowadmin.account }</td>
										</tr>
										<tr>
											<td>注册时间</td>
											<td><fmt:formatDate value="${nowadmin.addtime }"
													pattern=" yyyy-MM-dd HH:mm:ss" /></td>
										</tr>
										<tr>
											<td>状态</td>
											<td><c:if test="${nowadmin.state==0 }">
												正常
											  </c:if> <c:if test="${nowadmin.state!=0 }">
												被限制
											  </c:if></td>
										</tr>
									</tbody>
								</table>
							<!--</div>-->
						</fieldset>

					</div>
					<div class="layui-col-md1">&nbsp;</div>
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
			©  - 校园即时服务平台
		</div>
	</div>
	<script src="${pageContext.request.contextPath }/layui/layui.all.js"></script>
	<script>
		//JavaScript代码区域
		layui.use('element', function() {
			var element = layui.element;
			//监听导航点击
			element.on('nav(test)', function(elem) {
				//console.log(elem)
				layer.msg(elem.text());
			});
		});
	</script>
</body>
</html>
