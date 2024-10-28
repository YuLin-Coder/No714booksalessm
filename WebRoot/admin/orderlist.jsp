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
	<title>订单信息</title>
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
	<script type="text/javascript" src="/booksalessm/layer/layer.js"></script>
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
		
		<div class="layui-inline">
			<div class="layui-input-inline" style="border:0px solid red;width: 580px;">
		      <form class="layui-form" action="<%=path %>/admin/orderList.do" method="post" id="searchform" name="searchform" style="padding-top:0px;">
		    <div class="layui-input-inline" style="float: left">
		    	<input value="${key}" placeholder="订单编辑或姓名" name="key" class="layui-input search_input" type="text">
		    <!-- <input type="submit" class="layui-btn" value="查询"> -->	
		    </div>
		    <!-- 三级联动 -->
		    <div class="layui-input-inline" style="float: left;margin-left: 5px;border:0px solid red;width: 400px;">
		    <ul>
		      <li>
		      <select name="fkstatus"  id="fkstatus"   style="width: 100px;"   autocomplete="off"  class="layui-input">
		    	  <option value="">请选择付款状态</option>
				  <option value="待付款" ${fkstatus eq '待付款'?"selected":"" }>待付款</option>
				  <option value="已付款" ${fkstatus eq '已付款'?"selected":"" }>已付款</option>
			  	</select>
		      </li>
		      <li>
		        <select name="shstatus" id="shstatus"   style="width: 100px;"   autocomplete="off"  class="layui-input">
			  	 <option value="">请选择发货状态</option>
			  	 <option value="待发货" ${shstatus eq '待发货'?"selected":"" }>待发货</option>
				 <option value="已收货" ${shstatus eq '已收货'?"selected":"" }>已收货</option>
			  	</select>
		      </li>
		    </ul>
		    </div>
		    <!-- 三级联动 -->
		    </form>
		    </div>
		    <a class="layui-btn"  href="javascript:void(0)" onclick="searchnew()" >查询</a>
		</div>
		<div class="layui-inline">
			<a class="layui-btn layui-btn-danger" href="javascript:void(0)" onclick="deleteAll()">批量删除</a>
		</div>
	</blockquote>
            
		         <!-- 操作日志 -->
                <div class="layui-form news_list" >
                    <table class="layui-table" style="font-size:10px;">
					    <colgroup>
					    <col width="6%">
					    <col width="6%">
						<col width="6%">
						<col width="8%">
						<col width="8%">
						<col width="22%">
						<col width="8%">
						<col width="8%">
						<col width="">
					    </colgroup>
					<thead>
						<tr>
						     <th>
						    <input name="" lay-skin="primary" lay-filter="allChoose" id="allChoose" type="checkbox">
						    <div class="layui-unselect layui-form-checkbox" lay-skin="primary"><i class="layui-icon"></i></div>
						    </th>
						    <th>订单编号</th>
						    <th>金额</th>
						    <th>支付方式</th>
						    <th>订单用户</th>
						    <th>收货地址</th>
							<th>是否付款</th>
							<th>是否发货</th>
							<th>物流信息</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody class="news_content" id="userTbody">
					   <c:forEach items="${list}" var="order" varStatus="status">
						<tr >
						    <td>
						    <input name="checked" lay-skin="primary" lay-filter="choose" type="checkbox" value="${order.id}">
						    <div class="layui-unselect layui-form-checkbox" lay-skin="primary"><i class="layui-icon"></i></div>
						    </td>
							<td><a href="orderDetails.do?orderno=${order.orderno}">${order.orderno}</a></td>
							<td>${order.total}</td>
							<td>${order.zffs}</td>
							<td>${order.member.uname}</td>
							<td><font style="font-weight: bold;">地址:&nbsp;&nbsp;</font>${order.address.addr}&nbsp;&nbsp;&nbsp;&nbsp;<font style="font-weight: bold;">${order.address.name}&nbsp;&nbsp;&nbsp;&nbsp;${order.address.tel}</font></td>
							<td>${order.fkstatus}</td>
							<td>${order.shstatus}</td>
							<td>${order.waybillno}<br/>${order.company}</td>
							<td>
							<c:if test="${order.shstatus eq '待发货'}">
							    <a class="layui-btn layui-btn-mini" href="fahuo.jsp?id=${order.id}"><i class="iconfont icon-edit"></i>发货</a>
							</c:if>
							</td>
						</tr>
						</c:forEach>
						<tr>
                    <td align="center" style="font-weight: bold;font-family:楷体;font-weight: bold; color:blue" colspan="11">
                                                                 共${total}条记录&nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="orderList.do?index=1&key=${key}&fkstatus=${fkstatus}&shstatus=${shstatus}" style="font-family:楷体;">首页</a>&nbsp;&nbsp;
                        
                        <c:choose>
                        <c:when test="${index >1}">
                        <a href="orderList.do?index=${index-1}&key=${key}&fkstatus=${fkstatus}&shstatus=${shstatus}" style="font-family:楷体;">上一页</a>
                        </c:when>
                        <c:otherwise>
                        <a href="javascrip:void(0)" style="font-family:楷体;">上一页</a>
                        </c:otherwise>
                        </c:choose>
                        &nbsp;&nbsp;
                        <c:choose>
                        <c:when test="${pages>index}">
                        <a href="orderList.do?index=${index+1}&key=${key}&fkstatus=${fkstatus}&shstatus=${shstatus}" style="font-family:楷体;">下一页</a>
                        </c:when>
                        <c:otherwise>
                        <a href="javascrip:void(0)" style="font-family:楷体;">下一页</a>
                        </c:otherwise>
                        </c:choose>
                        &nbsp;&nbsp;
                        <a href="orderList.do?index=${pages}&key=${key}&fkstatus=${fkstatus}&shstatus=${shstatus}" style="font-family:楷体;">末页</a>
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
      		url:"orderDelAll.do?vals="+vals,
      		date:"",
      		success:function(msg){
      			location.replace("orderList.do");
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


</script>
</body>
<c:if test="${msg eq 'msg'}">
  <script type="text/javascript">
  layer.msg("库存不足，发货失败");
   
  </script>
</c:if>
</html>