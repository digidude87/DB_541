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
<link rel="icon" type="image/gif" href="images/music.png">
<!--[if lte IE 8]><script src="/css/ie/html5shiv.js"></script><![endif]-->
<script
	src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<!-- Bootstrap Core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="css/artistopedia.css" rel="stylesheet">
<link href="css/formstyle.css" rel="stylesheet">

<script>
	var audio = new Audio();
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

	function loadartistbrowser() {
		document.forms['noform'].action = 'loadartistbrowser';
		document.forms['noform'].submit();
	}
</script>
</head>

<body>
	<form id="noform"></form>
	<div id="bg">
		<img src="images/back4.jpg" alt="">
	</div>
	<div class="navbar-wrapper ">
		<div class="container">

			<div class="navbar navbar-inverse navbar-fixed-top" id="top-nav">
				<div class="container">
					<div class="navbar-header">
						<!-- Logo Starts -->
						<a class="navbar-brand" href="#" onclick="loadartistbrowser()">Browse
							Artists </a>
						<!-- #Logo Ends -->


					</div>


					<!-- Nav Starts -->
					<div class="navbar-collapse  collapse">
						<ul class="nav navbar-nav navbar-right">
							<%
								if (session.getAttribute("artistName") == null) {
							%>
							<li><a href="loadAboutUs.action">About Us</a>
							</li>
							<li><a href="underconstruction.action">Sign Up</a>
							</li>
							<%
								} else {
							%>
							<li><a href="#" style="color: #f2ab00;"><i>Welcome <%
								out.write(session.getAttribute("artistName").toString());
							%> </i> </a>
							</li>
							<li><a href="loadAboutUs.action">About Us</a>
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
			<div class="col-sm-7">
				<div style="padding: 100px 0 20px 0">
					<div class="fronttext">
						<h2 class="bgcolor">
							<span class="glyphicon glyphicon-headphones"></span>
							artist-O-pedia
						</h2>
						<br>
						<p>
							A website dedicated to all musicians. Create you profile, get
							your work across to the mass and reach out to the hardcore music
							fans. <br> <br>Come join the community...
						</p>
					</div>
					<br>
					<div class="fronttext">
						<p>
							
							<a href="http://the.echonest.com" target="_blank"><img src="images/echonest.gif" width="150px;" height="50px;" /></a>
							<a href="https://www.spotify.com" target="_blank"><img
								src="images/spotify-connect.png" width="150px;" height="50px;" /></a>
							<a href="https://www.youtube.com" target="_blank"><img src="images/youtube-logo.jpg" width="100px;" height="50px;" /></a>
							<a href="https://tagul.com/" target="_blank"><img src="images/Tagul.png" width="100px;" height="50px;" /></a>
							<a href="http://www.dynatable.com/" target="_blank"><img src="images/dynatable_logo.jpg" width="100px;" height="50px;" /></a>
						</p>
					</div>
				</div>
			</div>
			<%
				if (session.getAttribute("artistName") == null) {
			%>
			<div class="col-sm-5 col-sm-7">
				<div id="home" class="homeinfo">
					<form action="login" method="post">
						<h1>Artist Login</h1>
						<s:if test="hasActionErrors()">
							<div class="errors">
								<s:actionerror />
							</div>
						</s:if>
						<div class="inset">
							<p>
								<label for="userid">USER ID</label> <input type="text"
									name="uid" id="uid">
							</p>
							<p>
								<label for="password">PASSWORD</label> <input type="password"
									name="password" id="password">
							</p>
						</div>
						<p class="p-container">
							<span><a href="underconstruction.action">Forgot
									password ?</a> </span> <input type="submit" value="Log in">
						</p>
					</form>
				</div>
			</div>
			<%
				} else {
			%>
			<div class="col-sm-5 col-sm-7">

				<div id="home" class="homeinfo">
					<form>
						<img src="images/console5.png" height="250px;" width="500px;" />
						<h1>
							<a href="loadConsole.action">View Artist Console</a>
						</h1>
					</form>
				</div>
			</div>
			<%
				}
			%>
		</div>
		<div class="row" align="center" style="height: 5%">
			<div class="col-lg-12">
				<div class="copyright" style="width: 100%; text-align: center;">Copyright&copy;abhiDBharsh</div>
			</div>
		</div>
	</div>
</body>
</html>