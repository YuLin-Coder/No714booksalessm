<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>个人信息</title>
	<meta name="renderer" content="webkit">	
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">	
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">	
	<meta name="apple-mobile-web-app-status-bar-style" content="black">	
	<meta name="apple-mobile-web-app-capable" content="yes">	
	<meta name="format-detection" content="telephone=no">	
	<link rel="stylesheet" type="text/css" href="<%=path %>/admin/common/layui/css/layui.css" media="all">
	<link rel="stylesheet" type="text/css" href="<%=path %>/admin/common/bootstrap/css/bootstrap.css" media="all">
	<link rel="stylesheet" type="text/css" href="<%=path %>/admin/common/global.css" media="all">
	<link rel="stylesheet" type="text/css" href="<%=path %>/admin/css/personal.css" media="all">
	<script type="text/javascript" src="<%=path %>/layer/jquery-2.0.3.min.js"></script>
	<script type="text/javascript" src="<%=path %>/layer/layer.js"></script>
</head>
<body>
<section class="layui-larry-box">
	<div class="larry-personal">
		<header class="larry-personal-tit">
			<span>修改密码</span>
		</header><!-- /header -->
		<div class="larry-personal-body clearfix changepwd">
			<form class="layui-form col-lg-4" id="pwdform" method="post" action="<%=path %>/admin/updatepwd.do">
			<input type="hidden"  name="id"  id="id" value="${admin.id}"/>
			 	<div class="layui-form-item">
					<label class="layui-form-label">旧密码</label>
					<div class="layui-input-block">  
					  	<input type="password" name="oldpassword" id="oldpassword" required  style="width: 300px;"  autocomplete="off"  class="layui-input" placeholder="旧密码" >
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">新密码</label>
					<div class="layui-input-block">  
					  	<input type="password" name="userpassword" id="userpassword" required style="width: 300px;"  autocomplete="off"  class="layui-input"  placeholder="新密码">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">确认密码</label>
					<div class="layui-input-block">  
					  	<input type="password" name="rnewpassword" id="rnewpassword" required  style="width: 300px;" autocomplete="off"  class="layui-input"  placeholder="重复新密码">
					</div>
				</div>
				
				
				
				
				<div class="layui-form-item change-submit">
					<div class="layui-input-block">
					    
						<button class="layui-btn" lay-submit="" id="pwdbutton" lay-filter="demo1" >立即提交</button>
						<button type="reset" class="layui-btn layui-btn-primary">重置</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</section>
<script type="text/javascript" src="<%=path %>/admin/common/layui/layui.js"></script>
<script type="text/javascript">
	layui.use(['form','upload'],function(){
         var form = layui.form();
	});


		
		$("#rnewpassword").blur(function(){
		if($("#rnewpassword").val()!=$("#userpassword").val()){
			layer.msg("确认密码错误");
			$("#rnewpassword").val("");
			$("#userpassword").val("");
			}
		})
		
		$("#pwdbutton").click(function(){
			if($("#oldpassword").val()==""){
					layer.msg("旧密码不能为空");
				}
			if($("#userpassword").val()==""){
				layer.msg("新密码不能为空");
			}
			if($("#rnewpassword").val()==""){
				layer.msg("确认密码不能为空");
			}
			if($("#oldpassword").val()!=""&&$("#rnewpassword").val()!=""&&$("#userpassword").val()!=""){
					$("#pwdform").submit();
				}
			})
		
		
		
</script>
<c:if test="${suc !=null&&suc ne '' }">
<script type="text/javascript">
layer.msg("${suc}");
</script>
</c:if>
<c:if test="${ error!=null&&error ne '' }">
<script type="text/javascript">
layer.msg("${error}");
</script>
</c:if>
</body>
</html>