<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>图书库存信息</title>
	<meta name="renderer" content="webkit">	
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">	
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">	
	<meta name="apple-mobile-web-app-status-bar-style" content="black">	
	<meta name="apple-mobile-web-app-capable" content="yes">	
	<meta name="format-detection" content="telephone=no">	
	<link rel="stylesheet" type="text/css" href="common/layui/css/layui.css" media="all">
	<link rel="stylesheet" type="text/css" href="common/bootstrap/css/bootstrap.css" media="all">
	<link rel="stylesheet" type="text/css" href="common/global.css" media="all">
	<link rel="stylesheet" type="text/css" href="css/personal.css" media="all">
	<script type="text/javascript" src="/booksalessm/layer/jquery-2.0.3.min.js"></script>
	<style type="text/css">
	 .layui-input-inline li {
	  float: left;
	  }
	</style>
</head>
<body>
<section class="layui-larry-box">
	<div class="larry-personal">
	    <div class="layui-tab">
            <blockquote class="layui-elem-quote news_search">
		
		<div class="layui-inline" style="border:0px solid red;width: 930px;">
			<form class="layui-form" action="<%=path %>/admin/inventoryList.do" method="post" id="searchform" name="searchform" style="padding-top:0px;">
		    <div class="layui-input-inline" style="float: left">
		    	<input value="${key}" placeholder="请输入图书名称" name="key" class="layui-input search_input" type="text">
		    <!-- <input type="submit" class="layui-btn" value="查询"> -->	
		    </div>
		    <!-- 三级联动 -->
		    <div class="layui-input-inline" style="float: left;margin-left: 5px;border:0px solid red;width: 600px;">
		    <ul>
		      <li>
		      <select name="fid"  id="fid" onChange="Change_Select()" lay-filter="fid" style="width: 100px;"   autocomplete="off"  class="layui-input">
		    	  <option value="">请选择类别</option>
					  	<c:forEach items="${ctlist}" var="fcategory">
					  	  <option value="${fcategory.id}">${fcategory.name}</option>
				 </c:forEach>
			  	</select>
		      </li>
		      <li>
		      <select name="cid" id="cid"  lay-filter="cid" style="width: 100px;"   autocomplete="off"  class="layui-input">
			  	 <option value="">请选择上一级类别</option>
			  	</select>
		      </li>
		      
		      <li>
		      <select name="mid" id="mid"  lay-filter="mid" style="width: 100px;"   autocomplete="off"  class="layui-input">
			  	 <option value="">请选择上一级类别</option>
			  	</select>
		      </li>
		    </ul>
			  	
			  	
		    </div>
		    <!-- 三级联动 -->
		    </form>
		    <a class="layui-btn"  href="javascript:void(0)" onclick="searchnew()" style="float: left;margin-left: 5px;">查询</a>
		</div>
		<!--  
	    <div class="layui-inline">
		<a class="layui-btn layui-btn-normal" href="categorySelect.do">添加图书</a>
		</div>
		<div class="layui-inline">
			<a class="layui-btn layui-btn-danger" href="javascript:void(0)" onclick="deleteAll()">批量删除</a>
		</div>
		-->
	</blockquote>
            
		         <!-- 操作日志 -->
                <div class="layui-form news_list" >
                    <table class="layui-table" style="font-size:12px;">
					    <colgroup>
					    <col width="15%">
					    <col width="20%">
						<col width="15%">
						<col width="15%">
						<col width="15%">
						<col width="">
					    </colgroup>
					<thead>
						<tr>
						    <th>图书图片</th>
							<th>图书名称</th>
							<th>图书分类</th>
							<th>图书价格</th>
							<th>库存数量</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody class="news_content" id="userTbody">
					   <c:forEach items="${list}" var="product" varStatus="status">
						<tr >
							<td><img src="<%=path %>/upload/${product.filename}" style="width: 60px;height: 60px;"/></td>
							<td>${product.productname}</td>
							<td>${product.fcategory.name}/${product.ccategory.name}/${product.mcategory.name}</td>
							<td>${product.price}</td>
							<td>${product.inventory.num }</td>
							<td>
							    <a class="layui-btn layui-btn-mini" href="inventoryadd.jsp?productid=${product.id}"><i class="iconfont icon-edit"></i> 入库</a>
							</td>
						</tr>
						</c:forEach>
						<tr>
                    <td align="center" style="font-weight: bold;font-family:楷体;font-weight: bold; color:blue" colspan="10">
                                                                 共${total}条记录&nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="inventoryList.do?index=1" style="font-family:楷体;">首页</a>&nbsp;&nbsp;
                        
                        <c:choose>
                        <c:when test="${index >1}">
                        <a href="inventoryList.do?index=${index-1}" style="font-family:楷体;">上一页</a>
                        </c:when>
                        <c:otherwise>
                        <a href="javascrip:void(0)" style="font-family:楷体;">上一页</a>
                        </c:otherwise>
                        </c:choose>
                        &nbsp;&nbsp;
                        <c:choose>
                        <c:when test="${pages>index}">
                        <a href="inventoryList.do?index=${index+1}" style="font-family:楷体;">下一页</a>
                        </c:when>
                        <c:otherwise>
                        <a href="javascrip:void(0)" style="font-family:楷体;">下一页</a>
                        </c:otherwise>
                        </c:choose>
                        &nbsp;&nbsp;
                        <a href="inventoryList.do?index=${pages}" style="font-family:楷体;">末页</a>
                    </td>
                  </tr>
					</tbody>
					</table>
                     <div class="larry-table-page clearfix">
			         </div>
			    </div>
			     <!-- 登录日志 -->
		    </div>
		</div>
	
