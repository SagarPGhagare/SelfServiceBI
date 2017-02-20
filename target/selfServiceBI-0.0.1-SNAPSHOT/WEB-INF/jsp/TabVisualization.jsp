<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>Self-Serive BI</title>

<!-- Bootstrap Core CSS -->

<link rel="stylesheet" href="../assets/css/main.css">
<link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="../vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="../dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Morris Charts CSS -->
<link href="../vendor/morrisjs/morris.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="../vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">


<!-- Remove for visualization top -->
<!--  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> -->

<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="../assets/js/jquery-2.0.3.min.js"></script>
<script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../assets/js/jquery-ui.js"></script>

<!-- REcently removed
       <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
       <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
 -->


<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<script src="http://canvasjs.com/assets/script/canvasjs.min.js"></script>
<style>
.tree, .tree ul {
	margin: 0;
	padding: 0;
	list-style: none;
	line-height: 0em !important;
}

.tree ul {
	margin-left: 1em;
	position: relative;
	border-top: 1px solid rgb(216, 215, 215);
}

.tree ul ul {
	margin-left: .5em;
	line-height: 0em !important;
}

.tree ul:before {
	/*  content:""; */
	display: block;
	width: 0;
	position: absolute;
	top: 0;
	bottom: 0;
	left: 0;
	border-left: 1px solid
}

.tree li {
	margin: 9px;
	padding: 0 1em;
	line-height: 2em;
	color: #369;
	font-weight: 700;
	position: relative
}

#ulTable >li :before
{
 content:"\e250"; 
  font-family: 'Glyphicons Halflings';
}
#ulTable>li {
	margin: 0px !important;
}

.tree>li>a:hover, .tree>li>a:focus {
	color: #fff;
	text-decoration: none;
	background-color: #428bca;
	outline: none;
}

.tree ul li:before {
	/* content: ""; */
	display: block;
	width: 10px;
	height: 0;
	border-top: 1px solid;
	margin-top: -1px;
	position: absolute;
	top: 1em;
	left: 0
}

.tree ul li:last-child:before {
	line-height: 0em;
	background: #fff;
	height: auto;
	top: 1em;
	bottom: 0
}

.indicator {
	margin-right: 5px;
}

.tree li a {
	text-decoration: none;
	color: #369;
}

