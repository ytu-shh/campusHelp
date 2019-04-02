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

<title>添加院校</title>
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
					<legend>添加院校</legend>
				</fieldset>
			</div>
		</div>

		<div class="layui-row">
			<div class="layui-col-md12">
				<fieldset class="layui-elem-field">
					<legend>信息</legend>
					<div class="layui-field-box">
						<c:if test="${empty flag }">
							<form id="formFilter" class="layui-form layui-form-pane"
								style="padding: 30px;" action="admin/addschool.do" method="post">
								
								<div class="layui-form-item">
									<label class="layui-form-label">院校名称</label>
									<div class="layui-input-inline">
										<input type="text" name="name" value="${theSchool.name }"
											lay-verify="name" autocomplete="off"
											class="layui-input">
									</div>
								</div>
	
								<div class="layui-form-item">
									<button class="layui-btn" lay-submit="saveform"
										lay-filter="saveform">保存</button>
								</div>
							</form>
						</c:if>
						<c:if test="${!empty flag }">
							<h1>添加成功-刷新页面加载显示</h1>
						</c:if>
					</div>
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
	<script>
		var form;
		layui.use([ 'form', 'layedit', 'laydate' ], function() {
			var layer = layui.layer,
				laydate = layui.laydate;
			form = layui.form;
	
			//日期
			laydate.render({
				elem : '#date'
			});
			laydate.render({
				elem : '#date1'
			});
	
			//自定义验证规则
			form.verify({
				name : function(value) {
					if (value.length < 1) {
						return '名字至少得1个字符啊';
					}
				}
			});
	
			//监听提交
			form.on('submit(saveform)', function(data) {
				/*layer.alert(JSON.stringify(data.field), {
					title : '最终的提交信息'
				})*/
				//return false;

			});
		});
	</script>

</body>
</html>
