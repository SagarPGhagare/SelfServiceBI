<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>Self-Serive BI</title>
<link rel="stylesheet" href="../assets/css/main.css">
  <!-- Bootstrap Core CSS -->
 <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet"> 


<!-- MetisMenu CSS -->
<link href="../vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

<!--   Custom CSS -->
<link href="../dist/css/sb-admin-2.css" rel="stylesheet"> 

<!-- Morris Charts CSS -->
<link href="../vendor/morrisjs/morris.css" rel="stylesheet">

<!-- Custom Fonts -->
<!-- <link href="../vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"> -->
   
<link rel="stylesheet" href="../assets/css/font-awesome.min.css" />
<link rel="stylesheet" href="../assets/css/font-awesome.css" />
<link rel="stylesheet" href="../assets/css/jquery-ui.css"/>

   <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->

<!--   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> -->
<!--  <script src="../assets/js/jquery-1.11.1.min.js"></script> -->
  
   <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="../assets/js/jquery-2.0.3.min.js"></script>
<script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script>
 <script type="text/javascript" src="../assets/js/jquery-ui.js"></script>
 
  
 
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> -->

<style>
    .tree, .tree ul {
    margin:0;
    padding:0;
    list-style:none;
    line-height:0em!important;
}
.tree ul {
    margin-left:1em;
    position:relative;
    border-top: 1px solid rgb(216, 215, 215);
}
.tree ul ul {
    margin-left:.5em;
      line-height:0em!important;
}

#ulTable >li :before
{
 content:"\e250"; 
  font-family: 'Glyphicons Halflings';
}

#ulTable >li
{
margin:0px!important;
}
.tree ul:before {
   /*  content:""; */
    display:block;
    width:0;
    position:absolute;
    top:0;
    bottom:0;
    left:0;
    border-left:1px solid
}
.tree li {
    margin:9px;
    padding:0 1em;
    line-height:2em;
    color:#369;
    font-weight:700;
    position:relative
}

