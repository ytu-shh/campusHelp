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

<title>用户信息</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<!--
	<script>
		window.location= "<%=basePath%>";
	</script>
	-->
<link rel="stylesheet" href="<%=basePath%>layui/css/layui.css">
</head>
<body>
	<!-- 内容主体区域-->
	<div class="layui-container">
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
					<legend>该用户信息</legend>
				</fieldset>
			</div>
		</div>

		<div class="layui-row">
			<div class="layui-col-md12">
				<fieldset class="layui-elem-field">
					<legend>信息</legend>
					<!--  <div class="layui-field-box">-->
					<table class="layui-table" lay-size="lg" lay-skin="line"
						style="margin-bottom: 0px;">
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
								<td>用户学号</td>
								<td>${theuser.studentid }</td>
							</tr>
							<tr>
								<td>用户姓名</td>
								<td>${theuser.name }</td>
							</tr>
							<tr>
								<td>学校编号</td>
								<td>${theuser.schoolid }</td>
							</tr>
							<tr>
								<td>用户性别</td>
								<td><c:if test="${theuser.sex==0 }">
												男
											  </c:if> <c:if test="${theuser.sex!=0 }">
												女
											  </c:if></td>
							</tr>
							<tr>
								<td>注册时间</td>
								<td><fmt:formatDate value="${theuser.registertime }"
										pattern=" yyyy-MM-dd HH:mm:ss" /></td>
							</tr>
							<tr>
								<td>用户状态</td>
								<td><c:if test="${theuser.state==0 }">
												正常
											  </c:if> <c:if test="${theuser.state!=0 }">
												被限制
											  </c:if></td>
							</tr>
						</tbody>
					</table>
					<!--</div>-->
				</fieldset>

			</div>
		</div>
	</div>

	<c:if test="${!empty msg }">
		<script type="text/javascript">
			alert("${msg }");
		</script>
	</c:if>
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
