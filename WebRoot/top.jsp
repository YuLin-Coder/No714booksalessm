<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<!-- Added by HTTrack --><meta http-equiv="content-type" content="text/html;charset=utf-8" /><!-- /Added by HTTrack -->
<head>
    <meta charset="utf-8">

    <title>Home</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width">

    <link rel="shortcut icon" href="book_128px_1113360_easyicon.net.ico">

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
    <style>
    
    .primary ul ul a:hover,
.primary ul ul li:hover a{
    border:1px solid red;
	background: #eb6447;
	border-radius: 19px;
	-moz-border-radius: 19px;
	-khtml-border-radius: 19px;
	behavior: url(PIE.htc);
	color: #fff;
	text-decoration: none;
}
    
    .primary ul ul ul.suburl{
    border:1px solid red;
	background: #fff;
	border-radius: 2px;
	-moz-border-radius: 2px;
	-khtml-border-radius: 2px;
	box-shadow: 0px 2px 5px 1px #e0e0e0;
	-moz-box-shadow: 0px 2px 5px 1px #e0e0e0;
	-webkit-box-shadow: 0px 2px 5px 1px #e0e0e0;
	display: none;
	left: 0;
	padding: 3px 0;
	position: absolute;
	left:218px;
	z-index: 999;
}

.primary ul ul.sub :hover .suburl{
display: block;
border:0px solid black;
}
 </style>
</head>
<body>
    <div id="top">
        <div class="container_12">
            <div class="grid_3">
                <div class="lang">
                    <ul>
                     
                        <li class="current"><a href="javascript:void(0)"></a></li>
                        <li><a href="javascript:void(0)"></a></li>
                        <li><a href="javascript:void(0)"></a></li>
                       
                    </ul>
                </div><!-- .lang -->

                <div class="currency">
                    <ul>
                   
                        <li class="current"><a href="javascript:void(0)"></a></li>
                        <li><a href="javascript:void(0)"></a></li>
                        <li><a href="javascript:void(0)"></a></li>
                       
                    </ul>
                </div><!-- .currency -->
            </div><!-- .grid_3 -->

            <div class="grid_9">
                <nav>
                    <ul>
                    <c:choose>
                      <c:when test="${sessionScope.sessionmember ne '' && sessionScope.sessionmember!=null}">
                      <li class="current"><a href="javascript:void(0)">${sessionScope.sessionmember.tname },你好！</a></li>
                        <li><a href="showMember.do">个人信息</a></li>
                        <li><a href="addressMsg.do">收货地址</a></li>
                        <li><a href="orderList.do">订单信息</a></li>
                        <li><a href="favList.do">收藏夹</a></li>
                        <li><a href="Exit.do">安全退出</a></li>
                     </c:when>
                     <c:otherwise>
                        <li><a href="login.jsp">登录</a></li>
                        <li><a href="register.jsp">注册</a></li>
                     </c:otherwise>
                    </c:choose>
                    </ul>
                </nav>
            </div><!-- .grid_9 -->
        </div>
    </div><!-- #top -->
    <header>
        <div class="container_12">

            <div class="grid_9" style="border:0px solid red;width: 98%">
                <div class="top_header">
                    <div class="welcome">
                         <a href="index.do" style="font-size: 24px;text-decoration:none;">网上书城</a>
                    </div><!-- .welcome -->
				<c:if test="${sessionScope.sessionmember ne '' && sessionScope.sessionmember!=null}">
                    <ul id="cart_nav">
                        <li>
                            <a class="cart_li" href="cartList.do">
                                <div class="cart_ico"></div>
                                	购物车
                                <span>￥
                                <c:choose>
                                   <c:when test="${totalstr eq '' || totalstr==null}">0.00</c:when>
                                   <c:otherwise>${totalstr}</c:otherwise>
                                 </c:choose> 
                                </span>
                            </a>
                            <ul class="cart_cont">
                                <li class="no_border recently">最近添加</li>
                                <c:forEach items="${cartlist}" var="cart">
                                <li>
                                    <a href="productDetails.do?id=${cart.product.id }" class="prev_cart"><div class="cart_vert"><img src="<%=path %>/upload/${cart.product.filename}" alt="Product 1" title=""></div></a>
                                    <div class="cont_cart" >
                                        <h4 style="color:#6F8921">${cart.product.productname}</h4>
                                        <div class="price">${cart.num} x <span style="font-weight: bold;">￥${cart.product.price}</span></div>
                                    </div>
                                    <a title="close" class="close" href="javascript:delCart('${cart.id}')"></a>
                                    <div class="clear"></div>
                                </li>
								</c:forEach>
                                <li class="no_border">
                                    <a href="cartList.do" class="view_cart">查看购物车</a>
                                    <a href="accountCart.do?total=${totalstr}" class="checkout">结算</a>
                                </li>
                            </ul>
                        </li>
                    </ul><!-- .cart_nav -->
				</c:if>
                    <form class="search" action="searchProductname.do" method="post">
                        <input type="submit" class="search_button" value="">
                        <input type="text" name="productname" class="search_form" value="${productname}" placeholder="搜索图书...">
                    </form><!-- .search -->
                </div><!-- .top_header -->

                <nav class="primary">
                    <ul>
                        <li class="curent"><a href="index.do">首页</a></li>
                        <li><a href="listNews.do">新闻资讯</a></li>
                        <c:forEach items="${ctlist}" var="fcategory">
                        <li class="parent">
                            <a href="product_List.do?fid=${fcategory.id}">${fcategory.name}</a>
                            <ul class="sub">
                               <c:forEach items="${fcategory.childlist}" var="ccategory">
                                <li class="parent">
                                <a href="product_List.do?fid=${fcategory.id}&cid=${ccategory.id}">${ccategory.name}</a>
                                     <ul class="suburl">
                                     <c:forEach items="${ccategory.minlist}" var="mcategory">
                                         <li><a href="product_List.do?fid=${fcategory.id}&cid=${ccategory.id}&mid=${mcategory.id}">${mcategory.name}</a></li>
                                      </c:forEach>
                                      </ul>
                                </li>
                               </c:forEach>
                            </ul>
                        </li>
                        </c:forEach>
                        <li><a href="popularityProduct.do">最具人气图书</a></li>
                        
                        <li><a href="message_List.do">在线留言</a></li>
                        
                        
                    </ul>
                </nav><!-- .primary -->
            </div><!-- .grid_9 -->
        </div>
    </header>


</body>
<script type="text/javascript">
function delCart(id){
$.ajax({
	type:"post",
	url:"delCart.do?id="+id,
	date:"",
	success:function(msg){
		location.reload();
	}
})
}
</script>
<!-- Added by HTTrack --><meta http-equiv="content-type" content="text/html;charset=utf-8" /><!-- /Added by HTTrack -->
</html>
