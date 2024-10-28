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
	<title>网上书城</title>
	<meta name="renderer" content="webkit">	
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">	
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">	
	<meta name="apple-mobile-web-app-status-bar-style" content="black">	
	<meta name="apple-mobile-web-app-capable" content="yes">	
	<meta name="format-detection" content="telephone=no">	
	<!-- load css -->
	<link rel="stylesheet" type="text/css" href="<%=path %>/admin/common/layui/css/layui.css" media="all">
	<link rel="stylesheet" type="text/css" href="<%=path %>/admin/common/global.css" media="all">
	<link rel="stylesheet" type="text/css" href="<%=path %>/admin/css/adminstyle.css" media="all">
	
	
</head>
<body>
	<!-- 顶部区域 -->
	<!-- 左侧侧边导航开始 -->
	<div class="layui-side layui-side-bg layui-larry-side" id="larry-side">
        <div class="layui-side-scroll" id="larry-nav-side" lay-filter="side">
		
		<!-- 左侧菜单 -->
		<ul class="layui-nav layui-nav-tree">
			<li class="layui-nav-item layui-this">
				<a href="javascript:;" data-url="main.html">
				    <i class="iconfont icon-home1" data-icon='icon-home1'></i>
					<span>后台首页</span>
				</a>
			</li>
			<!-- 个人信息 -->
			<li class="layui-nav-item">
				<a href="javascript:;">
					<i class="iconfont icon-jiaoseguanli" ></i>
					<span>我的面板</span>
					<em class="layui-nav-more"></em>
				</a>
				<dl class="layui-nav-child">
                    <dd>
                        <a href="javascript:;" data-url="grInfo.do">
                            <i class="iconfont icon-geren1" data-icon='icon-geren1'></i>
                            <span>个人信息</span>
                        </a>
                    </dd>
                    <dd>
                        <a href="javascript:;" data-url="updatepwd.jsp">
                            <i class="iconfont icon-iconfuzhi01" data-icon='icon-iconfuzhi01'></i>
                            <span>修改密码</span>
                        </a>
                    </dd>
                </dl>
			</li>
			
			<li class="layui-nav-item">
					<a href="javascript:;">
					   <i class="iconfont icon-wenzhang1" ></i>
					   <span>内容管理</span>
					   <em class="layui-nav-more"></em>
					</a>
					   <dl class="layui-nav-child">
					   <c:if test="${sessionScope.admin.usertype eq '管理员'}"> 
					          <dd>
					    		<a href="javascript:;" data-url="showAbout.do?id=1">
					    		   <i class="iconfont icon-wenzhang2" data-icon='icon-pinglun1'></i>
					    		   <span>关于我们</span>
					    		</a>
					    	 </dd>
					         <dd>
					    		<a href="javascript:;" data-url="pictureList.do">
					    		   <i class="iconfont icon-wenzhang2" data-icon='icon-pinglun1'></i>
					    		   <span>滚动图片</span>
					    		</a>
					    	 </dd>
					    	 <dd>
					    		<a href="javascript:;" data-url="newsList.do">
					    		   <i class="iconfont icon-wenzhang2" data-icon='icon-pinglun1'></i>
					    		   <span>新闻管理</span>
					    		</a>
					    	 </dd>
					         <dd>
					    		<a href="javascript:;" data-url="categoryList.do">
					    		   <i class="iconfont icon-wenzhang2" data-icon='icon-pinglun1'></i>
					    		   <span>图书类别</span>
					    		</a>
					    	 </dd>
					    	<dd>
					    		<a href="javascript:;" data-url="productList.do">
					    		   <i class="iconfont icon-wenzhang2" data-icon='icon-pinglun1'></i>
					    		   <span>图书管理</span>
					    		</a>
					    	</dd>
					    </c:if>
					    <c:if test="${sessionScope.admin.usertype eq '管理员' ||sessionScope.admin.usertype eq '用户'}">
					    	<dd>
					    		<a href="javascript:;" data-url="inventoryList.do">
					    		   <i class="iconfont icon-wenzhang2" data-icon='icon-pinglun1'></i>
					    		   <span>库存管理</span>
					    		</a>
					    	</dd>
					        <dd>
					    		<a href="javascript:;" data-url="orderList.do">
					    		   <i class="iconfont icon-wenzhang2" data-icon='icon-pinglun1'></i>
					    		   <span>订单管理</span>
					    		</a>
					    	</dd>
					        <dd>
					    		<a href="javascript:;" data-url="messageList.do">
					    		   <i class="iconfont icon-wenzhang2" data-icon='icon-pinglun1'></i>
					    		   <span>留言管理</span>
					    		</a>
					    	</dd>
					   </c:if>
					   </dl>
			   </li>
			   
			   
			   <li class="layui-nav-item">
					<a href="javascript:;">
					   <i class="iconfont icon-wenzhang1" ></i>
					   <span>统计管理</span>
					   <em class="layui-nav-more"></em>
					</a>
					   <dl class="layui-nav-child">
					   <c:if test="${sessionScope.admin.usertype eq '管理员'}"> 
					          <dd>
					    		<a href="javascript:;" data-url="saleProduct.do">
					    		   <i class="iconfont icon-wenzhang2" data-icon='icon-pinglun1'></i>
					    		   <span>销售量统计</span>
					    		</a>
					    	 </dd>
					    	 <dd>
					    		<a href="javascript:;" data-url="voteProduct.do">
					    		   <i class="iconfont icon-wenzhang2" data-icon='icon-pinglun1'></i>
					    		   <span>点赞次数统计</span>
					    		</a>
					    	 </dd>
					    	 <dd>
					    		<a href="javascript:;" data-url="saleMoney.do">
					    		   <i class="iconfont icon-wenzhang2" data-icon='icon-pinglun1'></i>
					    		   <span>销售额统计</span>
					    		</a>
					    	 </dd>
					    	 <dd>
					    		<a href="javascript:;" data-url="orderNum.do">
					    		   <i class="iconfont icon-wenzhang2" data-icon='icon-pinglun1'></i>
					    		   <span>订单量统计</span>
					    		</a>
					    	 </dd>
					    </c:if>
					   </dl>
			   </li>
			   
			  <c:if test="${sessionScope.admin.usertype eq '管理员'}"> 
                 <!-- 会员管理 -->
				<li class="layui-nav-item">
					<a href="javascript:;">
					   <i class="iconfont icon-m-members" ></i>
					   <span>用户管理</span>
					   <em class="layui-nav-more"></em>
					</a>
					<dl class="layui-nav-child">
                           <dd>
                           	   <a href="javascript:;" data-url="memberList.do">
					              <i class="iconfont icon-wenzhang2"  data-icon='icon-zhuti'></i>
					              <span>会员信息</span>
					           </a>
                           </dd>
                           
                           <dd>
                           	   <a href="javascript:;" data-url="userList.do">
					              <i class="iconfont icon-wenzhang2"  data-icon='icon-zhuti'></i>
					              <span>用户信息</span>
					           </a>
                           </dd>
                    </dl>
				</li>
				</c:if>
		</ul>
	    </div>
	</div>

	<!-- 左侧侧边导航结束 -->
	<!-- 右侧主体内容 -->
	<!-- 底部区域 -->
<!-- 加载js文件-->                                                                                                                                                                                           
	<script type="text/javascript" src="<%=path %>/admin/common/layui/layui.js"></script> 
	<script type="text/javascript" src="<%=path %>/admin/js/larry.js"></script>
	<script type="text/javascript" src="<%=path %>/admin/js/index.js"></script>
<!-- 锁屏 -->
<div class="lock-screen" style="display: none;">
	<div id="locker" class="lock-wrapper">
		<div id="time"></div>
		<div class="lock-box center">
			<img src="<%=path %>/admin/images/userimg.jpg" alt="">
			<h1>admin</h1>
			<duv class="form-group col-lg-12">
				<input type="password" placeholder='锁屏状态，请输入密码解锁' id="lock_password" class="form-control lock-input" autofocus name="lock_password">
				<button id="unlock" class="btn btn-lock">解锁</button>
			</duv>
		</div>
	</div>
</div>

</body>
</html>
