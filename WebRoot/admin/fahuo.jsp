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
	<title>订单发货</title>
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
	<script type="text/javascript" src="<%=path %>/admin/js/popup.js"></script>
</head>
<body>
<% 
String id = request.getParameter("id");
%>
<section class="layui-larry-box">
	<div class="larry-personal">
		<header class="larry-personal-tit">
			<span>发货</span>
		</header><!-- /header -->
		<div class="larry-personal-body clearfix changepwd">
			<form class="layui-form col-lg-4" id="supplierform" method="post" action="<%=path %>/admin/faHuo.do" onsubmit="return supplieradd()">
			<input type="hidden" name="id" value="<%=id %>"/>
				<div class="layui-form-item">
					<label class="layui-form-label">快递公司</label>
					<div class="layui-input-block" style="width: 300px;">  
					  	<select name="company" id="company" style="width: 300px;"  lay-verify="required"   autocomplete="off"  class="layui-input">
					  	<option value="">请选择类别</option>
					  	<option value="天天快递">天天快递</option>
					  	<option value="圆通快递">圆通快递</option>
					  	<option value="申通快递">申通快递</option>
					  	<option value="韵达快递">韵达快递</option>
					  	<option value="德邦物流">德邦物流</option>
					  	</select>
					</div>
				</div>
			    
				<div class="layui-form-item">
					<label class="layui-form-label">运单号</label>
					<div class="layui-input-block">  
					  	<input type="text" name="waybillno" id="waybillno"  lay-verify="required"  style="width: 300px;"  autocomplete="off"  class="layui-input"  >
					</div>
				</div>
				
				<div class="layui-form-item change-submit">
					<div class="layui-input-block">
						<button class="layui-btn" lay-submit="" id="supplierbutton" lay-filter="demo1" >发货</button>
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

	function up(tt)
	{
			    layer.open({
			      type: 2,
			      title: '上传文件',
			      shadeClose: true,
			      shade: false,
			      maxmin: true, //开启最大化最小化按钮
			      area: ['450px', '200px'],
			      content: '/booksalessm/upload.jsp?Result='+tt
			    });
	}	
</script>
</body>
</html>