.tree > li > a:hover, .tree > li > a:focus
{
color: #fff;
    text-decoration: none;
    background-color: #428bca;
    outline: none;
}
.tree ul li:before {
     /* content:""; */ 
    display:block;
    width:10px;
    height:0;
    border-top:1px solid;
    margin-top:-1px;
    position:absolute;
    top:1em;
    left:0
}
.tree ul li:last-child:before {
line-height:0em;
    background:#fff;
    height:auto;
    top:1em;
    bottom:0
}
.indicator {
    margin-right:5px;
}
.tree li a {
    text-decoration: none;
    color:#369;
}
.tree li button, .tree li button:active, .tree li button:focus {
    text-decoration: none;
    color:#369;
    border:none;
    background:transparent;
    margin:0px 0px 0px 0px;
    padding:0px 0px 0px 0px;
    outline: 0;
}
[data-draggable="target"]
{
    float:left;
    list-style-type:none;
    
    width:42%;
    height:7.5em;
    overflow-y:auto;
    
    margin:0 0.5em 0.5em 0;
    padding:0.5em;
    
    border:2px solid #888;
    border-radius:0.2em;
    
    background:#ddd;
    color:#555;
}
    
      </style>

  
  <script type="text/javascript">
  $(document).ready(function(){
	
	  <c:forEach var="listValue" items="${User}" varStatus="status">
	  var k="${User}";
	  console.log("K:"+k);
	  if(k=="admin")
	  	{
	  	$("#ConfigurationId").css("display","block");
	  	}
	 
	  </c:forEach>
	  
	  /* 
	  var arr=[];
	  arr.push(document.getElementById("sqlTextArea").value);
	  if(arr.length!=0)
		  {
		  $("#visualizatioLink").removeClass("not-active");
		  }
	   */
	  
 
	  $.fn.extend({
		    treed: function (o) {
		      
		      var openedClass = 'glyphicon-minus-sign';
		      var closedClass = 'glyphicon-plus-sign';
		      
		      if (typeof o != 'undefined'){
		        if (typeof o.openedClass != 'undefined'){
		        openedClass = o.openedClass;
		        }
		        if (typeof o.closedClass != 'undefined'){
		        closedClass = o.closedClass;
		        }
		      };
		      
		        //initialize each of the top levels
		        var tree = $(this);
		        tree.addClass("tree");
		        tree.find('li').has("ul").each(function () {
		            var branch = $(this); //li with children ul
		            branch.prepend("<i class='indicator glyphicon " + closedClass + "'></i>");
		            branch.addClass('branch');
		            branch.on('click', function (e) {
		                if (this == e.target) {
		                    var icon = $(this).children('i:first');
		                    icon.toggleClass(openedClass + " " + closedClass);
		                    $(this).children().children().toggle();
		                }
		            })
		            branch.children().children().toggle();
		        });
		        //fire event from the dynamically added icon
		      tree.find('.branch .indicator').each(function(){
		        $(this).on('click', function () {
		            $(this).closest('li').click();
		        });
		      });
		        //fire event to open branch if the li contains an anchor instead of text
		        tree.find('.branch>a').each(function () {
		            $(this).on('click', function (e) {
		                $(this).closest('li').click();
		                e.preventDefault();
		            });
		        });
		        //fire event to open branch if the li contains a button instead of text
		        tree.find('.branch>button').each(function () {
		            $(this).on('click', function (e) {
		                $(this).closest('li').click();
		                e.preventDefault();
		            });
		        });
		    }
		});
	  
		//Initialization of treeviews

		$('#tree3').treed({openedClass:'glyphicon glyphicon-download', closedClass:'glyphicon glyphicon-play-circle'});
		
		var item = null;
		addEventListener('dragstart', function(e){
			item = e.target;
			//e.dataTransfer.effectAllowed = 'copy';
			e.dataTransfer.setData('text', e.target.id);
			
		}, false);
		
		addEventListener('dragover', function(e)
			    {
			      e.preventDefault();
			        /* if(item)
			        {
			            e.preventDefault();
			            //ev.dataTransfer.dropEffect = "copy"
			        } */
			    
	    }, false);  
		
		//drop event to allow the element to be dropped into valid targets
	    document.addEventListener('drop', function(e)
	    {
	        //if this element is a drop target, move the item here 
	        //then prevent default to allow the action (same as dragover)
	        if(e.target.getAttribute('data-draggable') == 'target')
	        {
	        	  e.preventDefault();
	        	  var data=e.dataTransfer.getData("text");
	        	  var nodeCopy = document.getElementById(data);
	        	  var addtext = nodeCopy.innerText + ','
	        	  $("#sqlTextArea").val($("#sqlTextArea").val() + addtext);
	        }
	    
	    }, false);
	    
	    //dragend event to clean-up after drop or abort
	    //which fires whether or not the drop target was valid
	    document.addEventListener('dragend', function(e)
	    {
	        item = null;
	    
	    }, false);
	    
	    $('#getSqlQuery').on('click', function(event) {
	    	  event.preventDefault(); // To prevent following the link (optional)
	    	  
	    	  $("#displaySqlQuery").val('');
	    		$("#displaySqlQuery").css("display","block");
				$("#tableDiv").css("display","none");
				
	    	  var v = $("#sqlTextArea").val();
	    	  //alert("button clicked"+v)
	    	  
	    		var sqlString = {
                      "queryString" : v,
                    }
	    		$.ajax({
	    			type : "POST",
	    			contentType : "application/json",
	    			url : "http://localhost:8080/getSqlQuery",
	    			data : JSON.stringify(sqlString),
	    			dataType : 'json',
	    			timeout : 100000,
	    			success : function(data) {
	    				console.log("SUCCESS: ", data);
	    				var data1 = JSON.stringify(data);
	    				var json = JSON.parse(data1);
	    				var jsonStr = json["sqlQuery"];
	    				console.log("jsonStr>> "+jsonStr);
	    				$("#displaySqlQuery").val(json["sqlQuery"]);
	    				//display(data);
	    			},
	    			error : function(e) {
	    				console.log("ERROR: ", e);
	    				//display(e);
	    			},
	    			done : function(e) {
	    				console.log("DONE");
	    			}
	    		});

	    });
	    
	    $('.executeSql').on('click', function(event) {
	    	event.preventDefault(); // To prevent following the link (optional)
	    	
	    	$("#uploadTable").empty();
			$("#displaySqlQuery").css("display","block");
			$("#tableDiv").css("display","block");
			$("#visualizatioLink").removeClass("not-active");
			
	 	    	  var v = $("#sqlTextArea").val();
	    	 // alert("button clicked"+v)
	    	  
	    		var dataForTable = {
                    "queryString" : v,
                  }
	    		$.ajax({
	    			type : "POST",
	    			contentType : "application/json",
	    			url : "http://localhost:8080/getDataForTable",
	    			data : JSON.stringify(dataForTable),
	    			dataType : 'json',
	    			timeout : 100000,
	    			success : function(data) {
	    			//console.log("SUCCESS: ", data);
	    				var $table = $('#uploadTable');
	    				$.each(data, function(index, element) {
	    					
	    					
	    					$table.css('border','1px solid #ddd');
	    					
	    		
	    					
	    					$("#uploadTable th").css({
	    					    "background-color": "rgb(221, 221, 221)",
	    					    "border-top"  : "1px solid #ddd",
	    					    "padding" : "8px",
	    					    "line-height" : "1.42857143"
	    					   
	    					});
	    					
	    					$("#uploadTable td").css({
	    					    "background-color": "#ffffff",
	    					    "padding" : "6px",
	    					    "margin" : "6px",
	    					    "border-top"  : "1px solid #ddd"
	    					});
	    					
	    					$("#uploadTable  td:last-child").css({
	    						 "background-color": "#ffffff",
		    					    "padding" : "6px",
		    					    "margin" : "6px",
		    					    "border-top"  : "1px solid #ddd"
	    					});
	    					  
	    						    					
	    					$table.addClass('table table-striped');
	    					
	    					  $.each(element,function(k,v){
	    	    				          console.log(k+" : "+ v); 
	    	    				if(index == 0){
	    	    				$table.append( '<th>' +   k + '</th>' );
	    					   }
	    	    				    
	    	    				    
		    				});
	    					$table.append( '<tr>');
	    					console.log("SUCCESS sdfsdfsdfsdf : "+ element);
	    					           $.each(element,function(k,v){
	    	    				          console.log(k+" : "+ v); 
	    	    				    
	    	    				    $table.append( '<td>' +   v + '</td>' );
	    	    				
	    	    				    
		    				});
	    					$table.append( '</tr>');
	    				 });
	    			},
	    			error : function(e) {
	    				console.log("ERROR: ", e);
	    				//display(e);
	    			},
	    			done : function(e) {
	    				console.log("DONE");
	    			}
	    		});

	    });
	    
	  
  });
  
  /* function openVisualization(){
	  $.ajax({
			type : "get",
			url : "http://localhost:8080/tabVisualization",
			timeout : 100000,
			success : function(data) {
				//console.log("SUCCESS: ", data);
								 
			},
			error : function(e) {
				console.log("ERROR: ", e);
				//display(e);
			},
			done : function(e) {
				console.log("DONE");
			}
		});
	} */

  </script>


