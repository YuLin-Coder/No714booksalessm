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
	<title>类别信息</title>
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
	<script type="text/javascript" src="/booksalessm/layer/jquery-2.0.3.min.js"></script>
	
	<link href="/booksalessm/admin/treetable/skin/jquery.treetable.css" rel="stylesheet" type="text/css" />
	<link href="/booksalessm/admin/treetable/skin/jquery.treetable.theme.default.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="/booksalessm/admin/treetable/js/jquery.treetable.js"></script>
	<script type="text/javascript">
	$(function(){
		$("#lanmu tr").each(function(){
	        if($(this).attr("parentid")!=0){
	        $(this).attr("data-tt-parent-id",$(this).attr("parentid"));
	        }
	    })
	    $("#lanmu").treetable({ expandable: true }).treetable("expandAll");

	})
	</script>
</head>
<body>
<section class="layui-larry-box">
	<div class="larry-personal">
	    <div class="layui-tab">
            <blockquote class="layui-elem-quote news_search">
		
	   <div class="layui-inline">
		<a class="layui-btn layui-btn-normal" href="categoryadd.jsp?type=father&fatherid=1">添加类别</a>
		</div>
	</blockquote>
            
		         <!-- 操作日志 -->
                <div class="layui-form news_list" >
                    <table id="lanmu" class="layui-table" style="font-size:12px;">
					    <colgroup>
					    <col width="35%">
					    <col width="35%">
						<col width="">
					    </colgroup>
					<tbody class="news_content" id="userTbody">
					
					
					   <c:forEach items="${list}" var="category" varStatus="status">
						<tr data-tt-id='${category.id}'  parentid="${category.fatherid}">
							<td>
							<span class='${category.leaf ==0 ? "folder":"file"}'><a title="" href="">${category.name}</a></span>
							<c:if test="${category.fatherid ==0}">
								<a title="${category.id}" type="button" class="action-button" href="categorychildadd.jsp?fatherid=${category.id}&type=leaf" style="font-size: 8px;"><img src="images/add.gif"></a>
								<a title="${category.id}" type="button" class="action-button" href="showCategory.do?id=${category.id}" style="font-size: 8px;"><img src="images/icon_import.gif"> </a> 
								<c:if test="${category.leaf==1}">
								<a lanmuid='' title="删除" class="btn-lanmu-delete action-button" type='button' href="javascript:del('${category.id}');"><img src="images/del.gif"></a>
								</c:if>
							</c:if>
							</td>
						</tr>
						
						<c:forEach items="${category.childlist}" var="childcategory" varStatus="status">
						<tr data-tt-id='${childcategory.id}'  parentid="${childcategory.fatherid}">
							<td>
							<span class='${childcategory.leaf ==0 ? "folder":"file"}'><a title="" href="">${childcategory.name}</a></span>
								<a title="${childcategory.id}" type="button" class="action-button" href="categorychildadd.jsp?fatherid=${childcategory.id}&type=leaf" style="font-size: 8px;"><img src="images/add.gif"></a>
								<a title="${childcategory.id}" type="button" class="action-button" href="showCategory.do?id=${childcategory.id}" style="font-size: 8px;"><img src="images/icon_import.gif"> </a> 
								<c:if test="${childcategory.leaf==1}">
								<a lanmuid='${mincategory.id}' title="删除" class="btn-lanmu-delete action-button" type='button' href="javascript:del('${childcategory.id}');"><img src="images/del.gif"></a>
								</c:if>
							</td>
						</tr>
						
						
						<c:forEach items="${childcategory.minlist}" var="mincategory" varStatus="status">
						<tr data-tt-id='${mincategory.id}'  parentid="${mincategory.fatherid}">
							<td>
							<span class='${mincategory.leaf ==0 ? "folder":"file"}'><a title="" href="">${mincategory.name}</a></span>
							<c:if test="${mincategory.leaf ==1}">
								<a title="编辑" type="button" class="action-button" href="showCategory.do?id=${mincategory.id}" style="font-size: 8px;"><img src="images/icon_import.gif"> </a> 
							</c:if>
							<a lanmuid='${mincategory.id}' title="删除" class="btn-lanmu-delete action-button" type='button' href="javascript:del('${mincategory.id}');"><img src="images/del.gif"></a>
							</td>
						</tr>
						</c:forEach>
						
						</c:forEach>
						
					</c:forEach>
					
						
					</tbody>
					</table>
                     <div class="larry-table-page clearfix">
			         </div>
			    </div>
			     <!-- 登录日志 -->
		    </div>
		</div>
	
</section>
<script type="text/javascript" src="<%=path %>/admin/common/layui/layui.js"></script>
<script type="text/javascript" src="<%=path %>/admin/js/newslist.js"></script>
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

    

function del(categoryid){
    location.replace('categoryDel.do?id='+categoryid);
}
</script>
</body>
</html>