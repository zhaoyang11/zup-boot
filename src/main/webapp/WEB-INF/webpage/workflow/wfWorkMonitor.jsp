<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<base href=" <%=basePath%>">
		<title>运维监控平台监控的工作</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	    <!--        引入外部样式库css        -->
        <jsp:include page="../include/mainHead.jsp"></jsp:include>
        <style type="text/css">
	        @media (max-width:992px){
				#WORKNAMEQUERY,#SPONSORNAMEQUERY{
					margin-top:15px;
				}
				#POSITIONDEPRESS{
					margin-top:15px;
				}			
			}
        </style>
        <link rel="stylesheet" type="text/css" href="plug-in\ace\main\esale\new_css\esale-new-style.css"/>
</head>
<body style="background-color:#FFFFFF;  overflow-x : hidden ;" >
    	<div class="row">
			<div class="col-md-12 col-xs-12 col-lg-12 widget-body">
				<div class="row center center-block" style="margin-top:20px;">
				<div class="container">
					<div class="row clearfix">
						<div class="col-md-12 column">
							<form class="form-horizontal" role="form">
								<div class="form-group">
									 <label for="SHIPSYSTEMQUERY" class="col-xs-5 col-md-2 control-label" style="text-align: right; height:25px" >所属系统：</label>
									<div class="col-xs-4 col-md-3"> 
							            <select id="SHIPSYSTEMQUERY" class="form-control" >
								              <option value="0">全部</option> 
							            </select>
									</div>
									<label for="WORKNAMEQUERY" class="col-xs-5 col-md-2 control-label" id="POSITIONDEPRESS" style="text-align: right" >工作名称：</label>
									<div class="col-xs-4 col-md-3">
										<input type="text" class="form-control" id="WORKNAMEQUERY" />
									</div>
									<div class="col-md-2 col-xs-3" style=" position:absolute; right:30px; top:0px">
										<button class="btn btn-sm btn-primary" type="button"  id="btnSearch"><i class="icon-ok"></i>查询</button>
									</div>
								</div>
								<div class="form-group">
									<label for="FlOWNAMEQUERY" class="col-xs-5 col-md-2 control-label" style="text-align: right" >流程名称：</label>
									<div class="col-xs-4 col-md-3">
										<input type="text" class="form-control" id="FlOWNAMEQUERY" />
									</div>
									<label for="SPONSORNAMEQUERY" class="col-xs-5 col-md-2 control-label" id="POSITIONDEPRESS" style="text-align: right" >发起人：</label>
									<div class="col-xs-4 col-md-3">
										<input type="text" class="form-control" id="SPONSORNAMEQUERY" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-5 col-md-2 control-label" style="text-align: right" >开始时间：</label>
									<div class="input-group col-xs-4 col-md-3" >
									<input class="form-control date-picker" id="WORKTIMESTARTQUERY" name="start_Time"  type="text" data-date-format="dd-mm-yyyy" value="${ demo.receive_Time}">
									<span class="input-group-addon">
										<i class="icon-calendar bigger-110"></i>
									</span>
								    </div>
									<label class="col-xs-5 col-md-2 control-label" id="POSITIONDEPRESS" style="text-align:right; " >结束时间：</label>
									<div class="input-group col-xs-4 col-md-3" id="POSITIONDEPRESS">
									<input class="form-control date-picker" id="WORKTIMEENDQUERY" name="end_Time"  type="text" data-date-format="dd-mm-yyyy" value="${ demo.receive_Time}">
									<span class="input-group-addon" for="WORKTIMEENDQUERY">
										<i class="icon-calendar bigger-110"></i>
									</span>
								    </div>
								</div> 
				          </form>
			         </div>
			    </div>
			</div>
	     </div>
			<!-- 查询条件结束 -->
			<!-- 菜单操作项datables开始 -->
			<div class="table-header">监控的工作</div>
			<div class="row">
				<div class="col-md-12" style="margin-left:6px;height:30px; margin-bottom:10px; margin-top:5px;">
					<button class="btn btn-primary btn-sm" id="btnWorkFinishDetail">查看详情</button>
					<button class="btn btn-primary btn-sm" id="btnWorkFlowView">流程图查看</button>
					<button class="btn btn-primary btn-sm" id="btnWorkFlowCheckView">审批过程</button>
					<button class="btn btn-primary btn-sm" id="btnWorkFlowPause">暂停工作</button>
					<button class="btn btn-primary btn-sm" id="btnWorkFlowReLaunch">重启工作</button>
					<button class="btn btn-primary btn-sm" id="btnWorkFlowForceStop">强制结束工作</button>
				</div>
			</div>
			<div class="table-responsive">
				<table id="gridDealt" class="table table-striped table-bordered table-hover"  style="margin-bottom:20px;">
					<thead>
						<tr>
							<th>
							</th>
							<th>工作名称</th>
							<th>流程名称</th>
							<th>活动名称</th>
							<th>所属系统</th>
							<th>工作状态</th>
							<th>发起人</th>
							<th>开始时间</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
		<!-- 菜单操作项信息datables结束 -->
	</div>
	
    <!--  引入js存放的外部脚本库  -->
    <jsp:include page="../include/mainFooter.jsp"></jsp:include>
    
   	<!-- 添加脚本开始 -->
   	<script type="text/javascript">
   		var param = {};
	   	var pars = {};
   		//点击日期控件图标可以显示
   		$(document).ready(function(){
   			$('.date-picker').datepicker({autoclose:true}).next().on(ace.click_event, function(){
				$(this).prev().focus();
			});
	   		
	   		dateDom();
			$("#allCheck").on('click' , function(){
				var that = this;
				$(this).closest('table').find('tr > td:first-child input:checkbox')
				.each(function(){
					this.checked = that.checked;
					$(this).closest('tr').toggleClass('selected');
				});
			});
   			loadTableData();
        	$.ajax({
	            type: "POST",
	            url: "rest/workflow/workPersonal/SystemName", 
	            cache: false,  //禁用缓存
	            dataType: "json",
	            success: function (result) {
	       			$("#SHIPSYSTEMQUERY").empty();
	       			$("#SHIPSYSTEMQUERY").append("<option value=0>全部</option>");
	            	for(var i=0;i<result.system.length;i++){
	             		$("#SHIPSYSTEMQUERY").append("<option value='"+result.system[i].systemId+"'>"+result.system[i].systemName+"</option>");
	            	}
	            }
	        });
   		});
		//日期控件js
   		function dateDom(){
   			$.datepicker.regional['zh-CN'] = { 
			  clearText: '清除', 
			  clearStatus: '清除已选日期', 
			  closeText: '关闭', 
			  closeStatus: '不改变当前选择', 
			  prevText: '<上月', 
			  prevStatus: '显示上月', 
			  prevBigText: '<<', 
			  prevBigStatus: '显示上一年', 
			  nextText: '下月>', 
			  nextStatus: '显示下月', 
			  nextBigText: '>>', 
			  nextBigStatus: '显示下一年', 
			  currentText: '今天', 
			  currentStatus: '显示本月', 
			  monthNames: ['一月','二月','三月','四月','五月','六月', '七月','八月','九月','十月','十一月','十二月'], 
			  monthNamesShort: ['一','二','三','四','五','六', '七','八','九','十','十一','十二'], 
			  monthStatus: '选择月份', 
			  yearStatus: '选择年份', 
			  weekHeader: '周', 
			  weekStatus: '年内周次', 
			  dayNames: ['星期日','星期一','星期二','星期三','星期四','星期五','星期六'], 
			  dayNamesShort: ['周日','周一','周二','周三','周四','周五','周六'], 
			  dayNamesMin: ['日','一','二','三','四','五','六'], 
			  dayStatus: '设置 DD 为一周起始', 
			  dateStatus: '选择 m月 d日, DD', 
			  dateFormat: 'yy-mm-dd', 
			  firstDay: 1, 
			  initStatus: '请选择日期', 
			  isRTL: false};
			$.datepicker.setDefaults($.datepicker.regional['zh-CN']);
   			//日期框
			$('.date-picker').datepicker({
                language: 'zh-CN',
                autoclose: true,
                todayHighlight: true
            })
   		}
		$("#btnSearch").on('click' , function(){
			if($("#WORKTIMESTARTQUERY").val() != "" && $("#WORKTIMEENDQUERY").val() != ""){
				if($("#WORKTIMESTARTQUERY").val() > $("#WORKTIMEENDQUERY").val()){
					parent.bootbox.alert("开始时间不能大于结束时间", function(){});
					return;
				}
			}
			loadTableData();
		});
       
	    function loadTableData(){
    		//提示信息
	        var lang = {
	            "sProcessing": "处理中...",
	            "sLengthMenu": "每页 _MENU_ 项",
	            "sZeroRecords": "没有匹配结果",
	            "sInfo": "当前第 _START_ 至 _END_ 项，共 _TOTAL_ 项。",
	            "sInfoEmpty": "当前显示第 0 至 0 项，共 0 项",
	            "sInfoFiltered": "(由 _MAX_ 项结果过滤)",
	            "sInfoPostFix": "",
	            "sSearch": "搜索:",
	            "sUrl": "",
	            "sEmptyTable": "表中数据为空",
	            "sLoadingRecords": "载入中...",
	            "sInfoThousands": ",",
	            "oPaginate": {
	                "sFirst": "首页",
	                "sPrevious": "上页",
	                "sNext": "下页",
	                "sLast": "末页",
	                "sJump": "跳转"
	            },
	            "oAria": {
	                "sSortAscending": ": 以升序排列此列",
	                "sSortDescending": ": 以降序排列此列"
	            }
	        };   
    		//初始化表格
        	var table = $("#gridDealt").dataTable({
        	    "dom": '<t><"col-md-2"l><"col-md-4"i><"col-md-6"p>',    //为表格元素书写css样式<t>为中间表格  在<t>右边就是在表格下边
           		language:lang,  //提示信息
            	stripeClasses: ["odd", "even"],  //为奇偶行加上样式，兼容不支持CSS伪类的场合
	            serverSide: true,  //启用服务器端分页
	            searching: false,  //禁用原生搜索
	            bAutoWidth:false, //自适应宽度 
	            bDestroy:true,//重新加载使用
	            renderer: "bootstrap",  //渲染样式：Bootstrap和jquery-ui
	            pagingType: "full_numbers",  //分页样式：simple,simple_numbers,full,full_numbers
	            ordering:false,
	            ajax: function (data, callback, settings) {
					if($("#SHIPSYSTEMQUERY").val()!="" || $("#SHIPSYSTEMQUERY").val()!=0){
						 param.SystemID = $("#SHIPSYSTEMQUERY").val();
					}
					if($("#WORKNAMEQUERY").val()!="" || $("#WORKNAMEQUERY").val()!=0){
						 param.WorkName = $("#WORKNAMEQUERY").val();
					}else if($("#WORKNAMEQUERY").val() == ""){
						 param.WorkName = "";
					}
					if($("#FlOWNAMEQUERY").val()!=""){
						 param.FlowName = $("#FlOWNAMEQUERY").val();
					}else if($("#FlOWNAMEQUERY").val() == ""){
						 param.FlowName = "";
					}
					if($("#SPONSORNAMEQUERY").val()!="" || $("#SPONSORNAMEQUERY").val()!=0){
						 param.SponsorName = $("#SPONSORNAMEQUERY").val();
					}else if($("#SPONSORNAMEQUERY").val() == ""){
						 param.SponsorName = "";
					}
					if($("#WORKTIMESTARTQUERY").val()!="" || $("#WORKTIMESTARTQUERY").val()!=0){
						 param.FromDate = $("#WORKTIMESTARTQUERY").val();
					}else if($("#WORKTIMESTARTQUERY").val() == ""){
						 param.FromDate = "";
					}
					if($("#WORKTIMEENDQUERY").val()!="" || $("#WORKTIMEENDQUERY").val()!=0){
						 param.ToDate = $("#WORKTIMEENDQUERY").val();
					}else if($("#WORKTIMEENDQUERY").val() == ""){
						 param.ToDate = "";
					}
	                param.rows = data.length;//页面显示记录条数，在页面显示每页显示多少项的时候
	                param.start = data.start;//开始的记录序号
	                param.page = (data.start / data.length)+1;//当前页码
	                $.ajax({
	                    type: "POST",
	                    url: "rest/workflow/workPersonal/WorkMonitor/getWorkMonitorQuery",
	                    cache: false,  //禁用缓存
	                    data: param,  //传入组装的参数
	                    dataType: "json",
	                    success: function (result) {
	                        setTimeout(function () {
	                            //封装返回数据
	                            var returnData = {};
	                            returnData.draw = data.draw;//这里直接自行返回了draw计数器,应该由后台返回
	                            returnData.recordsTotal = result.total;//返回数据全部记录
	                            returnData.recordsFiltered = result.total;//后台不实现过滤功能，每次查询均视作全部结果
	                            returnData.data = result.data;//返回的数据列表
	                            callback(returnData);
	                        }, 200);
	                    }
	                });
            	},
            	columnDefs: [
                          	{
          				    	"targets": [0], // 目标列位置，下标从0开始
          				        "data": "WORK_ID", // 数据列名
          				        "orderable":false,
          				      "sWidth":"40px",
          				        "render": function(data, type, full) { // 返回自定义内容
          				       		return "<label><input type='radio' name='radio' class='ace' id='workID' value = '" + data + "' /><span class='lbl' id='WORK_ID' value = '" + data + "'></span></label>";
          				         }
                              },
                              {
          					  	"targets": [1], // 目标列位置，下标从0开始
          					  	"sWidth":"20%",
          					   	"data": "WORK_NAME",
          					   	"render": function(data, type, full) { // 返回自定义内容
          	                    	if(data !=null && data!=""){
                                          return data;
                                      }else{
                                          return "";
                                      }
          				         }
                              },
                              {
          					   	"targets": [2], // 目标列位置，下标从0开始
          					   	"sWidth":"10%",
          					   	"data": "FLOW_NAME",
          					   	"render": function(data, type, full) { // 返回自定义内容
          	                    	if(data !=null && data!=""){
                                          return data;
                                      }else{
                                          return "";
                                      }
          				         }
                              },
                              {
          					   	"targets": [3], // 目标列位置，下标从0开始
          					   	"sWidth":"14%",
          					   	"data": "ACTIVITY_NAME",
          					   	"render": function(data, type, full) { // 返回自定义内容
          	                    	if(data !=null && data!=""){
                                          return data;
                                      }else{
                                          return "";
                                      }
          				         }
                              },{
          					   	"targets": [4], // 目标列位置，下标从0开始
          					   	"sWidth":"16%",
          					   	"data": "SYSTEM_NAME",
          					   	"render": function(data, type, full) { // 返回自定义内容
          	                    	if(data !=null && data!=""){
                                          return data;
                                      }else{
                                          return "";
                                      }
          				         }
                              },
                              {
          					   	"targets": [5], // 目标列位置，下标从0开始
          					   	"sWidth":"10%",
          					   	"data": "WORK_STATE_NAME",
          					   	"render": function(data, type, full) { // 返回自定义内容
          	                    	if(data !=null && data!=""){
                                          return data;
                                      }else{
                                          return "";
                                      }
          				         }
                              },
                              {
          					   	"targets": [6], // 目标列位置，下标从0开始
          					   	"sWidth":"10%",
          					   	"data": "SPONSOR_NAME",
          					   	"render": function(data, type, full) { // 返回自定义内容
          	                    	if(data !=null && data!=""){
                                          return data;
                                      }else{
                                          return "";
                                      }
          				         }
                              },
                              {
          					   	"targets": [7], // 目标列位置，下标从0开始
          					   	"sWidth":"20%",
          					   	"data": "CREATE_DATETIME",
          					   	"render": function(data, type, full) { // 返回自定义内容
          	                    	if(data !=null && data!=""){
                                          return data;
                                      }else{
                                          return "";
                                      }
          				         }
                              }
          	            ]
          	        }).api();
	        //此处需调用api()方法,否则返回的是JQuery对象而不是DataTables的API对象
		    }
	    
	    
	</script>
	
	<!--  删除  js脚本实现-->
    <script type="text/javascript">
		//点击暂停工作触发的事件
		$( "#btnWorkFlowPause" ).on('click', function(e) {
			var workID = $("#workID:checked").val();
			$.ajax({
				cache: true,
				type: "POST",
				url:"rest/workflow/workPersonal/WorkFlowPause",
				data:"workID="+workID,
				async: false,
				dataType:"json",
				success: function(data) {
				
				}
			});
		});
		
		//点击重启工作触发的事件
		$( "#btnWorkFlowReLaunch" ).on('click', function(e) {
			var workID = $("#workID:checked").val();
			$.ajax({
				cache: true,
				type: "POST",
				url:"rest/workflow/workPersonal/WorkFlowReLaunch",
				data:"workID="+workID,
				async: false,
				dataType:"json",
				success: function(data) {
				
				
				}
			});
		});
		
		//点击强制停止工作触发的事件
		$( "#btnWorkFlowForceStop" ).on('click', function(e) {
			var workID = $("#workID:checked").val();
			$.ajax({
				cache: true,
				type: "POST",
				url:"rest/workflow/workPersonal/WorkFlowForceStop",
				data:"workID="+workID,
				async: false,
				dataType:"json",
				success: function(data) {
				
				}
			});
		});
		
		//点击查看详情触发的事件
		$( "#btnWorkFinishDetail" ).on('click', function(e) {
			if($("#workID:checked").length > 1){
				parent.bootbox.alert("只能选择一项", function(){});
				return;
			}else if($("#workID:checked").length < 1){
				parent.bootbox.alert("请选择一条工作", function(){});
				return;
			}else{
				var workID = $("#workID:checked").val();
			    //workID//获取id之后传入后台根据workid查询itemid和活动id  然后返回到前台  拿着全部数据填充到里面
			    window.open('rest/workflow/workPersonal/WorkFinishDetail?workID='+workID+'&statId=2', 'workflow', 'height=618,width=1000,top=50,left=100,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
			}
		});
		//双击打开详情
		$(document).on("dblclick","tr",function(){
			var workID = $(this).find("input").val();
			window.open('rest/workflow/workPersonal/WorkFinishDetail?workID='+workID+'&statId=2', 'workflow', 'height=618,width=1000,top=50,left=100,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
		})
		//点击审查按钮触发的事件
		$( "#btnWorkFlowCheckView" ).on('click', function(e) {
			var workID = $("#workID:checked").val();
		    //获取id之后传入后台根据workid查询itemid和活动id  然后返回到前台  拿着全部数据填充到里面
			window.open(encodeURI(encodeURI('rest/workflow/workPersonal/WorkFlowCheckView?workID='+workID+"&title="+$("#workID:checked").parent().parent().next().text())), 'workflow', 'height=618,width=1000,top=50,left=100,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
		});
		
		//点击流程图查看触发的事件
		$( "#btnWorkFlowView" ).on('click', function(e) {
			var workID = $("#workID:checked").val();
		    //获取id之后传入后台根据workid查询itemid和活动id  然后返回到前台  拿着全部数据填充到里面
			window.open('rest/workflow/workPersonal/WorkFlowView?workID='+workID, 'workflow', 'height=618,width=1000,top=50,left=100,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
		});
		
	</script>
    
	</body>
</html>

