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
	<title>点赞次数统计</title>
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
	<script type="text/javascript" src="<%=path %>/admin/js/echarts.js"></script>  
<script type="text/javascript" src="<%=path %>/admin/js/china.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=53oVIOgmSIejwV7EfphPgTynOZbIiVYu"></script>
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
            
		         <!-- 操作日志 -->
                <div class="layui-form news_list" >
                    <div  id="tx" style="width: 100%;height:450px;">
    </div>
    
    <!-- s -->
      <script type="text/javascript">
    var myChart = echarts.init(document.getElementById('tx'));



    option = {
    	    title: {
    	        text: '销售额走势图',
    	        subtext: ''
    	    },
    	    tooltip: {
    	        trigger: 'axis'
    	    },
    	    
    	    toolbox: {
    	        show: true,
    	        feature: {
    	            dataZoom: {
    	                yAxisIndex: 'none'
    	            },
    	            dataView: {readOnly: false},
    	            magicType: {type: ['line', 'bar']},
    	            restore: {},
    	            saveAsImage: {}
    	        }
    	    },
    	    xAxis:  {
    	        type: 'category',
    	        boundaryGap: false,
    	        data: ${nlist}
    	    },
    	    yAxis: {
    	        type: 'value',
    	        axisLabel: {
    	        formatter: '¥{value} '
    	        }
    	    },
    	    series: [
    	        {
    	            name:'销售额',
    	            type:'line',
    	            data:${slist},
    	            markPoint: {
    	                data: [
    	                    {type: 'max', name: '最大金额'},
    	                    {type: 'min', name: '最小金额'}
    	                ]
    	            },
    	            markLine: {
    	                data: [
    	                    {type: 'average', name: '平均金额'}
    	                ]
    	            }
    	        }
    	    ]
    	};

	
    myChart.setOption(option);
	</script>
      <!-- e -->
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