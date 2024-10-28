<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
session.removeAttribute("admin");
session.invalidate();
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>网上书城后台管理</title>
	<meta name="renderer" content="webkit">	
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">	
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">	
	<meta name="apple-mobile-web-app-capable" content="yes">	
	<meta name="format-detection" content="telephone=no">	
	<!-- load css -->
	<link rel="stylesheet" type="text/css" href="<%=path %>/admin/common/layui/css/layui.css" media="all">
	<link rel="stylesheet" type="text/css" href="<%=path %>/admin/css/login.css" media="all">
	
  	<script type="text/javascript" src="<%=path %>/admin/js/jquery-2.1.0.min.js"></script>
	<script type="text/javascript" src="<%=path %>/layer/layer.js"></script>
</head>
<body>
<form action="<%=path%>/admin/login.do" method="post" name="userlogin" id="userlogin" onsubmit="return login()">
<div class="layui-canvs"></div>
<div class="layui-layout layui-layout-login">
	<h1>
		 <strong>网上书城系统</strong>
		 <em></em>
	</h1>
	
	<div class="layui-user-icon larry-login">
		 <input type="text" placeholder="账号" name="username" id="username" class="login_txtbx" required/>
	</div>
	<div class="layui-pwd-icon larry-login">
		 <input type="password" placeholder="密码" name="userpassword" id="userpassword" class="login_txtbx" required/>
	</div>
    <div class="layui-val-icon larry-login">
    	<div class="layui-code-box">
    		<input type="text" id="yzm" name="yzm" placeholder="验证码" required class="login_txtbx">
            <div id="check-code" style="overflow: hidden;background: white" class="verifyImg">
			<div class="code" id="data_code" style="font-size: 30px;padding-left: 10px;padding-top: 8px;letter-spacing:8px"></div>
			<input type="hidden"  id="hiddenyzm">
			</div>
    	</div>
    </div>
    <div class="layui-submit larry-login">
    	<input type="submit" value="立即登陆"  class="submit_btn"/>
    </div>
    
    <div class="layui-login-text">
    	<p></p>
    </div>
</div>
</form>
</body>
<script type="text/javascript" src="<%=path %>/admin/common/layui/lay/dest/layui.all.js"></script>
<script type="text/javascript" src="<%=path %>/admin/common/layui/lay/dest/layui.js"></script>
<script type="text/javascript" src="<%=path %>/admin/js/login.js"></script>
<script type="text/javascript" src="<%=path %>/admin/jsplug/jparticle.jquery.js"></script>
<script type="text/javascript">
$(function(){
	$(".layui-canvs").jParticle({
		background: "#141414",
		color: "#E6E6E6"
	});
	//登录链接测试，使用时可删除
});



</script>

		<script type="text/javascript">
	/**
	 * 验证码
	 * @param {Object} o 验证码长度
	 */
	$.fn.code_Obj = function(o) {
		var _this = $(this);
		var options = {
			code_l: o.codeLength,//验证码长度
			codeChars: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
				'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
				'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
			],
			codeColors: ['#f44336', '#009688', '#cddc39', '#03a9f4', '#9c27b0', '#5e4444', '#9ebf9f', '#ffc8c4', '#2b4754', '#b4ced9', '#835f53', '#aa677e'],
			code_Init: function() {
				var code = "";
				var codeColor = "";
				var checkCode = _this.find("#data_code");
				for(var i = 0; i < this.code_l; i++) {
					var charNum = Math.floor(Math.random() * 52);
					code += this.codeChars[charNum];
				}
				for(var i = 0; i < this.codeColors.length; i++) {
					var charNum = Math.floor(Math.random() * 12);
					codeColor = this.codeColors[charNum];
				}
				console.log(code);
				if(checkCode) {
					checkCode.css('color', codeColor);
					checkCode.className = "code";
					checkCode.text(code);
					checkCode.attr('data-value', code);
					$("#hiddenyzm").attr('value', code);
					//alert($("#hiddenyzm").val());
				}
			}
		};

		options.code_Init();//初始化验证码
		_this.find("#data_code").bind('click', function() {
			options.code_Init();
		});
	};
</script>
<script type="text/javascript">
	/**
	 * 验证码
	 * codeLength:验证码长度
	 */
	$('#check-code').code_Obj({
		codeLength: 5
	});
</script>
<script type="text/javascript">

function login(){
	if($("#username").val()==""){
		layer.msg("账号不能为空");
		return false;
		}
	if($("#userpassword").val()==""){
		layer.msg("密码不能为空");
		return false;
		}
	if($("#yzm").val()!=$("#hiddenyzm").val()){
		layer.msg("验证码输入错误");
		return false;
	 }
}

<%
String error = (String)request.getAttribute("error");
if(error!=null){
%>
layer.msg("用户名或密码错误");
<%}%>
</script>
</html>