.tree li button, .tree li button:active, .tree li button:focus {
	text-decoration: none;
	color: #369;
	border: none;
	background: transparent;
	margin: 0px 0px 0px 0px;
	padding: 0px 0px 0px 0px;
	outline: 0;
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
      addEventListener('dragstart', function(e) {
             item = e.target;
             e.dataTransfer.setData('text', e.target.id);
      }, false);
              
      addEventListener('dragover', function(e) {
    	  e.preventDefault();
   	  }, false);  
      
      var xData , yData;
      var tableNmArr = [];
      var rowNmArr = [];
      var colNmArr = [];
      var tableNmArr2 = [];
      var chartType;
      var xTextVal, yTextVal;
   	 
   	  var table1;
  	  var table2;
      var column1;
      var column2;
      var joinType;
      
      //drop event to allow the element to be dropped into valid targets
      document.addEventListener('drop', function(e)
      {
    	  //if this element is a drop target, move the item here 
          //then prevent default to allow the action (same as dragover)
      
    	      if(e.target.getAttribute('data-draggable') == 'targetX')
               {
                    e.preventDefault();
                    var data=e.dataTransfer.getData("text");
                    xData = data;
                    var nodeCopy = document.getElementById(data);
                    var addtext = nodeCopy.innerText + ','
                    var tblNm = data.split("_",1);
                    tableNmArr.push(tblNm+"."+addtext);
                    $("#xCoordinate").val($("#xCoordinate").val() + addtext);
                    
                    
                    var xTextData = document.getElementById('xCoordinate').value;
	                var yTextData = document.getElementById('yCoordinate').value;
	                var strarray = xTextData.split(',');
	                var ystrarray = yTextData.split(',');
             
                 	var str1=strarray.join(" ");
                
                 	var arrdrag=[]
                    var listItems = document.getElementById('tree3').getElementsByTagName('li');
                           
                    for(k=0;k<listItems.length;k++)
                     {
                           for(j=0;j<strarray.length;j++)
                           {
                             if((strarray[j]==listItems[k].innerText)||(ystrarray[0]==listItems[k].innerText))    
                                  {
                                          tableName=listItems[k].lastChild.getAttribute("id");
                                          t=tableName.substr(0, tableName.indexOf('_'));
                                          if(arrdrag.length==0)
                                                 {
                                                 arrdrag.push(t);
                                                 }
                                          else
                                                 {
                                                 if(arrdrag.indexOf(t)==-1)
                                                        {
                                                        arrdrag.push(t);
                                                        }     
                                                 }
                                  }
                           }
                      }
                
                 /* if(strarray.length!=2 && arrdrag.length!=1) */
                 //alert("tableNmArr "+tableNmArr.length);
                       if(strarray.length>=1 && arrdrag.length!=1 && ystrarray.length==1 && ystrarray[0]!="")
                       {
                           join(strarray,ystrarray);
                       }
               }
    	  
               if(e.target.getAttribute('data-draggable') == 'targetY')
               {
                    e.preventDefault();
                    var data=e.dataTransfer.getData("text");
                    //alert(data);
                    yData = data;
                    var nodeCopy = document.getElementById(data);
                    var addtext = nodeCopy.innerText + ''
                    var tblNm = data.split("_",1);
                    tableNmArr.push(tblNm+"."+addtext);
                    $("#yCoordinate").val(addtext);
                    
                    var xTextData = document.getElementById('xCoordinate').value;
                    var yTextData = document.getElementById('yCoordinate').value;
                    var strarray = xTextData.split(',');
                    var ystrarray = yTextData.split(',');
                    var arrdragY=[];
                     var listItems = document.getElementById('tree3').getElementsByTagName('li');
                     for(k=0;k<listItems.length;k++)
                     {
                           for(j=0;j<ystrarray.length;j++)
                                  {
                                  if((strarray[j]==listItems[k].innerText)||(ystrarray[0]==listItems[k].innerText))    
                                        {
                                         tableName=listItems[k].lastChild.getAttribute("id");
                                          t=tableName.substr(0, tableName.indexOf('_'));
                                          if(arrdragY.length==0)
                                          {
                                                 arrdragY.push(t);
                                          }
                                   else
                                          {
                                          if(arrdragY.indexOf(t)==-1)
                                                 {
                                                 arrdragY.push(t);
                                                 }     
                                          }
                                        }
                                  }
                     }
                     //alert("tableNmArr "+tableNmArr.length+"  ");
                    if(strarray.length>1 && ystrarray.length==1 && arrdragY.length!=1)
                	{
                		join(strarray,ystrarray);
                    }
                    
                    
                    /* var xTextData = document.getElementById('xCoordinate').value;
                    var yTextData = document.getElementById('yCoordinate').value;
                    var select = document.getElementById('filter');
                    var opt = document.createElement('option');
                    alert("xTextData >>"+xTextData);
                    opt.value = xTextData;
                    opt.innerHTML =xTextData;
                    select.appendChild(opt);
                               
                    var opt1 = document.createElement('option');
                    opt1.value = yTextData;
                    opt1.innerHTML =yTextData;
                               
                    select.appendChild(opt1); */
                   
/*                     var select = document.getElementById('filter');
                    
                    var yTextData = document.getElementById('yCoordinate').value;
                    
                    
                   console.log(tableNmArr);
                   
                   for(var m=0;m<tableNmArr.length;m++)
                	   {
                	   		//if(tableNmArr[m].includes(yTextData))
                	   			//{
                	   			var opt1 = document.createElement('option');
                	   		 	opt1.value =tableNmArr[m] ;
                             	opt1.innerHTML =tableNmArr[m];
                             	select.appendChild(opt1);
                	   			//}
                	   }
                    
                   alert("op value:"+document.getElementById("filter").value) */
                    /* <c:forEach var="party" items="${tableNmArr}">
                   
                    opt1.valuevalue="${party}";
                	</c:forEach>
                	 */
                    
               }

    	  
          if(e.target.getAttribute('data-draggable') == 'targetLabel')
          {
               e.preventDefault();
               var data=e.dataTransfer.getData("text");
               //alert(data);
               yData = data;
               var nodeCopy = document.getElementById(data);
               var addtext = nodeCopy.innerText + ''
               var tblNm = data.split("_",1);
               tableNmArr.push(tblNm+"."+addtext);
               colNmArr.push(tblNm+"."+addtext);
               $("#targetLabel").val(addtext);
          }
          
          /* Start : To show data in Columns of Filters */
          var select = document.getElementById('filter');
          
          var yTextData = document.getElementById('yCoordinate').value;
          
          
         console.log(tableNmArr);
         
         for(var m=0;m<tableNmArr.length;m++)
      	   {
      	   			var opt1 = document.createElement('option');
      	   		 	opt1.value =tableNmArr[m] ;
      	   	
      	   		 	var splitVal = tableNmArr[m].substr(tableNmArr[m].indexOf('.')+1,tableNmArr[m].length);
                   	opt1.innerHTML =splitVal;
      	   }
         select.appendChild(opt1);
          
         //alert("op value:"+document.getElementById("filter").value)
         /* End : To show data in Columns of Filters */
          
      }, false);
           
           //dragend event to clean-up after drop or abort
           //which fires whether or not the drop target was valid
           document.addEventListener('dragend', function(e)
           {
               item = null;
           
           }, false);
           
        
           /* start : line button */
           $('#lineChart').on('click', function(event) {
        	  xTextVal= document.getElementById('xCoordinate').value;
      	   	  yTextVal= document.getElementById('yCoordinate').value;
      	   	  
      	   	 table1=document.getElementById("sel1").value;
        	 table2=document.getElementById("sel2").value;
             column1=document.getElementById("selc1").value.trim();
             column2=document.getElementById("selc2").value.trim();
             joinType=document.getElementById("seljoin").value; 
   	   		 if((xTextVal=="")||(yTextVal==""))
   		   	 {
   		   	 	$(".errorTxt").css("display","block");
   		        $("#pieChartDiv").css("display","none");  
   		   	 }
   	   		 else
   	   		 {
   	   			 $(".errorTxt").css("display","none");
        	     $("#lineChartDiv").css("display","block");
        	     $("#barChartDiv").css("display","none");
        	     $("#pieChartDiv").css("display","none");
        	
	              event.preventDefault();
	              var vx = $("#xCoordinate").val();
	              var vy = $("#yCoordinate").val();
	             
	              chartType =  "line";
	              alert("rowNmArr >> "+rowNmArr+"tableNmArr >> "+tableNmArr);
	              var barchartData = {
	            		   "xAxis" : vx,
		                     "yAxis" : vy,
		                     /*"xData" : xData,
		                     "yData" : yData, */
		                     "tableNmArr" : tableNmArr,
		                     "rowNmArr" : rowNmArr,
		                     "colNmArr" : colNmArr,
		                     "table1" : table1,
		                     "table2" : table2,
		                     "column1" : column1,
		                     "column2" :column1,
		                     "joinType" :joinType,
		                     "chartType" : chartType
	              }
	              $.ajax({
	                    type : "POST",
	                    contentType : "application/json",
	                    url : "http://localhost:8080/executeBar",
	                    data : JSON.stringify(barchartData),
	                    dataType : 'json',
	                    timeout : 100000,
	                    success : function(data) {
	                           console.log("barchart>> "+data);
	                                                      
	                           $.each(data, function(index, element) {
	                                  
                           $.each(element,function(k,v){
                                   console.log(k+" : "+ v); 
                           });          
                           var chart = new CanvasJS.Chart("lineContainer", {
                                  title:{
                                         text: ""              
                                  },
                                  data: element,
                                  legend:{
                                      cursor:"pointer",
                                      itemclick: function(e){
                                        if (typeof(e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
                                        	e.dataSeries.visible = false;
                                        }
                                        else {
                                          e.dataSeries.visible = true;
                                        }
                                      	chart.render();
                                      }
                                    },
                           });
                           chart.render();
                           });
                           
                         
                    },
                    error : function(e) {
                           console.log("ERROR: ", e);
                           
                    },
                    done : function(e) {
                           console.log("DONE");
                    }
              });

         }
           }); 
           /* End : line button  */
           
           /* start : pie button */ 
           $('#pieChart').on('click', function(event) {
        	   
        	   xTextVal= document.getElementById('xCoordinate').value;
        	   yTextVal= document.getElementById('yCoordinate').value;
        	   
        	   table1=document.getElementById("sel1").value;
           	 table2=document.getElementById("sel2").value;
               column1=document.getElementById("selc1").value.trim();
               column2=document.getElementById("selc2").value.trim();
               joinType=document.getElementById("seljoin").value; 
               
     	   if((xTextVal=="")||(yTextVal==""))
     		   {
     		   $(".errorTxt").css("display","block");
     		   $("#pieChartDiv").css("display","none");  
     		   }
     	   
     	   else
     		   {
     		   $(".errorTxt").css("display","none");
        	   $("#pieChartDiv").css("display","block");
        	   $("#barChartDiv").css("display","none");
        	   $("#lineChartDiv").css("display","none");
        	   var xTextData = document.getElementById('xCoordinate').value;
        	
              event.preventDefault();         
           
              var vx = $("#xCoordinate").val();
              var vy = $("#yCoordinate").val();
             
              chartType =  "pie";
              var barchartData = {
       		     "xAxis" : vx,
                 "yAxis" : vy,
                 /* "xData" : xData,
                 "yData" : yData, */
                 "tableNmArr" : tableNmArr,
                 "rowNmArr" : rowNmArr,
                 "colNmArr" : colNmArr,
                 "table1" : table1,
                 "table2" : table2,
                 "column1" : column1,
                 "column2" :column1,
                 "joinType" :joinType,
                 "chartType" : chartType
             }
              $.ajax({
                    type : "POST",
                    contentType : "application/json",
                    url : "http://localhost:8080/executeBar",
                    data : JSON.stringify(barchartData),
                    dataType : 'json',
                    timeout : 100000,
                    success : function(data) {
                           console.log("barchart>> "+data);
                                                      
                           $.each(data, function(index, element) {
                                  
                           $.each(element,function(k,v){
                                   console.log(k+" : "+ v); 
                           });          
                           var chart = new CanvasJS.Chart("pieContainer", {
                                  title:{
                                         text: ""              
                                  },
                                  data: element,
                                  legend:{
                                      cursor:"pointer",
                                      itemclick: function(e){
                                        if (typeof(e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
                                        	e.dataSeries.visible = false;
                                        }
                                        else {
                                          e.dataSeries.visible = true;
                                        }
                                      	chart.render();
                                      }
                                    },
                           });
                           chart.render();
                           });
                           
                           
                    },
                    error : function(e) {
                           console.log("ERROR: ", e);
                         
                    },
                    done : function(e) {
                           console.log("DONE");
                    }
              });
			
     		   }
           }); 
           /* End : pie button */ 
           
           /* start : Horizontal Bar execute button */
           $('#barHBtn').on('click', function(event) {
        	   $("#barChartDiv").css("display","block");
        	   $("#lineChartDiv").css("display","none");
        	   $("#pieChartDiv").css("display","none");
        	   
              event.preventDefault(); // To prevent following the link (optional)
              var vx = $("#xCoordinate").val();
              var vy = $("#yCoordinate").val();
              table1=document.getElementById("sel1").value;
          	 table2=document.getElementById("sel2").value;
              column1=document.getElementById("selc1").value.trim();
              column2=document.getElementById("selc2").value.trim();
              joinType=document.getElementById("seljoin").value; 
              //alert("vx >> "+vx+" vy >> "+vy)
                
              chartType = "bar";
              var barchartData = {
            		  	 "xAxis" : vx,
	                     "yAxis" : vy,
	                     /*"xData" : xData,
	                     "yData" : yData, */
	                     "tableNmArr" : tableNmArr,
	                     "rowNmArr" : rowNmArr,
	                     "colNmArr" : colNmArr,
	                     "table1" : table1,
	                     "table2" : table2,
	                     "column1" : column1,
	                     "column2" :column1,
	                     "joinType" :joinType,
	                     "chartType" : chartType
            }
              $.ajax({
                    type : "POST",
                    contentType : "application/json",
                    url : "http://localhost:8080/executeBar",
                    data : JSON.stringify(barchartData),
                    dataType : 'json',
                    timeout : 100000,
                    success : function(data) {
                           console.log("barchart>> "+data);
                                                      
                           $.each(data, function(index, element) {
                                  
                           $.each(element,function(k,v){
                                   console.log(k+" : "+ v); 
                           });          
                           var chart = new CanvasJS.Chart("chartContainer", {
                                  title:{
                                         text: ""              
                                  },
                                  data: element,
                                  legend:{
                                      cursor:"pointer",
                                      itemclick: function(e){
                                        if (typeof(e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
                                        	e.dataSeries.visible = false;
                                        }
                                        else {
                                          e.dataSeries.visible = true;
                                        }
                                      	chart.render();
                                      }
                                    },
                           });
                           chart.render();
                           });
                           
                           //$("#barChart").val(data);
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
           /* End : Horizontal Bar execute butto */
           
           /* start : Bar execute button */
         $('.barVBtn').on('click', function(event) {
        	   
      	 xTextVal= document.getElementById('xCoordinate').value;
      	 yTextVal= document.getElementById('yCoordinate').value;
      	 
      	 table1=document.getElementById("sel1").value;
     	 table2=document.getElementById("sel2").value;
         column1=document.getElementById("selc1").value.trim();
         column2=document.getElementById("selc2").value.trim();
         joinType=document.getElementById("seljoin").value;
         
         var filter = document.getElementById("filter").value; 
         var operator = document.getElementById("operator").value;
         var distinctValue = document.getElementById("distinctValue").value;
         
         chartType =  "column";
        
         //alert("table1 >> "+table1+" table2 >> "+table2+" column1 >> "+column1+" column2>> "+column2);
	   	   if((xTextVal=="")||(yTextVal==""))
	   		   {
	   		   $(".errorTxt").css("display","block");
	   		   $("#pieChartDiv").css("display","none");  
	   		   }
	   	   
	   	   else
	   		   {
	   		   $(".errorTxt").css("display","none");
	        	   $("#barChartDiv").css("display","block");
	        	   $("#lineChartDiv").css("display","none");
	        	   $("#pieChartDiv").css("display","none");
	        	   
	              event.preventDefault(); // To prevent following the link (optional)
	             
	              var vx = $("#xCoordinate").val();
	              var vy = $("#yCoordinate").val();
	              var barchartData = {
	                     "xAxis" : vx,
	                     "yAxis" : vy,
	                     /*"xData" : xData,
	                     "yData" : yData, */
	                     "tableNmArr" : tableNmArr,
	                     "rowNmArr" : rowNmArr,
	                     "colNmArr" : colNmArr,
	                     "table1" : table1,
	                     "table2" : table2,
	                     "column1" : column1,
	                     "column2" :column1,
	                     "joinType" :joinType,
	                     "chartType" : chartType,
	                     "filter" : filter,
	                     "operator" : operator,
	                     "distinctValue" : distinctValue
	           	  }
	              $.ajax({
	                    type : "POST",
	                    contentType : "application/json",
	                    url : "executeBar",
	                    data : JSON.stringify(barchartData),
	                    dataType : 'json',
	                    timeout : 100000,
	                    success : function(data) {
	                    	$("#executeBar").attr("checked","true");
	                           console.log("barchart>> "+data);
	                                                      
	                           $.each(data, function(index, element) {
	                                  
	                           $.each(element,function(k,v){
	                                   console.log(k+" : "+ v); 
	                           });          
	                           var chart = new CanvasJS.Chart("chartContainer", {
	                                  title:{
	                                         text: ""              
	                                  },
	                                  data: element,
	                                  legend:{
	                                      cursor:"pointer",
	                                      itemclick: function(e){
	                                        if (typeof(e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
	                                        	e.dataSeries.visible = false;
	                                        }
	                                        else {
	                                          e.dataSeries.visible = true;
	                                        }
	                                      	chart.render();
	                                      }
	                                    },	                                	 
	                           });
	                           chart.render();
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
             
         }     

           }); 
           
          function join(strarray,ystrarray)
           {
        	  $('#joinModal').modal('show');
        	  
        	  $(".showColumn").css("display","none");
        	  $(".showColumn2").css("display","none");
        	  
        	  $('#sel1').find('option').remove();
         	  $('#sel2').find('option').remove(); 
         	  
        	  var tableName="",t="",select="";
        	  var arrTab=[];
        	  
        	
        	  
    	 for (var i = 0; i < strarray.length; i++)
    	 {
           	  	var tableval=strarray[i];
           	  	console.log("table:"+tableval);
           		 select = document.getElementById('sel1');
           	
           		var listItems = document.getElementById('tree3').getElementsByTagName('li');
		           	
		        for(k=0;k<listItems.length;k++)
		       {
		        	for(j=0;j<strarray.length;j++)
		        	{
		        	if(strarray[j]==listItems[k].innerText)	
		        		{
		        			 tableName=listItems[k].lastChild.getAttribute("id");
		        			 t=tableName.substr(0, tableName.indexOf('_'));
		        			 if(arrTab.length==0)
		        				 {
		        				 arrTab.push(t);
		        				 }
		        			 else
		        				 {
		        				 if(arrTab.indexOf(t)==-1)
		        					 {
		        				 	arrTab.push(t);
		        					 }	
		        				 }
		        		}
		        	}
		        }
    	 }
    		   
		    	 var opts1 = document.createElement('option');
				    opts1.innerHTML = "Select";
				    select.appendChild(opts1);
    		   for(var p=0;p<arrTab.length;p++)
	        	{
    			   var opt = document.createElement('option');
	   			 	opt.value = arrTab[p];
	                 opt.innerHTML = arrTab[p];
	                 select.appendChild(opt);
	        	}
       	
    		   var arrTab2=[];
    		   var tableName2="",t2="";
    		   
    		   for (var i = 0; i < ystrarray.length; i++) {
              	  	var tableval=ystrarray[i];
              	  	//alert("table:"+tableval);
              	  	console.log("table:"+tableval);
              	var  selecty = document.getElementById('sel2');
              	
              	var listItems2 = document.getElementById('tree3').getElementsByTagName('li');
   		           	
   		        for(k=0;k<listItems2.length;k++)
   		       {
   		        	for(j=0;j<ystrarray.length;j++)
   		        	{
   		        	if(ystrarray[j]==listItems2[k].innerText)	
   		        		{
   		        			 tableName2=listItems2[k].lastChild.getAttribute("id");
   		        			 t2=tableName2.substr(0, tableName.indexOf('_'));
   		        			 
   		        			 if(arrTab2.length==0)
	        				 {
   		        				arrTab2.push(t2);
	        				 }
	        			 else
	        				 {
	        				 if(arrTab2.indexOf(t2)==-1)
	        					 {
	        					 arrTab2.push(t2);
	        					 }	
	        				 }
   		        			
   		        		}
   		        	
   		        	}
   		        }
   		      
       		   }
    		   var opts = document.createElement('option');
    		    opts.innerHTML = "Select";
               selecty.appendChild(opts);
    		   
    		   for(var p=0;p<arrTab2.length;p++)
	        	{
    			   var opty = document.createElement('option');
	   			 	opty.value = arrTab2[p];
	                 opty.innerHTML = arrTab2[p];
	                 selecty.appendChild(opty);
	        	}
		    	
           }
          
       
          $('#saveBtn').on('click', function() { 
          
  			
  			tableNmArr.length=0;
  			$("#barChartDiv").css("display","none");
  			$("#pieChartDiv").css("display","none");
  			$("#lineChartDiv").css("display","none");
  			$("#xCoordinate").val("");
  			$("#yCoordinate").val("");
  			$("#targetLabel").val("");
  			$("#filter").val("");
  			$("#distinctValue").val("");
  			
  		});
          
      /*     $('#barJoinBtn').on('click', function() {
              
        	  var xTextData = document.getElementById('xCoordinate').value;
              var yTextData = document.getElementById('yCoordinate').value;
                     var select = document.getElementById('filter');
                  		var opt = document.createElement('option');
                          opt.value = xTextData;
                         opt.innerHTML =xTextData;
                         select.appendChild(opt);
                         
                         var opt1 = document.createElement('option');
                         opt1.value = yTextData;
                        opt1.innerHTML =yTextData;
                         
                         select.appendChild(opt1);
               
             }); */

        
  });

  </script>

</head>

<body>

	<div id="wrap" style="position: fixed; overflow-y: scroll !important;">

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
							<span
								style="font-size: 40px; color: #ffffff; font-weight: bolder;">Mastek</span>
							<span
								style="font-size: 14px; color: #ffffff; font-weight: bolder;">Self-Service
								BI </span>
							<!-- <a class="navbar-brand logo" > <img src="images/mastek.png" alt="Mastek Logo" />
					</a> -->
						</header>
					</div>
					<div class="col-sm-6">
						<div class="topMenu">
							<nav class="navbar navbar-default">
								<div class="container-fluid">
									<div class="collapse navbar-collapse"
										id="bs-example-navbar-collapse-1">
										<ul class="nav navbar-nav" id="topLink">

											<li><a href="sql"><span
													style="font-size: 14px; color: #e9e9e9; font-weight: bolder;">SQL
												</span></a></li>

											<li><a href="Visualization" id="visualizatioLink"><span
													style="font-size: 14px; color: #e9e9e9; font-weight: bolder;">Visualization
												</span></a></li>
							
											<li style="display:none;" id="ConfigurationId"><a href="spring-boot-web-jsp"  id="ConfigurationLink"><span
									id="my" style="font-size: 14px;color:#e9e9e9; font-weight:bolder;">Configuration </span></a></li>

										</ul>
									</div>
								</div>
							</nav>
						</div>
					</div>
					<div class="col-sm-2">

						<ul class="nav navbar-top-links navbar-right"
							style="margin-right: 5px">
							<img src="../assets/img/blank_user_icon.png" class="img-circle" />
							<label><strong><span style="color: #428bca"></span></strong></label>
							<li class="dropdown"><a class="dropdown-toggle"
								data-toggle="dropdown"> <i
									class="glyphicon glyphicon-chevron-down"></i></a>
								<ul class="dropdown-menu dropdown-user">
									<li><a style="color: #428bca"> <i
											class="glyphicon glyphicon-user "></i>&nbsp; Manage Users
									</a></li>
									<li><a style="color: #428bca" href="logout"> <i
											class="glyphicon glyphicon-log-out"></i>&nbsp; Logout
									</a></li>
								</ul></li>
						</ul>
					</div>
				</nav>
			</div>
		</div>
		<br /> <br />
		<div id="left">
			<div class="media user-media well-small"></div>
			<!-- 	<ul id="menu" class="collapse"> -->

			<div class="navbar-default sidebar" role="navigation">
				<div id="left-collapse" class="sidebar-nav navbar-collapse">

					<ul id="tree3">
						<li><a id="main" href="sql"><i
								class="glyphicon glyphicon-home"></i>&nbsp;&nbsp;<span
								style="font-size: 14px;"> Home</span></a></li>
						<c:forEach var="listValue" items="${databaseDetails}"
							varStatus="status">
							<li id="tableList"><a id="tableid_${listValue.tableName}"
								draggable="true" href="#">${listValue.tableName}<span class="fa arrow"></span></a>
								<ul id="ulTable">
									<c:forEach var="listValue1" items="${listValue.colDetail}"
										varStatus="status1">
										<li draggable="true"><a
											id="${listValue.tableName}_column${status1.count}" href="#"
											 data-toggle="tooltip" title="${listValue1.colDataType}" data-placement="right"  class="red-tooltip">${listValue1.colName}</a></li>
																						
									</c:forEach>
								</ul>
							</li>
						</c:forEach>
					</ul>
					<ul class="nav" id="side-menu">
						<li><a>${tableName}<span class="fa arrow"></span></a>
							<ul>
								<c:forEach var="columnName" items="${columnName}"
									varStatus="stst">
									<li><a id="colid_${columnName}" draggable="true" href="#">${columnName}</a></li>

								</c:forEach>
							</ul></li>
					</ul>
				</div>
			</div>
			<!-- /.navbar-static-side -->

		</div>

		<div id="content" class="visualContent">
			<div class="inner" id="inpart">

				<div class="row">
					<div class="col-sm-12">
						<div class="panel panel-default">
							<div class="panel-heading panel-heading-style" id="panelText">
								Visualization  &nbsp;&nbsp;
							
								<button class="btn btn-default" data-toggle="tooltip" title="clear"  id="saveBtn" ><i class='glyphicon glyphicon-remove-circle'></i>
							    </button>
								<button class="btn btn-default barVBtn"  data-toggle="tooltip" title="Bar Chart" id="executeBar">
									<img src="../assets/img/chart2-128.png" style="width: 20px;"></img>
								</button>
								<button class="btn btn-default" data-toggle="tooltip" title="Pie Chart" id="pieChart">
									<img src="../assets/img/pie.png" style="width: 20px;"></img>
								</button>
								<button class="btn btn-default" data-toggle="tooltip" title="Line Chart" id="lineChart">
									<img src="../assets/img/line.png" style="width: 20px;"></img>
								</button>

							</div>
							<div class="demo-container">
								<br />

								<div id="requiredErrorMsg"
									style="display: none; color: red; padding-left: 2% !important;"
									class="errorTxt">Please enter mandatory fields!</div>
								<br />
								<div class="row">
									<div class="col-sm-8">
										<div class="form-group">
											<label for="X-Coordinate" class="col-sm-4 control-label">Chart
												Label *</label>
											<div class="col-sm-8" style="">
												<input type="text" data-draggable="targetX"
													class="form-control required" id="xCoordinate" value=""
													placeholder="Enter X-Coordinate">

											</div>
										</div>
									</div>
								</div>
								<br />
								<div class="row">
									<div class="col-sm-8">
										<div class="form-group">
											<label for="Y-Coordinate" class="col-sm-4 control-label">Chart
												Value *</label>
											<div class="col-sm-8" style="">
												<input type="text" data-draggable="targetY"
													class="form-control" id="yCoordinate" value=""
													placeholder="Enter Y-Coordinate">

											</div>
										</div>
									</div>
								</div>
								<br />
								<div class="row">
									<div class="col-sm-12">
										<div class="form-group">
											<label for="Label" class="col-sm-2 control-label">Filters</label>
											<div class="col-sm-4" style="">
												<select class="form-control" id="filter" >
													<option>select</option>
												</select>
											</div>
											<div class="col-sm-3" style="">
												<select class="form-control" id="operator">
													<option value="select">select</option>
												  	<option value="equalTo">=</option>
												    <option value="notEqualTo"><></option>
												    <option value="greaterThan">></option>
												    <option value="lessThan"><</option>
												    <option value="greaterThanEq"><></option>
												    <option value="lessThanEq">></option>
												    <option value="between">BETWEEN</option>
												    <option value="like">LIKE</option>
												    <option value="in">IN</option>
												</select>
											</div>
											<div class="col-sm-3" style="">
												<input type="text" data-draggable="targetX"
													class="form-control required" id="distinctValue" value="">

											</div>
											<!-- <div class="col-sm-3" style="">
												<select class="form-control" id="distinctValue" >
												</select>
											</div> -->
										</div>
									</div>
								</div>
								<br />
							</div>
						</div>
						<div class="row" id="barChartDiv" style="display: none;">
							<div class="col-sm-12">
								<div class="panel panel-default">
									<div class="panel-heading">
										<i class="fa fa-bar-chart-o fa-fw"></i><label> Bar Chart</label>
										<button class="btn btn-default" id="barHBtn">
											<i class='glyphicon glyphicon-align-left'></i>
										</button>
										<button class="btn btn-default barVBtn">
											<i class='glyphicon glyphicon-signal'></i>
										</button>
									</div>
									<div class="panel-body">

										<div id="chartContainer" style="height: 300px; width: 100%;"></div>
									</div>
								</div>
							</div>
						</div>

						<div class="row" id="pieChartDiv" style="display: none;">
							<div class="col-sm-12">
								<div class="panel panel-default">
									<div class="panel-heading">
										<i class="fa fa-bar-chart-o fa-fw"></i> <label>Pie Chart</label>
									</div>
									<div class="panel-body">
										<div id="pieContainer" style="height: 300px; width: 100%;"></div>
									</div>
								</div>
							</div>
						</div>

						<div class="row" id="lineChartDiv" style="display: none;">
							<div class="col-sm-12">
								<div class="panel panel-default">
									<div class="panel-heading">
										<i class="fa fa-bar-chart-o fa-fw"></i> <label>Line Chart</label>
									</div>
									<div class="panel-body">

										<div id="lineContainer" style="height: 300px; width: 100%;"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>



	<!-- /#page-wrapper -->
	<div class="modal fade" id="joinModal" role="dialog">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-header">
													<!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
													<h4 class="modal-title"><label> Select Join </label></h4>
				
												</div>
												<div class="modal-body">
													<div class="row">
														<div class="col-sm-2"><label>Table</label></div>
														<div class="col-sm-4">
														  <select class="form-control" id="sel1" onchange="myTable1();">
														  <option>select</option>
														   </select>
														</div>
													 	<div class="col-sm-1 showColumn" style="display:none;">
													 	<!-- Select Column -->
													 	<img src="../assets/img/col.png" style="width:20px;"></img>
													 	</div> 
														<div class="col-sm-4 showColumn" style="display:none;">
														
														<select class="form-control" id="selc1" >
													
														   </select>
														   </div>
													</div>
													<br>
													<div class="row">
														<div class="col-sm-2"><label>Table</label></div>
														<div class="col-sm-4">
														  <select class="form-control" id="sel2" onchange="myTable();">
														   <option>select</option>
														   </select>
														</div>
														<div class="col-sm-1 showColumn2" style="display:none;">
														<!-- Select Column -->
														<img src="../assets/img/col.png" style="width:20px;"></img>
														</div>
														<div class="col-sm-4 showColumn2" style="display:none;">
														<select class="form-control" id="selc2">
														  
														   </select>
														   </div>
													</div>
													<br>
													<div class="row">
														
													<div class="col-sm-2"><label>Select Join</label></div>
													<div class="col-sm-6">
													  <select class="form-control" id="seljoin">
													  	<option value="INNER">Inner Join</option>
													    <option value="FULL">Full Join</option>
													    <option value="RIGHT_OUTER">Right Outer Join</option>
													    <option value="LEFT_OUTER">Left Outer Join</option>
													    
													  </select>
													  </div>
													</div>
													
													
												</div>
												 <div class="modal-footer">
												 <!-- <label class="radio-inline">
													  <input type="radio" name="optradio" class="barVBtn" id="barJoinBtn" data-dismiss="modal"  >Bar Chart
													</label> -->
													 <button class="btn btn-default btn-style" data-dismiss="modal" id="barJoinBtn" >Done</button> 
												</div> 
										
											</div>
										</div>
				</div>
	


	<!--     <script>
	$(document).ready(function () {
    $("input[type='radio']").on("change", function(){        
        chkPanelChanged(this);
    });
});

function chkPanelChanged(obj) {
    if (obj.id == "executeBar") {
        $("#barChartDiv").css("display","block");
		$("#pieChartDiv").css("display","none");
		$("#lineChartDiv").css("display","none");
        
    }
    else if (obj.id == "pieChart")
    {
         $("#barChartDiv").css("display","none");
		 $("#pieChartDiv").css("display","block");
		 $("#lineChartDiv").css("display","none");
    }
	else if(obj.id == "lineChart")
	{
			$("#barChartDiv").css("display","none");
		 $("#pieChartDiv").css("display","none");
		 $("#lineChartDiv").css("display","block");
	}
}
	
	</script> -->
	<!-- /#wrapper -->
	<script src="../assets/js/highcharts.js"></script>
	<script src="../assets/js/exporting.js"></script>
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

$("#sel2").change(function () {
        	  var tValue="",listItems="",selectc="",optChild="",val="",idValue="";
        	  
        		$(".showColumn2").css("display","block");
        		
        	  $('#selc2').find('option').remove();
        	  tValue=document.getElementById("sel2").value;
        	
        	  console.log(tValue);
        		
            	 listItems = document.getElementById('tree3').getElementsByTagName('li');
            	 selectc = document.getElementById('selc2');
            	
            	
			for(var l=0;l<listItems.length;l++)
				{
				idValue=listItems[l].getElementsByTagName("a")[0].id;
				 var n = idValue.indexOf(tValue.trim());
			
				if(n==0)
					{
				 	 val = listItems[l].textContent
				 	 optChild = document.createElement('option');
				 	optChild.value = val;
				 	optChild.innerHTML = val;
	                 selectc.appendChild(optChild);
					}
			
					
				}
            
          });
  
 	</script>
	<script>
  
		function myTable1() {
			var sel1Value = "", listItems = "", selectc1 = "", idValue = "", optChild1 = "", val = "";

			$(".showColumn").css("display", "block");

			$('#selc1').find('option').remove();

			sel1Value = document.getElementById("sel1").value;
			console.log(sel1Value);

			listItems = document.getElementById('tree3').getElementsByTagName(
					'li');

			selectc1 = document.getElementById('selc1');

			for (var l = 0; l < listItems.length; l++) {
				idValue = listItems[l].getElementsByTagName("a")[0].id;

				var m = idValue.indexOf(sel1Value.trim());
				if (m == 0) {
					val = listItems[l].textContent;
					optChild1 = document.createElement('option');
					optChild1.value = val;
					optChild1.innerHTML = val;
					selectc1.appendChild(optChild1);
				}

			}

		}
		
		
		/* $("#filter").change(function () {
			
			console.log("chnage");
			var filterVal=document.getElementById("filter").value;
			
			var sqlString = {
                    "queryString" : filterVal
                  }
			 $.ajax({
                 type : "POST",
                 contentType : "application/json",
                 url : "http://localhost:8080/getDistinctVal",
                 data : JSON.stringify(sqlString),
                 dataType : 'json',
                 timeout : 100000,
                 success : function(data) {
                        
  					var select2=document.getElementById("distinctValue");
                        
                      
                        console.log("SUCCESS: ", data);
	    				 $.each(data, function(index, element) {
                             
	                           $.each(element,function(k,v){
	                                   console.log(k+" : "+ v); 
	                                   var opt= document.createElement('option');
	                                   opt.value = v;
	                                   opt.innerHTML = v;
	                                   select2.appendChild(opt);
	                           });    
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
			
		}) */
	</script>
</body>

</html>