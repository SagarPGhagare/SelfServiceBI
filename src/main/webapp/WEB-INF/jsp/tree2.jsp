<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style>
    .tree, .tree ul {
    margin:0;
    padding:0;
    list-style:none
}
.tree ul {
    margin-left:1em;
    position:relative
}
.tree ul ul {
    margin-left:.5em
}
.tree ul:before {
    content:"";
    display:block;
    width:0;
    position:absolute;
    top:0;
    bottom:0;
    left:0;
    border-left:1px solid
}
.tree li {
    margin:0;
    padding:0 1em;
    line-height:2em;
    color:#369;
    font-weight:700;
    position:relative
}
.tree ul li:before {
    content:"";
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

		$('#tree1').treed();

		$('#tree2').treed({openedClass:'glyphicon-folder-open', closedClass:'glyphicon-folder-close'});

		$('#tree3').treed({openedClass:'glyphicon-chevron-right', closedClass:'glyphicon-chevron-down'});
		
		/* function drag(ev) {
			alert("alert1");
           ev.dataTransfer.setData("text", ev.target.id);
           
          }
		function drop(ev) {
			alert("drop event");
		    ev.preventDefault();
		    var data = ev.dataTransfer.getData("text");
		    ev.target.appendChild(document.getElementById(data));
		} */
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
	        	/* e.dataTransfer.dropEffect = "copy";
	        	e.target.appendChild(item);                
	            e.preventDefault(); */
	        	  e.preventDefault();
	        	  var data=e.dataTransfer.getData("text");
	  			
	        	  var nodeCopy = document.getElementById(data);
	        	   //alert("in data drag"+nodeCopy.innerText);
	        	  //nodeCopy.id = "newId"; /* We cannot use the same ID */	        	  		           
	        	  //e.target.appendText(nodeCopy.innerText + ', ');
	        	  var addtext = nodeCopy.innerText + ', '
	        	  $("#text-box").val($("#text-box").val() + addtext);
	        }
	    
	    }, false);
	    
	    //dragend event to clean-up after drop or abort
	    //which fires whether or not the drop target was valid
	    document.addEventListener('dragend', function(e)
	    {
	        item = null;
	    
	    }, false);
	    
	    $('#runQuery').on('click', function(event) {
	    	  event.preventDefault(); // To prevent following the link (optional)
	    	  alert("button clicked")
	    	  
	    		var search = {
                        "queryString" : "select from table",
                      }

	    		$.ajax({
	    			type : "POST",
	    			contentType : "application/json",
	    			url : "http://localhost:8080/bi/getString",
	    			data : JSON.stringify(search),
	    			dataType : 'json',
	    			timeout : 100000,
	    			success : function(data) {
	    				console.log("SUCCESS: ", data);
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
	  
  });

  </script>
</head>
<body>


<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#">Logo</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a href="#">Home</a></li>
        <li><a href="#">About</a></li>
        <li><a href="#">Sql</a></li>
        <li><a href="#">Bar Charts</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
      </ul>
    </div>
  </div>
</nav>
  
<div class="container-fluid text-center">    
  <div class="row content">   
    
    <div class="col-md-2 text-left">
           
           <ul id="tree3">
               <!--  <li><a id="tableid1" draggable="true"  href="#">TECH</a>
                    <ul>
                        <li draggable="true" id="one">Company</li>
                        <li draggable="true" id="two">Employees</li>
                        <li draggable="true" id="three">Human</li>
                    </ul>
                </li> -->
                
                

                <c:forEach var="listValue" items="${listA}" varStatus="status">
                   <li><a id="tableid_${listValue.name}" draggable="true"  href="#">${listValue.name}</a>
                      <ul>
                   <c:forEach var="listValue1" items="${listValue.columns}" varStatus="status1">
            	       <li draggable="true"><a id="${listValue.name}_column${status1.count}"  href="#">${listValue1.name}</a></li>
            	    </c:forEach>
            	    </ul>
                  </li>
            	</c:forEach>
            	
                
            </ul>
           
           
        </div>
    
    <div class="col-md-10 text-left"> 
      <!-- <h1>Welcome</h1>
      <p>BI lending page</p>
      <hr>
      <h3>Test</h3>
      <p>Lorem ipsum...</p> -->
      <!-- <ol data-draggable="target">
         <li data-draggable="item">Item 5</li>
      </ol> -->
      <textarea id="text-box" data-draggable="target" rows="10" cols="50"> 
     </textarea>
     <div>
     <button id="runQuery" type="button" class="btn btn-primary">run query</button></div>
    </div>
    <!-- <div class="col-md-2 sidenav">
      <div>
        <textarea class="well" placeholder="drag here" rows="4" cols="50">
            
         </textarea>
      </div>
      <div class="well">
        <p>ADS</p>
      </div>
    </div> -->
  </div>
</div>

<!-- <footer class="container-fluid text-center">
  <p>Footer Text</p>
</footer> -->

</body>
</html>
