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
	<title>设置会员等级</title>
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
	<script type="text/javascript" src="<%=path %>/admin/layer/jquery-2.0.3.min.js"></script>
	<script type="text/javascript" src="<%=path %>/admin/layer/layer.js"></script>
</head>
<body>
<section class="layui-larry-box">
	<div class="larry-personal">
		<header class="larry-personal-tit">
			<span>设置会员等级</span>
		</header><!-- /header -->
		<div class="larry-personal-body clearfix changepwd">
			<form class="layui-form col-lg-4" id="userform" method="post" action="<%=path %>/admin/levUpate.do">
			<input type="hidden" name="id" value="${member.id}">
				
				
				
				<div class="layui-form-item">
					<label class="layui-form-label">会员等级</label>
					<div class="layui-input-inline" style="width: 300px; ">
						<select name="lev" class="newsLook" lay-filter="browseLook" style="width: 300px; ">
				        	<option value="普通会员" <c:if test="${member.lev eq '普通会员' }">selected</c:if>>普通会员</option>
				        	<option value="高级会员" <c:if test="${member.lev eq '高级会员' }">selected</c:if>>高级会员</option>
				        	<option value="超级会员" <c:if test="${member.lev eq '超级会员' }">selected</c:if>>超级会员</option>
				    	</select>
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
</script>
</body>
</html>