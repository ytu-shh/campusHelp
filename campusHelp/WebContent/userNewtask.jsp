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

<title>发布新任务</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" href="<%=basePath%>layui/css/layui.css">
<c:if test="${empty nowuser }">
	<script type="text/javascript">
		alert("请先登录");
		window.location.href = "<%=basePath%>login.jsp";
	</script>
</c:if>
</head>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<div class="layui-header">
			<div class="layui-logo">校园即时服务平台</div>
			<!-- 头部区域（可配合layui已有的水平导航） -->
			<ul class="layui-nav layui-layout-left">
				<li class="layui-nav-item"><a href="">任务中心</a></li>
				<li class="layui-nav-item"><a href="userIndex.jsp">个人中心</a></li>

			</ul>
			<ul class="layui-nav layui-layout-right">
				<li class="layui-nav-item"><a href="javascript:;">

						${nowuser.name } </a>
					<dl class="layui-nav-child">
						<dd>
							<a href="userIndex.jsp">个人信息</a>
						</dd>
						<dd>
							<a href="userUpdate.jsp">资料修改</a>
						</dd>
						<dd>
							<a href="userPassword.jsp">安全设置</a>
						</dd>
					</dl></li>
				<li class="layui-nav-item"><a href="common/logout.do">退了</a></li>
			</ul>
		</div>

		<div class="layui-side layui-bg-black">
			<div class="layui-side-scroll">
				<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
				<ul class="layui-nav layui-nav-tree" lay-filter="test">

					<li class="layui-nav-item"><a href="">校园即时服务平台</a></li>

					<li class="layui-nav-item layui-nav-itemed"><a
						href="javascript:;">任务管理</a>
						<dl class="layui-nav-child">
							<dd>
								<a href="task/getusertask.do">已发布任务</a>
							</dd>
							<dd>
								<a href="task/getuseratask.do">已接受任务</a>
							</dd>
							<dd class="layui-this">
								<a href="userNewtask.jsp">发布新任务</a>
							</dd>
						</dl></li>

					<li class="layui-nav-item  layui-nav-itemed"><a class=""
						href="javascript:;">个人中心</a>
						<dl class="layui-nav-child">
							<dd>
								<a href="userIndex.jsp">个人信息</a>
							</dd>
							<dd>
								<a href="userUpdate.jsp">资料修改</a>
							</dd>
							<dd>
								<a href="userPassword.jsp">安全设置</a>
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
							<legend>发布新任务</legend>
						</fieldset>
					</div>
				</div>

				<div class="layui-row">
					<div class="layui-col-md1">&nbsp;</div>
					<div class="layui-col-md10">
						<fieldset class="layui-elem-field">
							<legend>填写新任务信息</legend>
							<form id="reform" class="layui-form layui-form-pane"
								lay-filter="formFilter" action="task/newtask.do" method="post"
								style="padding: 30px;">

								<div class="layui-form-item">
									<label class="layui-form-label">任务标题</label>
									<div class="layui-input-block">
										<input type="text" name="taskname" autocomplete="off"
											lay-verify="taskname" placeholder="请输入标题" class="layui-input">
									</div>
								</div>

								<div class="layui-form-item">
									<label class="layui-form-label">奖励</label>
									<div class="layui-input-block">
										<select id="reward" name="reward"
											lay-filter="reward">
											<option value="0" selected="">0</option>
											<option value="1">1</option>
											<option value="2">2</option>
											<option value="5">5</option>
											<option value="10">10</option>
											<option value="20">20</option>
											<option value="30">30</option>
											<option value="50">50</option>
											<option value="70">70</option>
											<option value="80">80</option>
											<option value="100">100</option>
										</select>
									</div>
								</div>

								<div class="layui-form-item layui-form-text">
									<label class="layui-form-label">详细描述</label>
									<div class="layui-input-block">
										<textarea name="taskcontext" placeholder="请输入内容"
											class="layui-textarea" lay-verify="taskcontext"></textarea>
									</div>
								</div>

								<c:if test="${nowuser.state==0 }">
									<div class="layui-form-item">
										<button class="layui-btn" lay-submit="reform"
											lay-filter="reform">发布</button>
									</div>
								</c:if>
								<c:if test="${nowuser.state!=0 }">
									<div class="layui-form-item">
										<button class="layui-btn layui-btn-disabled"
											lay-submit="reform" lay-filter="reform">状态被限制，无法发布</button>
									</div>
								</c:if>

							</form>
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
			©  - 校园即时服务平台办公电话：6666666
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
	<script>
		layui.use([ 'form', 'layedit', 'laydate' ], function() {
			var form = layui.form,
				layer = layui.layer,
				layedit = layui.layedit,
				laydate = layui.laydate;
	
			//自定义验证规则
			form.verify({
				taskname : function(value) {
					if (value.length < 2) {
						return '标题太短了啊';
					}
				},
				reward : function(value) {
					if (value.length <= 0) {
						return '请输入奖励内容';
					}
				},
				taskcontext : function(value) {
					if (value.length < 1) {
						return '任务详细描述太短';
					}
				}
			});
	
			//创建一个编辑器  
			layedit.build('LAY_demo_editor');
	
			//监听提交
			form.on('submit(reform)', function(data) {
				/*layer.alert(JSON.stringify(data.field), {
					title : '最终的提交信息'
				})*/
				//return false;
			});
	
	
		});
	</script>
</body>
</html>