</section>
<script type="text/javascript" src="common/layui/layui.js"></script>
<script type="text/javascript" src="js/newslist.js"></script>
<script type="text/javascript">
	layui.use(['jquery','layer','element','laypage'],function(){
	      window.jQuery = window.$ = layui.jquery;
	      window.layer = layui.layer;
          var element = layui.element(),
              laypage = layui.laypage;

            
          laypage({
					cont: 'page',
					pages: 10 //总页数
						,
					groups: 5 //连续显示分页数
						,
					jump: function(obj, first) {
						//得到了当前页，用于向服务端请求对应数据
						var curr = obj.curr;
						if(!first) {
							//layer.msg('第 '+ obj.curr +' 页');
						}
					}
				});

          laypage({
					cont: 'page2',
					pages: 10 //总页数
						,
					groups: 5 //连续显示分页数
						,
					jump: function(obj, first) {
						//得到了当前页，用于向服务端请求对应数据
						var curr = obj.curr;
						if(!first) {
							//layer.msg('第 '+ obj.curr +' 页');
						}
					}
				});
    });

    function searchnew(){
      //${"#searchform"}.submit();
      searchform.submit()
      
    }

    function deleteAll(){

    	layer.confirm('是否确认删除？', {
      	  btn: ['是','否'] //按钮
      	}, function(){

      	  var len = $("input[name='checked']:checked").length;	
      	  if(len!=0){
      	  var checkedbox = $("input[name='checked']:checked");
      	  var arr = new Array();
            $(checkedbox).each(function(i){
                arr[i] = $(this).val();
            });
            var vals = arr.join(",");
            $.ajax({
      		type:"post",
      		url:"productDelAll.do?vals="+vals,
      		date:"",
      		success:function(msg){
      			location.replace("productList.do");
      		  }
            })
      	  }else{
				layer.msg("请选择要删除的项");
          	  }
            
            
      	}, function(){
      	});
	  //var $checkbox = $("input[name='checked']");
	  //var len = $("input[name='checked']:checked").length;
      
    }

function updateFkstatus(id){

	layer.confirm('图书是否付款？', {
    	  btn: ['是','否'] //按钮
    	}, function(){

    		location.replace("/booksalessm/admin/updateFkstatus.do?id="+id);
          
    	}, function(){
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