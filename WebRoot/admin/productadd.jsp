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
	<title>新增图书</title>
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
	
<link rel="stylesheet" href="../themes/default/default.css" />
<link rel="stylesheet" href="../plugins/code/prettify.css" />
<script charset="utf-8" src="../plugins/code/prettify.js"></script>
<script charset="utf-8" src="/booksalessm/kindeditor/kindeditor-all.js"></script>
<script charset="utf-8" src="/booksalessm/kindeditor/lang/zh-CN.js"></script>
<script>
KindEditor.ready(function(K) {
window.editor = K.create('#editor_id');
});
</script>
<script>
KindEditor.ready(function(K) {
K.create('textarea[name="content"]', {
uploadJson : '/booksalessm/kindeditor/jsp/upload_json.jsp',
fileManagerJson : '/booksalessm/kindeditor/jsp/file_manager_json.jsp',
allowFileManager : true,
allowImageUpload : true, 
autoHeightMode : true,
afterCreate : function() {this.loadPlugin('autoheight');},
afterBlur : function(){ this.sync(); }  //Kindeditor下获取文本框信息
});
});
</script>
</head>
<body>
<section class="layui-larry-box">
	<div class="larry-personal">
		<header class="larry-personal-tit">
			<span>新增图书</span>
		</header><!-- /header -->
		<div class="larry-personal-body clearfix changepwd">
			<form class="layui-form col-lg-4" id="supplierform" method="post" action="<%=path %>/admin/productAdd.do" onsubmit="return supplieradd()">
			
				<div class="layui-form-item">
					<label class="layui-form-label">图书名称</label>
					<div class="layui-input-block">  
					  	<input type="text" name="productname" id="productname" lay-verify="required"   style="width: 300px;"  autocomplete="off"  class="layui-input" placeholder="图书名称" >
					</div>
				</div>
			    
			 	<div class="layui-form-item">
					<label class="layui-form-label">图片</label>
					<div class="layui-input-block">  
					  	<input name='filename' type='text' class="layui-input" lay-verify="required"  style="width: 300px;" id='url'  size='50' value='' />&nbsp;<input type='button' value='上传'  class="layui-input" onClick="up('url')" style="width: 60px;height: 37px;"/>
					</div>
				</div>
				
				<div class="layui-form-item">
					<label class="layui-form-label">图书一级类别</label>
					<div class="layui-input-block" style="width: 300px;">  
					  	<select name="fid" id="fid" style="width: 300px;" onChange="Change_Select()" lay-verify="required" lay-filter="fid"  autocomplete="off"  class="layui-input">
					  	<option value="">请选择类别</option>
					  	<c:forEach items="${list}" var="fcategory">
					  	  <option value="${fcategory.id}">${fcategory.name}</option>
					  	</c:forEach>
					  	</select>
					</div>
				</div>
				
				<div class="layui-form-item">
					<label class="layui-form-label">图书二级类别</label>
					<div class="layui-input-block" style="width: 300px;">  
					  	<select name="cid" id="cid" style="width: 300px;"   lay-verify="required" lay-filter="cid"  autocomplete="off"  class="layui-input">
					  	  <option value="">请选择上一级类别</option>
					  	</select>
					</div>
				</div>
				
				<div class="layui-form-item">
					<label class="layui-form-label">图书三级类别</label>
					<div class="layui-input-block" style="width: 300px;">  
					  	<select name="mid" id="mid" style="width: 300px;" lay-verify="required" lay-filter="mid"   autocomplete="off"  class="layui-input">
					  	  <option value="">请选择上一级类别</option>
					  	</select>
					</div>
				</div>
				
				<div class="layui-form-item">
					<label class="layui-form-label">图书单价</label>
					<div class="layui-input-block">  
					  	<input type="text" name="price" id="price" required oninvalid="setCustomValidity('图书单价不能为空或价格输入有误')" oninput="setCustomValidity('');"  pattern="(0|[1-9][0-9]{0,9})(\.[0-9]{1,2})?" style="width: 300px;"  autocomplete="off"  class="layui-input" placeholder="图书单价" >
					</div>
				</div>
				
				<div class="layui-form-item">
					<label class="layui-form-label">作者</label>
					<div class="layui-input-block">  
					  	<input type="text" name="author" id="author" lay-verify="required" oninvalid="setCustomValidity('作者不能为空')" oninput="setCustomValidity('');"  style="width: 300px;"  autocomplete="off"  class="layui-input" placeholder="作者" >
					</div>
				</div>
				
				<div class="layui-form-item">
					<label class="layui-form-label">出版社</label>
					<div class="layui-input-block">  
					  	<input type="text" name="press" id="press" lay-verify="required" oninvalid="setCustomValidity('出版社不能为空')" oninput="setCustomValidity('');"  style="width: 300px;"  autocomplete="off"  class="layui-input" placeholder="出版社" >
					</div>
				</div>
				
				<div class="layui-form-item">
					<label class="layui-form-label">图书介绍</label>
					<div class="layui-input-block">  
					  	<textarea id="editor_id" name="content" style="width: 600;height: 280px;" placeholder="请输入图书介绍" lay-verify="required" class="layui-textarea" oninvalid="setCustomValidity('图书介绍不能为空')" oninput="setCustomValidity('');" ></textarea>
					</div>
				</div>
				
				
				
				<div class="layui-form-item change-submit">
					<div class="layui-input-block">
					    
						<button class="layui-btn" lay-submit="" id="supplierbutton" lay-filter="demo1" >立即提交</button>
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



	layui.use(['form','upload'],function(){
        var form = layui.form();
        form.on('select(fid)',function(){
			var fid = $("#fid").val();
			$.ajax({
	        	  url:"searchCtype.do?fid="+fid,
	        	  datetype:"json",
	        	  type:"post",
	        	  contentType: "application/Json; charset=UTF-8",
	        	  success:function(msg){
		        	  $("#cid").empty();
		        	  //key2.append("<option value=\"\">请选择</option>");
		        	  $("#cid").append(msg);
					  form.render('select'); 
	  		  }
	  		});
		    
        })






        layui.use(['form','upload'],function(){
        	var form = layui.form();
        	 form.on('select(cid)',function(){
     			var cid = $("#cid").val();
     			$.ajax({
     	        	  url:"searchCtype.do?fid="+cid,
     	        	  datetype:"json",
     	        	  type:"post",
     	        	  contentType: "application/Json; charset=UTF-8",
     	        	  success:function(msg){
     	        		  $("#mid").empty();
     	        		 // $("#mid").html(msg);
     		        	  $("#mid").append(msg);
     					  form.render('select'); 
     	  		  }
     	  		});
     		    
             })
		    
        })

        
	});
</script>
</body>
</html>