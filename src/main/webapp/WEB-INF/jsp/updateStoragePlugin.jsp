<!DOCTYPE html>
  <html lang="en">
    <head>
      <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">

      <title>Apache Drill</title>
      <link rel="stylesheet" href="../assets/css/main.css">
      <link rel="shortcut icon" href="/static/img/drill.ico">

<link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
      <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

      <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
      <!--[if lt IE 9]>
        <script src="/static/js/html5shiv.js"></script>
        <script src="/static/js/1.4.2/respond.min.js"></script>
      <![endif]-->

  <script src="/static/js/jquery.form.js"></script>
  
  
 <script type="text/javascript">
  $(document).ready(function(){
	  var msg=${message};
	  console.log("msg:"+msg);
	  if(msg.result=="success")
		  {
		  	$("#successMessageDiv").css("display","block");
		  	 $("#errorMessageDiv").css("display","none");
		  	$("#successMsgTxt").html(msg.result);
		  }
	  else
		  {
			$("#successMessageDiv").css("display","none");
		  $("#errorMessageDiv").css("display","block");
			$("#errorMsgTxt").html("Internal Server Error");
		  }
	  
  });
  </script>
    </head>

    <body role="document">
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

 <div id="successMessageDiv" style="display:none" class="msg-alert alert alert-success" role="alert">
        <button type="button" class="close" data-hide="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span></button>
       <div id="successMsgTxt"> </div></div>
        
<div id="errorMessageDiv" style="display:none" class="msg-alert alert alert-danger" role="alert">
        <button type="button" class="close" data-hide="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span></button>
        <div id="errorMsgTxt"></div></div>   

	<h3 id="configLabel">Self Service BI Drill configuration</h3>
	
  <h4>Configuration</h4>
  <form id="updateForm" role="form" action="updateStorage" name="updateStoragePlugin" method="POST">
    <input type="hidden" name="storageName" value="${name}" />
    <div class="form-group">
      <textarea class="form-control" id="config" rows="20" cols="50" name="jsonString" style="font-family: Courier;">
      ${pluginDetails}
      </textarea>
    </div>
    <a class="btn btn-default" href="/spring-boot-web-jsp">Back</a>
    <button class="btn btn-default" type="submit" onclick="doUpdate();">
      Update
    </button>
        <a id="enabled" class="btn btn-default" href="disable?name=${name}">Disable</a>
      <a id="del" class="btn btn-danger" href="delete?name=${name}" onClick="deleteFunction();">Delete</a>
  </form>
  <br>
  <div id="message" class="hidden alert alert-info">
  </div>
  
<%--   <h3>${message}</h3>
  <h3>${jsonData}</h3> --%>
  </div>
  </div>
  </div>
  <script>
    $.get("/storage/hbase.json", function(data) {
      $("#config").val(JSON.stringify(data.config, null, 2));
    });
    $("#enabled").click(function() {
      $.get("/storage/hbase/enable/true", function(data) {
        $("#message").removeClass("hidden").text(data.result).alert();
        setTimeout(function() { location.reload(); }, 800);
      });
    });
    function doUpdate() {
      $("#updateForm").ajaxForm(function(data) {
        var messageEl = $("#message");
        if (data.result == "success") {
          messageEl.removeClass("hidden")
                   .removeClass("alert-danger")
                   .addClass("alert-info")
                   .text(data.result).alert();
          setTimeout(function() { location.reload(); }, 800);
        } else {
          messageEl.addClass("hidden");
          // Wait a fraction of a second before showing the message again. This
          // makes it clear if a second attempt gives the same error as
          // the first that a "new" message came back from the server
          setTimeout(function() {
            messageEl.removeClass("hidden")
                     .removeClass("alert-info")
                     .addClass("alert-danger")
                     .text("Please retry: " + data.result).alert();
          }, 200);
        }
      });
    };
    function deleteFunction() {
      var temp = confirm("Are you sure?");
      if (temp == true) {
        $.get("/storage/hbase/delete", function(data) {
          window.location.href = "/storage";
         
        });
        
        
      }
    };
  </script>
      </div>
    </body>
  </html>
