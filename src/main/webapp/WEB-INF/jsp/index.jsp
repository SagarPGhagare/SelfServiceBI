<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<link rel="stylesheet" href="../assets/css/main.css">
<link rel="shortcut icon" href="/static/img/drill.ico">

<link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
      <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
      
      <style>
.switch {
  position: relative;
  display: inline-block;
  width: 55px;
  height: 30px;
}

.switch input {display:none;}

.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  -webkit-transition: .4s;
  transition: .4s;
}

.slider:before {
  position: absolute;
  content: "";
  height: 25px;
  width: 26px;
  left: 0px;
  bottom: 4px;
  background-color: white;
  -webkit-transition: .4s;
  transition: .4s;
}

input:checked + .slider {
  background-color: #2196F3;
}

input:focus + .slider {
  box-shadow: 0 0 1px #2196F3;
}

input:checked + .slider:before {
  -webkit-transform: translateX(26px);
  -ms-transform: translateX(26px);
  transform: translateX(26px);
}

/* Rounded sliders */
.slider.round {
  border-radius: 34px;
}

.slider.round:before {
  border-radius: 50%;
}
</style>
      
      
       <script type="text/javascript">
  $(document).ready(function(){
	  
	  $("#overlay").css("display","block");
  	/* $("#ConfigMenu").attr('class', 'blur'); */
  	
  	$("#storageLink").click(function(){
  		/* $("#ConfigMenu").removeClass('blur'); */
  		$("#ConfigMenu").css("display","block");
  		$("#queryDiv").css("display","none");
  		$("#textStorageBox").css("display","block");
  		
  	});
  	
  	$("#queryLink").click(function(){
  		$("#ConfigMenu").css("display","none");
  		$("#queryDiv").css("display","block");
  		$("#textStorageBox").css("display","none");
  	});
  	
  });
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
						 <ul class="nav nav-tabs" id="topLink">
						 
				 
						 
						 <li ><a href="sql"  style="color:white!important;"><i
							class="glyphicon glyphicon-home"></i> </a></li>	
									
							<li class="active"><a id="storageLink" data-toggle="tab"><span
									style="font-size: 14px;color:#e9e9e9; font-weight:bolder;">Storage </span></a></li>
							<li ><a  id="queryLink" data-toggle="tab"><span
									 style="font-size: 14px;color:#e9e9e9; font-weight:bolder;">Views </span></a></li>
							<!-- <li><a href="Visualization" class="not-active" id="visualizatioLink"><span
									style="font-size: 14px;color:#e9e9e9; font-weight:bolder;">Visualization </span></a></li> -->
						</ul>
					 </div>
				  </div>
				  </nav>
			</div>
	</div>
	</nav>
		</div>
	</div><br/><br/>
<div id="contentConfig" >
	<div class="inner" id="inpart">

<div class="row">
	<div class="col-sm-6">
		<label id="configLabel">Self Service BI Drill configuration</label>
	</div>
	<div class="col-sm-6" id="textStorageBox">
	   <form class="form-inline" id="newStorage" role="form" action="create" method="post" name="createPlugin">
	      <div class="form-group">
	        <input type="text" class="form-control" name="storageName" id="storageName" value="" style=" width: 141%;     margin-top: -10%; padding-right: 50px;" placeholder="Add Storage Name" required>
	       </div>
	     
	      <input type="image" src="../assets/img/add.jpg" style="margin-left: 39px;  height: 30px;width: 50px; " onclick="doSubmit()"/>
    
     <!--  <button type="submit" class="btn btn-default" onclick="doSubmit()">Create</button> -->
   		 </form>
	
	</div>