</head>

<body>


<div id="wrap" style="position: fixed;overflow-y: scroll!important;">
	<div id="top">
		<div class="row">
			<nav class="navbar navbar-inverse navbar-fixed-top ">
				<a data-original-title="Show/Hide Menu" data-placement="bottom"
					data-tooltip="tooltip"
					class="accordion-toggle btn btn-primary btn-sm visible-xs"
					data-toggle="collapse" href="#menu" id="menu-toggle"> <i
					class="icon-align-justify"></i>
				</a>
	<div class="col-sm-4">
				<header class="navbar-header">
				<!-- <a class="navbar-brand logo" ><img src="images/mastek.png" alt="Mastek Logo" class="img-circle"/></a> -->
				<span style="font-size:40px;color:#ffffff; font-weight:bolder;" >Mastek</span>
				<span style="font-size: 14px;color:#ffffff; font-weight:bolder;" >Self-Service BI </span> 
					<!-- <a class="navbar-brand logo" > <img src="images/mastek.png" alt="Mastek Logo" />
					</a> -->
				</header>
	</div>
	<div class="col-sm-6">
			<div class="topMenu">
				<nav class="navbar navbar-default">
				  <div class="container-fluid">
					 <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
						 <ul class="nav navbar-nav" id="topLink">
						 
						 <li ><a href="sql"><span
									style="font-size: 14px;color:#e9e9e9; font-weight:bolder;">SQL </span></a></li>	
									
							<li><a href="Visualization" class="not-active" id="visualizatioLink"><span
									style="font-size: 14px;color:#e9e9e9; font-weight:bolder;">Visualization </span></a></li>
							<li style="display:none;" id="ConfigurationId"><a href="spring-boot-web-jsp"  id="ConfigurationLink"><span
									id="my" style="font-size: 14px;color:#e9e9e9; font-weight:bolder;">Configuration </span></a></li>
									
							<!-- <li><a href="Visualization" class="not-active" id="visualizatioLink"><span
									style="font-size: 14px;color:#e9e9e9; font-weight:bolder;">Visualization </span></a></li> -->
						</ul>
					 </div>
				  </div>
				  </nav>
			</div>
	</div>
	<div class="col-sm-2">
				
				<ul class="nav navbar-top-links navbar-right"	style="margin-right: 5px">
					<img src="../assets/img/blank_user_icon.png" class="img-circle" />
					<label><strong><span style="color: #428bca"></span></strong></label>
					<li class="dropdown">
						<a class="dropdown-toggle"	data-toggle="dropdown"> <i	class="glyphicon glyphicon-chevron-down"></i></a>
						<ul class="dropdown-menu dropdown-user">
							<li>
								<a	 style="color: #428bca"> <i class="glyphicon glyphicon-user "></i>&nbsp; Manage Users</a>
							</li>
							<li>
								<a 	style="color: #428bca" href="logout"> <i	class="glyphicon glyphicon-log-out"></i>&nbsp; Logout</a>
							</li>
						</ul>
					</li>
				</ul>
		</div>
			</nav>
		</div>
	</div><br/><br/>
	<div id="left">
			<div class="media user-media well-small">
				</div>
			<!-- 	<ul id="menu" class="collapse"> -->
				
				
			<div class="navbar-default sidebar" role="navigation">
				<div  id="left-collapse" class="sidebar-nav navbar-collapse" >
					
					
					<ul id="tree3" >
					<li > <a id="main"  href="sql"><i
							class="glyphicon glyphicon-home"></i>&nbsp;&nbsp;<span
							style="font-size: 14px;"> Home</span></a>
					</li>
									
						<c:forEach var="listValue" items="${lists}" varStatus="status">
											
							<li><a id="tableid_${listValue.tableName}" draggable="true"
								href="#"> ${listValue.tableName}</a>
								<ul id="ulTable">
									<c:forEach var="listValue1" items="${listValue.colDetail}"
										varStatus="status1">
										<li draggable="true"><a
											id="${listValue.tableName}_column${status1.count}" href="#"
											 data-toggle="tooltip" title="${listValue1.colDataType}" data-placement="right"  class="red-tooltip">${listValue1.colName}</a></li>
																						
									</c:forEach>
								</ul></li>
						</c:forEach>


					</ul>
				</div>
				<!-- /.sidebar-collapse -->
			</div>
				
			<%-- 	
				<ul id="tree3" class="collapse">
				<c:forEach var="listValue" items="${lists}" varStatus="status">
							<li><a id="tableid_${listValue.tableName}" draggable="true"
								href="#">${listValue.tableName}</a>
								<ul>
									<c:forEach var="listValue1" items="${listValue.colDetail}"
										varStatus="status1">
										<li draggable="true"><a
											id="${listValue.tableName}_column${status1.count}" href="#">${listValue1.colName}</a></li>
									</c:forEach>
								</ul></li>
				</c:forEach>
				
				</ul> --%>
		</div>
		
		<div id="content">
			<div class="inner" id="inpart">
					<div class="row">
					<div class="col-sm-12">
						<div class="panel panel-default">
							<div class="panel-heading panel-heading-style" id="panelText">SQL
							
							<!-- <button type="submit" class="btn btn-primary" >Clear All</button> 
							<button id="getSqlQuery" type="submit" class="btn btn-primary">Get SQL Query</button> 
							<button id="executeSql" type="submit" class="btn btn-primary">Execute</button>  -->
											
							
								<!-- <div id="menuIcon"> --> &nbsp;&nbsp;&nbsp;
								<button class="btn btn-default"  id="saveBtn" data-toggle="tooltip" title="clear" onClick="clearData();"><i class='glyphicon glyphicon-remove-circle'></i>
									</button>
								<button class="btn btn-default"   id="getSqlQuery"   data-toggle="modal" data-target="#queryModal">
								<i class='glyphicon glyphicon-edit'></i></button>
								<button id="executeSql" class="btn btn-default executeSql" data-toggle="tooltip" title="Excute">
								<i class='glyphicon glyphicon-play-circle'></i></button>
							
									
								<!-- </div> -->
							</div>
							<div class="demo-container"><br/>
								<div class="row">
				
									<div class="col-sm-12">
									<textarea  class="form-control" id="sqlTextArea" rows="5" id="title" name="title" data-draggable="target"></textarea>
									</div>
								</div>
								<br/>
								<br/>	
							</div>
						</div>
					</div>
				</div>
				<div class="row" id="tableDiv" style="display:none;">
					<div class="col-sm-12">
						<div class="panel panel-default">
							<div class="panel-heading panel-heading-style" id="panelText">Table Data</div>
								<div class="demo-container"><br/>								
									<div class="row">
									<!-- <div class="col-sm-2"></div> -->
										<div class="col-sm-12">
											<div id="here_table">
												<table id="uploadTable" class="table table-striped table-bordered" cellspacing="0" width="100%"></table>
											</div>
										</div>
									</div>
								</div>
						</div>
					</div>
				</div>
				
			</div>
		</div>
		
