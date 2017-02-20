<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Self Service BI</title>
<link href="jquery.treemenu.css" rel="stylesheet" type="text/css">
<style>
.tree { background-color:#2C3E50; color:#46CFB0;}
.tree li,
.tree li > a,
.tree li > span {
    padding: 4pt;
    border-radius: 4px;
}

.tree li a {
   color:#46CFB0;
    text-decoration: none;
    line-height: 20pt;
    border-radius: 4px;
}

.tree li a:hover {
    background-color: #34BC9D;
    color: #fff;
}

.active {
    background-color: #34495E;
    color: white;
}

.active a {
    color: #fff;
}

.tree li a.active:hover {
    background-color: #34BC9D;
}
</style>
<link href="http://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">
</head>

<body>
<div id="jquery-script-menu">
<div class="jquery-script-center">
<div class="jquery-script-ads"><script type="text/javascript"><!--
google_ad_client = "ca-pub-2783044520727903";
/* jQuery_demo */
google_ad_slot = "2780937993";
google_ad_width = 728;
google_ad_height = 90;
//-->
</script>
<script type="text/javascript"
src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script></div>
<div class="jquery-script-clear"></div>
</div>
</div>
<h1 style="margin:150px auto 30px auto;">Self Service BI</h1>

<%-- <c:if test="${not empty lists}">

		<ul class="tree">
		 <li><a href="">Tables|Views</a></li>
		 <ul>
			<c:forEach var="listValue" items="${lists}">
				<li><a href="#">${listValue}</a>
			        <ul>
			        	<c:forEach var="value" items="${listValue.colDetail}">
			        		<li><a class="active" href="#">${value.colName}</a></li>
			        	</c:forEach>
			        </ul>
			      </li>
		 </ul>
			</c:forEach>
		</ul>

	</c:if> --%>
	
<ul class="tree">
  <li><a href="">Tables|Views</a></li>
  <li><span>Category</span>
    <ul>
      <li><a href="#">jQuery</a>
        <ul>
          <li><a href="#">jQuery</a></li>
          <li><a href="#">jQuery UI</a></li>
          <li><a href="#">jQuery Mobile</a></li>
        </ul>
      </li>
      <li><a href="#">JavaScript</a>
        <ul>
          <li><a class="active" href="#">AngularJS</a></li>
          <li><a href="#">React</a></li>
          <li><a href="#">Backbone</a></li>
        </ul>
      </li>
      <li><a href="#suits">Golang</a></li>
    </ul>
  </li>
  <li><a href="#about">About</a>
    <ul>
      <li><a href="#">Contact</a></li>
      <li><a href="#">Blog</a></li>
      <li><a href="#">Jobs</a>
        <ul>
          <li><a href="#jobs1">Job 1</a></li>
          <li><a href="#jobs2">Job 2</a></li>
          <li><a href="#jobs3">Job 3</a></li>
        </ul>
      </li>
    </ul>
  </li>
</ul>

<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="jquery.treemenu.js"></script>
<script>
$(function(){
        $(".tree").treemenu({delay:300}).openActive();
    });
</script>
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-36251023-1']);
  _gaq.push(['_setDomainName', 'jqueryscript.net']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>

</body>
</html>