</div>

	<hr>
	
 <div id="ConfigMenu" class="tab-pane fade in active" >
 	<div class="row">
 		<div class="col-sm-1"></div>
 		<div class="col-sm-4">
 		 <label style="font-weight:bolder!important;
			font-size:16px!important;">Global Data Sources</label>
 		</div>
 		<div class="col-sm-3"></div>
 		<div class="col-sm-4">
 		 <!-- <label style="font-weight:bolder!important;
			font-size:16px!important;">Local Data Sources</label> -->
 		</div>
 	</div>
 	<br/>
 	<div class="row">
 	
 	<div class="col-sm-6">
 		  <div class="table-responsive">
			    <table class="table">
			      <tbody>
			             <c:forEach var="user" items="${lists}">
			                <tr>
			                    <td><c:out value="${user.name}" /></td>
			                    <td ></td><td></td><td></td><td></td><td></td><td></td><td></td>
			                    <td style="border:none;">
			                    
			                      <label class="switch">
			                    
			               		 <a class="btn btn-primary" style="margin-left: -139%;" href="update?name=${user.name}">Update</a>
			                                
								  <input type="checkbox"  onclick='window.location.assign("disable?name=${user.name}")' >
								  <div class="slider round">
											<label style="margin-left:57%!important;margin-top: 7%;">D</label>
								  </div>
								</label>
			                
			                
			               <%--  <a class="btn btn-default" href="disable?name=${user.name}">Disable</a> --%>
			              </td>
			                </tr>
			            </c:forEach>
			              
			      </tbody>
			    </table>
  			</div>
  	</div>
  	<div class="col-sm-6">
  		<div class="table-responsive">
		    <table class="table">
		      <tbody>
		            <c:forEach var="user" items="${lo}">
		                <tr>
		                    <td><c:out value="${user.name}" /></td>
		                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
		                    <td style="border:none;">  <label class="switch">
		                		<a class="btn btn-primary" style="margin-left: -139%;" href="updateStoragePluginDisable?name=${user.name}" >Update</a>
		                
								  <input type="checkbox"  onclick='window.location.assign("enable?name=${user.name}")' checked >
								  <div class="slider round">
										<label style="margin-left:24%!important;margin-top: 7%;">E</label>
								  </div>
								
								</label>
		                
		             			 <%--   <a class="btn btn-primary" href="enable?name=${user.name}">Enable</a> --%>
		                        </td>
		                </tr>
		            </c:forEach>
		      </tbody>
		    </table>
 	 </div>
  	</div>
  	
 	</div>
 
 

  </div>
  
  <div id="queryDiv" style="display:none;">
  <label id="queryLabel">Query</label>
  		<div class="row">
	  		<div class="col-sm-12">
				<textarea  class="form-control" id="sqlTextArea" rows="5" id="title" name="title" data-draggable="target"></textarea>
				</div>
		</div>
		<br/>
		 <button class="btn btn-default btn-style" >Submit</button>
		
		
  </div>
  
 
  
 <!--  <div class="page-header">
  </div>
  <div>
    <h4>New Storage Plugin</h4>
    <form class="form-inline" id="newStorage" role="form" action="create" method="post" name="createPlugin">
      <div class="form-group">
        <input type="text" class="form-control" name="storageName" placeholder="Storage Name">
      </div>
      <button type="submit" class="btn btn-default" onclick="doSubmit()">Create</button>
    </form> -->
  </div>
  </div>
  </div>
  </div>
  <script>
  function doUpdate() {
      var name = document.getElementById("storageName");
      var form = document.getElementById("newStorage");
      form.action = "/spring-boot-web-jsp/updateStoragePlugin";
      form.submit();
    };
    function doSubmit() {
      var name = document.getElementById("storageName").value;
      
      if(name=="")
    	  {
    	  	$("#storageName").addClass("required");
    	  }
      else{
      var form = document.getElementById("newStorage");
      form.action = "/spring-boot-web-jsp/create" + name.value;
      form.submit();
      }
    };
    <!-- 
    function doEnable(name, flag) {
      $.get("/storage/" + name + "/enable/" + flag, function(data) {
        location.reload();
      });
    }; -->
    
 
  </script>
  

</body>
</html>