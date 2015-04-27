<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML>
<html>
<head>
<title>Artist-o-pedia</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta name="description" content="" />
<meta name="keywords" content="" />
<!--[if lte IE 8]><script src="/css/ie/html5shiv.js"></script><![endif]-->
<%-- <script src="js/jquery.min.js"></script> --%>
<%-- <script
	src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script> --%>
<script src="js/bootstrap.min.js"></script>
<!-- Bootstrap Core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="css/artistopedia.css" rel="stylesheet">
<link href="css/formstyle.css" rel="stylesheet">
<link href="css/leftmenu.css" rel="stylesheet">

<script>
	function loadResults() {
		var json;

		$.getJSON('getVal', {
			searchText : searchField
		}, function(jsonResponse) {
			json = $.parseJSON(jsonResponse.fbString);
			$(json).each(
					function(i, val) {
						d = "<div class='title'><a href='" + val.completeUrl
								+ "' onmouseover='setSrc(\" " + val.imgUrl
								+ " \")' target='_blank'>" + val.title
								+ "</a></div>";
						d += "<div>" + val.content + "</div>";
						fb_results += d;
						fb_results += "<br/>";
						count++;
					});
		});
	}
	var artist = '<%= session.getAttribute("artistName") %>';
	function loadAlbumStats(){
		var json;
		alert(artist);
        alert(username );
	/* 	$.getJSON('getVal', {
			searchText : searchField
		} */
	}
</script>
</head>

<body>
	<div id="bg">
		<img src="images/back2.jpg" alt="">
	</div>
	<div class="navbar-wrapper ">
		<div class="container">

			<div
				class="navbar navbar-inverse navbar-fixed-top animated fadeInDown"
				role="navigation" id="top-nav">
				<div class="container">
					<div class="navbar-header">
						<!-- Logo Starts -->
						<div class="navbar-brand">
							<a href="loadHome.action">Artist-O-Pedia</a>
						</div>
						<!-- #Logo Ends -->


						<button type="button" class="navbar-toggle collapsed"
							data-toggle="collapse" data-target=".navbar-collapse">
							<span class="sr-only">Toggle navigation</span> <span
								class="icon-bar"></span> <span class="icon-bar"></span> <span
								class="icon-bar"></span>
						</button>

					</div>


					<!-- Nav Starts -->
					<div class="navbar-collapse  collapse">
						<ul class="nav navbar-nav navbar-right">
							<li class="active"><a href="#home">Home</a></li>
							<li><a href="#about">About</a></li>
							<li><a href="#playlist">Contact Us</a></li>
							<%
								if (session.getAttribute("artistName") == null) {
							%>
							<li><a href="underconstruction.action">Sign Up</a>
							</li>
							<%
								} else {
							%>
							<li><a href="#" style="color: #f2ab00;"><i>Welcome <%
								out.write(session.getAttribute("artistName").toString());
							%> </i> </a>
							</li>
							<li><a href="logout.action">Sign out </a>
							</li>
							<%
								}
							%>
						</ul>
					</div>
					<!-- #Nav Ends -->

				</div>
			</div>

		</div>
	</div>
	<!-- #Header Starts -->







	<!-- overlay -->
	<div class="container overlay">


		<!-- home banner starts -->

		<div class="row">
			<div class="col-sm-2">
				<div style="padding: 100px 0 10px 0">
					<div class="dataContainer">
						<!-- <h5 style="text-align: center;">Menu</h5>
						<hr/> -->
						<div id="menu8">
							<ul>
								<li><a href="#" onclick="loadAlbumStats()">Album Stats</a></li>
								<li><a href="#3">Song Stats</a></li>
								<li><a href="#4">Crawl History</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-4 col-lg-10">
				<div style="padding: 100px 0 10px 0">
					<div class="dataContainer" style="height: 450px;"></div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>