</div>
<div class="modal fade" id="queryModal" role="dialog">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal">&times;</button>
													<div class="row"><div class="col-sm-3">
													<h4 class="modal-title"> Write Query </h4></div><div class="col-sm-2">
													<button id="executeSql" data-dismiss="modal" class="btn btn-default executeSql"  >
													<i class='glyphicon glyphicon-play-circle'></i></button></div>
													</div>
												</div>
												<div class="modal-body">
													 <textarea class="form-control"  rows="3" id="displaySqlQuery" name="displaySqlQuery" style="display:none;"></textarea>
												</div>
												<!-- <div class="modal-footer">
													<button class="btn btn-default btn-style" data-dismiss="modal" id="execute1" onClick="execute();">Execute</button>
												</div> -->
										
											</div>
										</div>
				</div>

<!-- </div> -->



   <%--  <div id="wrapper">

        <!-- Navigation -->
		<nav class="navbar navbar-default navbar-static-top" role="navigation"
			style="margin-bottom: 0">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="index.html">Self-Serive BI</a>


			</div>
			<!-- /.navbar-header -->
			<!-- <form action="login" class="form-signin" method="post" name="loginForm" > -->
			<div id="navbar-collapse-02" class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li class="active propClone"><a href="javascript:void(0)"
						class="navbar-brand" onclick="openTab(event, 'Sql')">SQL</a></li>
					<li class="propClone"><a href="Visualization">Visualization</a></li>
				</ul>
				<ul class="nav navbar-top-links navbar-right">

					<!-- /.dropdown -->
					<li class="dropdown"><a class="dropdown-toggle"
						data-toggle="dropdown" href="#"> <i class="fa fa-user fa-fw"></i>
							<i class="fa fa-caret-down"></i>
					</a>
						<ul class="dropdown-menu dropdown-user">
							<li><a href="#"><i class="fa fa-user fa-fw"></i> User
									Profile</a></li>
							<!-- <li><a href="#"><i class="fa fa-gear fa-fw"></i> Settings</a>
                        </li> -->
							<li class="divider"></li>
							<li><a href="login.html"><i class="fa fa-sign-out fa-fw"></i>
									Logout</a></li>
						</ul> <!-- /.dropdown-user --></li>
					<!-- /.dropdown -->
				</ul>
			</div>
			<!-- </form> -->
			<!-- /.navbar-collapse -->


			<!-- /.navbar-top-links -->

			<div class="navbar-default sidebar" role="navigation">
				<div class="sidebar-nav navbar-collapse">
					<!-- <ul class="nav" id="side-menu">                       
                        <li>
                            <a href="#"><i class="fa fa-bar-chart-o fa-fw"></i> Charts<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="flot.html">table 1</a>
                                </li>
                                <li>
                                    <a href="morris.html">table 2</a>
                                </li>
                            </ul>
                            /.nav-second-level
                        </li>                        
                    </ul> -->

					<!--  <ul id="tree3"> -->

					<ul id="tree3">


						<c:forEach var="listValue" items="${lists}" varStatus="status">
							<li><a id="tableid_${listValue.tableName}" draggable="true"
								href="#">${listValue.tableName}</a>
								<ul>
									<c:forEach var="listValue1" items="${listValue.colDetail}"
										varStatus="status1">
										<li draggable="true"><a
											id="${listValue.tableName}_column${status1.count}" href="#">${listValue1.colName}</a></li>
									</c:forEach>
								</ul></li>
						</c:forEach>


					</ul>


				</div>
				<!-- /.sidebar-collapse -->
			</div>
			<!-- /.navbar-static-side -->
		</nav>

		<div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <!-- <h6 class="page-header">Dashboard</h1> -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
				
					<!-- Start : Upper Part -->
					<div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa glyphicon-pencil fa-fw"></i> Enter Data                            
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <!-- <div id="morris-area-chart"></div> -->
							<div class="caption" id="rightDiv">
								<form class="form-group" role="form">
									<div class="form-group">
										<textarea data-draggable="target" class="col-sm-offset-4 col-sm-4" id="sqlTextArea" rows="5" id="title" name="title"></textarea>
									</div>
								</form>		
								
								<!-- <div class="row">
									<a href="#" class="btn btn-primary" role="button">Clear All</a>
									<a href="#" class="btn btn-primary" role="button">Get SQL Query</a>
									<a href="#" class="btn btn-primary" role="button">Execute</a>
								</div> -->
								<form class="form-group" >
									<div class="form-group"> 
										<div class="col-sm-offset-4 col-sm-12" id="button-space">
											<button type="submit" class="btn btn-primary" >Clear All</button> 
											<button id="getSqlQuery" type="submit" class="btn btn-primary">Get SQL Query</button> 
											<button id="executeSql" type="submit" class="btn btn-primary">Execute</button> 
										</div>
									</div>
								</form>
								<form class="form-horizontal">
									<div class="form-group">
										<textarea  class="col-sm-offset-3 col-sm-6" rows="3" id="displaySqlQuery" name="displaySqlQuery"></textarea>
									</div>
								</form>
							</div>	
                        </div>
						
                        <!-- /.panel-body -->
						
                    </div>
					<!-- End : Upper Part -->
                    
                    <!-- /.panel -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-table fa-fw"></i>Table                        
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <!-- <div class="row">                              
                                <div class="col-lg-12"> -->
								<div id="here_table">
									<table id="uploadTable" class="table table-striped table-bordered table-condensed"></table>
								</div>
								
                                    <!-- <div id="morris-bar-chart"></div> -->
                                <!-- </div> -->
                            <!-- </div> -->
                            <!-- /.row -->
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
     --%>
    
    
    <!-- /#wrapper -->

    <!-- jQuery -->
    <script src="../vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="../vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="../vendor/metisMenu/metisMenu.min.js"></script>

    <!-- Morris Charts JavaScript -->
    <script src="../vendor/raphael/raphael.min.js"></script>
    <script src="../vendor/morrisjs/morris.min.js"></script>
    <script src="../data/morris-data.js"></script>
	<script src="../vendor/tabsJs/tabJs.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="../dist/js/sb-admin-2.js"></script>
 
<script>
	function clearData() {
		$("#uploadTable").empty();
			$("#displaySqlQuery").css("display","none");
			$("#tableDiv").css("display","none");
			$("#sqlTextArea").val("");
	}
	/* function getSql() {
			$("#displaySqlQuery").css("display","block");
			$("#tableDiv").css("display","none");
	} 
function execute() {
		$("#uploadTable").empty();
			$("#displaySqlQuery").css("display","block");
			$("#tableDiv").css("display","block");
			$("#visualizatioLink").removeClass("not-active");
			
	} */
	
	
	</script>
</body>

</html>
