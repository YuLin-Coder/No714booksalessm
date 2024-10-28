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
    
    <title>订单付款</title>
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
</head>
<body>
    <jsp:include page="top.jsp"></jsp:include>
    <form class="contact" action="payOrder.do" method="post" name="orderForm" onsubmit="return pay()">
    <section id="main">
        <div class="container_12">
            <div id="content" class="grid_12">
                <header>
                    <h1 class="page_title">订单付款</h1>
                </header>
                    
                <article>
                    <div class="grid_6 adress">
			       <h3 style="color:red;font-weight: bold;">￥${total}</h3>
			       
			       
			       <div class="tab1 tab_body" style="border:0px solid red;">
					        <ul style="padding: 0px;">
					         <li style="list-style: none;border:0px solid red;margin-bottom: 10px;float: left;margin-right: 20px;">
					           <span style="float: left;line-height: 20px;width: 20px;height: 20px;padding-top: 7px;"><input type="radio" name="zffs" value="微信支付" checked style="margin-right: 10px;"/></span>
					           <img alt="" src="<%=path %>/upload/20181217121926.jpg" style="width: 100px;height: 30px;">
					         </li>
					         <li style="list-style: none;border:0px solid red;margin-bottom: 10px;float: left;margin-right: 20px;">
					           <span style="float: left;line-height: 20px;width: 20px;height: 20px;padding-top: 7px;"><input type="radio" name="zffs" value="支付宝支付"  style="margin-right: 10px;"/></span>
					           <img alt="" src="<%=path %>/upload/20181217121731.jpg" style="width: 100px;height: 30px;">
					         </li>
					        </ul>
			           </div>
			       <hr>
			
			
                    </div><!-- .adress -->
                    
                    <div class="grid_6 form">
			<input type="hidden" name="id" value="${id}">
			    <h2>收银台</h2>
							
			    <div class="name">
				<strong>支付帐号:</strong><sup>*</sup><br>
				<input type="text" name="name" required oninvalid="setCustomValidity('银行卡号不能为空')" pattern="[0-9]+" oninput="setCustomValidity('');">
			    </div><!-- .name -->
				
			    <div >
				<strong>密码:</strong><sup>*</sup><br>
				<input type="password" name="upass" class="" id="upass" required oninvalid="setCustomValidity('密码不能为空')" oninput="setCustomValidity('');" style="width: 430px;height: 36px;border-radius:20px 20px;border: 1px solid #CCCCCC;outline:none;padding-left: 10px;">
			    </div>
							
				
				
			    <div class="submit" style="margin-top: 20px;">
				<div class="field"><sup></sup><span></span></div>
				<input type="submit" value="付款">
			    </div><!-- .submit -->
		    <!-- .contact -->
                </div><!-- .grid_6 -->
                    
		</article>
                    
                <div class="clear"></div>
            </div><!-- #content -->

            <div class="clear"></div>
        </div><!-- .container_12 -->
    </section><!-- #main -->
    </form>
    <div class="clear"></div>
        
    <jsp:include page="foot.jsp"></jsp:include>
    <script type="text/javascript">
    function pay(){
    var zffs = $(".zffs").val();
    $("#zffs").val(zffs);
    }
    
    </script>
</body>
<!-- Added by HTTrack --><meta http-equiv="content-type" content="text/html;charset=utf-8" /><!-- /Added by HTTrack -->
</html>
