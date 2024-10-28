<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<!-- Added by HTTrack --><meta http-equiv="content-type" content="text/html;charset=utf-8" /><!-- /Added by HTTrack -->
<head>
    <meta charset="utf-8">
    
    <title>创建订单</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width">
    
    <link rel="shortcut icon" href="favicon.ico">

    <link rel="stylesheet" href="css/grid.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/normalize.css">

    <script src="js/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="js/jquery-1.8.3.min.js"><\/script>')</script>
    <script src="js/html5.js"></script>
    <script src="js/main.js"></script>
    <script src="js/radio.js"></script>
    <script src="js/checkbox.js"></script>
    <script src="js/selectBox.js"></script>
    <script src="js/jquery.carouFredSel-5.2.2-packed.js"></script>
    <script src="js/jquery.jqzoom-core.js"></script>
    <script src="js/jquery.transit.js"></script>
    <script src="js/jquery.easing.1.2.js"></script>
    <script src="js/jquery.anythingslider.js"></script>
    <script src="js/jquery.anythingslider.fx.js"></script>
    <style type="text/css">
    div ul .close{
	border-right: 0 none;
	width: 50px;
}
div ul a.close {
	background: url(/booksalessm/img/close.png) no-repeat 0 0;
	height: 20px;
	display: block;
	margin: 0 auto;
	width: 20px;
}
div ul a.close:hover{
	opacity: .8;
	filter:progid:DXImageTransform.Microsoft.Alpha(opacity=80);
}
}


.grid_6 .submit input[type="submit"]{
	font:bold 13px/40px "HelveticaNeue", "Helvetica Neue", Helvetica, Arial, Arial, Verdana, sans-serif;
	margin: 0px 0 0px 0;
	width: 88px;
}
    </style>
</head>
<body>
    <jsp:include page="top.jsp"></jsp:include>
    
    <section id="main">
        <div class="container_12">
            <div id="content" class="grid_12">
                <header>
                    <h1 class="page_title">创建订单</h1>
                </header>
                    
                <article>
                    <div class="grid_6 adress" style="border:0px solid red;width: 100%">
						<h3 style="color:red;font-weight: bold;">￥${totalstr}</h3>
						<p style="font-size: 12px;font-weight: bold;">共&nbsp;<font style="color:#6F8921">${fn:length(cartlist)}</font>&nbsp;件图书</p>
			
			         <!-- s -->
			 <form class="contact" action="creatOrder.do" method="post" name="orderForm">
			  <input type="hidden" name="total" value="${totalstr}">
			         <div id="wrapper_tab" class="tab1" style="border:0px solid red;">
			           <a href="#" class="tab1 tab_link">收货地址</a>
			           <div class="clear"></div>
			           <div class="tab1 tab_body">
					        <ul>
					         <c:choose>
					           <c:when test="${fn:length(addresslist)!=0}">
					           	<c:forEach items="${addresslist}" var="address">
					         		<li style="list-style: none;border:0px solid red;margin-bottom: 10px;"><input type="radio" name="addrid" value="${address.id}" checked style="margin-right: 10px;"/>${address.addr }  <span style="font-weight: bold;">${address.name }     ${address.tel }</span><span style="float: right;"></span></li>
					         	</c:forEach>
					           </c:when>
					           <c:otherwise>
					                                请先完善收货信息,&nbsp;<a href="javascript:;" onclick="location.replace('addressMsg.do');">点击这里跳转...</a>
					           </c:otherwise>
					         </c:choose>
					        </ul>
			           </div><!-- .tab1 .tab_body -->
			           <div class="clear"></div>
			        </div>​<!-- #wrapper_tab -->
			   
					 <div class="submit">
						<div class="field"><sup></sup><span></span></div>
						<input type="submit" value="创建订单">
					 </div>  
			 </form>    
			         <!-- e -->
			<hr>
          </div>
                    <!-- .adress -->
                    
		</article>
                    
                <div class="clear"></div>
            </div><!-- #content -->

            <div class="clear"></div>
        </div><!-- .container_12 -->
    </section><!-- #main -->
    <div class="clear"></div>
    <jsp:include page="foot.jsp"></jsp:include>
</body>
<!-- Added by HTTrack --><meta http-equiv="content-type" content="text/html;charset=utf-8" /><!-- /Added by HTTrack -->
</html>
