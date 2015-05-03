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
<%-- <script src="js/jquery.min.js"></script> --%>
<%-- <script
	src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script> --%>
<script src="js/bootstrap.min.js"></script>
<!-- Bootstrap Core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="css/artistopedia.css" rel="stylesheet">
<link href="css/formstyle.css" rel="stylesheet">

<script>
	
</script>
</head>

<body>
	<div id="bg">
		<img src="images/underconst_2.jpg" alt="">
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
			<div class="col-lg-12"></div>
		</div>
		<div class="row" align="center" style="height: 5%">
			<div class="col-lg-12">
				<div class="copyright" style="width: 100%; text-align: center;">Copyright&copy;abhiDBharsh</div>
			</div>
		</div>
	</div>
</body>
</html>