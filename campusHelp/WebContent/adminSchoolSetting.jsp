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

<title>院校设定</title>
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
					<legend>该院校信息</legend>
				</fieldset>
			</div>
		</div>

		<div class="layui-row">
			<div class="layui-col-md12">
				<fieldset class="layui-elem-field">
					<legend>信息</legend>
					<div class="layui-field-box">
						<form id="formFilter" class="layui-form layui-form-pane"
							style="padding: 30px;" action="admin/updateschool.do" method="post">
							
							<input type="hidden" value="${theSchool.schoolid }" name="schoolid">
							
							<div class="layui-form-item">
								<label class="layui-form-label">院校编号</label>
								<div class="layui-input-inline">
									<input type="text" disabled="disabled" name="theschoolid"
										lay-verify="theschoolid" autocomplete="off"
										value="${theSchool.schoolid }" class="layui-input">
								</div>
							</div>

							<div class="layui-form-item">
								<label class="layui-form-label">院校名称</label>
								<div class="layui-input-inline">
									<input type="text" name="name" value="${theSchool.name }"
										lay-verify="oldpassword" autocomplete="off"
										class="layui-input">
								</div>
							</div>

							<div class="layui-form-item" pane="">
								<label class="layui-form-label">状态</label>
								<div class="layui-input-block" id="stateid">
									<c:if test="${theSchool.state==0 }">
										<input type="radio" name="state" value="0" title="正常"
											checked="">
										<input type="radio" name="state" value="1" title="隐藏">
									</c:if>
									<c:if test="${theSchool.state!=0 }">
										<input type="radio" name="state" value="0" title="正常">
										<input type="radio" name="state" value="1" checked=""
											title="隐藏">
									</c:if>
								</div>
							</div>

							<div class="layui-form-item">
								<label class="layui-form-label">添加时间</label>
								<div class="layui-input-inline">
									<input type="text" disabled="disabled" name="addtime"
										lay-verify="addtime" autocomplete="off"
										value="<fmt:formatDate value="${theSchool.addtime }"
													pattern=" yyyy-MM-dd HH:mm:ss" />"
										class="layui-input">
								</div>
							</div>

							<div class="layui-form-item">
								<button class="layui-btn" lay-submit="saveform"
									lay-filter="saveform">保存</button>
							</div>
						</form>
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
				schoolid : function(value) {
					if (value.length < 1) {
						return '学校编号出现错误';
					}
				},
				name : function(value) {
					if (value.length < 1) {
						return '名字至少得1个字符啊';
					}
				},
				state : function(value) {
					if (value.length < 1) {
						return '状态不能为空啊';
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
