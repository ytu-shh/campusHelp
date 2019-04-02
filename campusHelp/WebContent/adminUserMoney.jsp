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

<title>添加余额</title>
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
				<fieldset class="layui-elem-field layui-field-title"
					style="margin-top: 30px;">
					<legend>添加余额</legend>
				</fieldset>
			</div>
		</div>

		<div class="layui-row">
			<div class="layui-col-md12">
				<fieldset class="layui-elem-field">
					<legend>信息</legend>
					<div class="layui-field-box">
						<table class="layui-table"  lay-skin="line"
							style="margin-bottom: 0px;">
							<colgroup>
								<col width="150">
								<col width="200">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<td>用户编号</td>
									<td>${theuser.stuid }</td>
								</tr>
								<tr>
									<td>用户学号</td>
									<td>${theuser.studentid }</td>
								</tr>
								<tr>
									<td>用户姓名</td>
									<td>${theuser.name }</td>
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
								<tr>
									<td>当前余额</td>
									<td>${theuser.money }</td>
								</tr>
							</tbody>
						</table>
						<c:if test="${empty flag }">
							<form id="formFilter" class="layui-form layui-form-pane"
								style="padding: 30px;" action="admin/addusermoney.do" method="post">
								
								<input type="hidden" name="stuidstr" value="${theuser.stuid }">
								
								<div class="layui-form-item">
									<label class="layui-form-label">添加余额</label>
									<div class="layui-input-block">
										<select id="moneystr" name="moneystr"
											lay-filter="moneystr">
											<option value="5">5</option>
											<option value="10">10</option>
											<option value="20">20</option>
											<option value="30">30</option>
											<option value="50">50</option>
											<option value="100">100</option>
										</select>
									</div>
								</div>
	
								<div class="layui-form-item">
									<button class="layui-btn" lay-submit="saveform"
										lay-filter="saveform">确认添加</button>
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
				moneystr : function(value) {
					if (value.length < 1) {
						return '名字至少得1个字符啊';
					}
				}
			});
	
			//监听提交
			form.on('submit(saveform)', function(data) {
				/*layer.alert(JSON.stringify(data.field), {
					title : '最终的提交信息'
				})
				return false;*/
			});
		});
	</script>

</body>
</html>
