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
	<title>新增用户</title>
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
			<span>新增用户</span>
		</header><!-- /header -->
		<div class="larry-personal-body clearfix changepwd">
			<form class="layui-form col-lg-4" id="userform" method="post" action="<%=path %>/admin/userAdd.do" onsubmit="return useradd()">
			
			 	<div class="layui-form-item">
					<label class="layui-form-label">用户名</label>
					<div class="layui-input-block">  
					  	<input type="text" name="username" id="username" onblur="usernameCheck()" required oninvalid="setCustomValidity('用户名不能为空')" oninput="setCustomValidity('');"  style="width: 300px;"  autocomplete="off"  class="layui-input" placeholder="用户名" >
					</div>
				</div>
				
				<div class="layui-form-item">
					<label class="layui-form-label">密码</label>
					<div class="layui-input-block">  
					  	<input type="password" name="userpassword" id="userpassword" required oninvalid="setCustomValidity('密码不能为空')" oninput="setCustomValidity('');"  style="width: 300px;"   autocomplete="off"  class="layui-input" placeholder="密码" >
					</div>
				</div>
				
				<div class="layui-form-item">
					<label class="layui-form-label">姓名</label>
					<div class="layui-input-block">  
					  	<input type="text" name="realname" id="realname" required oninvalid="setCustomValidity('姓名不能为空')" oninput="setCustomValidity('');"  style="width: 300px;"  autocomplete="off"  class="layui-input" placeholder="姓名" >
					</div>
				</div>
				
				
				<div class="layui-form-item">
					<label class="layui-form-label">性别</label>
					<div class="layui-input-inline" style="width: 295px; ">
						<select name="sex" class="newsLook" lay-filter="browseLook" >
				        	<option value="男">男</option>
				        	<option value="女">女</option>
				    	</select>
					</div>
				</div>
				
				
				<div class="layui-form-item">
					<label class="layui-form-label">电话</label>
					<div class="layui-input-block">  
					  	<input type="number" name="tel" id="tel" required oninvalid="setCustomValidity('电话不能为空')" oninput="setCustomValidity('');" style="width: 300px;"  autocomplete="off"  class="layui-input" placeholder="电话" >
					</div>
				</div>
				
				
				
				<div class="layui-form-item change-submit">
					<div class="layui-input-block">
					    
						<button class="layui-btn" lay-submit="" id="userbutton" lay-filter="demo1" >立即提交</button>
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


	function usernameCheck(){
		var username = $("#username").val();
		$.ajax({
			type: "POST",   
	        url: "usernameCheck.do", //servlet的名字     
	        data: "username="+username,
	        success:function(msg){
	            if(msg==0){
	                }else{
	                	layer.msg("已被使用的用户名");
	                	$("#username").val("");
	                    }
	        }
			})
	}
</script>
</body>
</html>