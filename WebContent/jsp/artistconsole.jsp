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
<script
	src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="dynatable/jquery.dynatable.js"></script>
<!-- Bootstrap Core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="dynatable/jquery.dynatable.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="css/artistopedia.css" rel="stylesheet">
<!-- <link href="css/formstyle.css" rel="stylesheet"> -->
<link href="css/leftmenu.css" rel="stylesheet">

<script>

$(document).ready(function(){
  $('li').click(function(){
	  $(this).addClass('current')
	       .siblings()
	       .removeClass('current');
	    
	});
});
	
function openModal() {
	document.getElementById('modal').style.display = 'block';
	document.getElementById('fade').style.display = 'block';
}

function closeModal() {
	document.getElementById('modal').style.display = 'none';
	document.getElementById('fade').style.display = 'none';
}

	var artist = '<%=session.getAttribute("artistName")%>';
	var artistId = '<%=session.getAttribute("artistId")%>';
	var albumStatDisp = "<table id=\"albumStatTable\" style=\"display: none; padding-top: 30px; padding-bottom: 20px;\">";
	albumStatDisp += "<thead><th data-dynatable-column=\"albumName\">Name</th><th data-dynatable-column=\"albumCountry\">Country</th>";
	albumStatDisp += "<th data-dynatable-column=\"albumLanguage\">Language</th><th data-dynatable-column=\"albumBarCode\">Bar Code</th>";
	albumStatDisp += "</thead><tbody></tbody></table>";

	var songStatDisp = "<table id=\"songStatTable\" style=\"display: none; padding-top: 30px; padding-bottom: 20px;\"><thead>";
	songStatDisp += "<th data-dynatable-column=\"songName\">Name</th><th data-dynatable-column=\"youtubeName\">Youtube Name</th>";
	songStatDisp += "<th data-dynatable-column=\"url\">Song Url</th><th data-dynatable-column=\"duration\">Duration</th>";
	songStatDisp += "<th data-dynatable-column=\"releaseDate\">Release Date</th><th data-dynatable-column=\"songCountry\">Song Country</th>";
	songStatDisp += "<th data-dynatable-column=\"songLanguage\">Language</th><th data-dynatable-column=\"rating\">Rating</th>";
	songStatDisp += "<th data-dynatable-column=\"viewCount\">View Count</th><th data-dynatable-column=\"crawlDate\">Crawl Date</th>";
	songStatDisp += "<th data-dynatable-column=\"viewCountRate\">View Count Rate</th><th data-dynatable-column=\"crawlDelta\">Crawl Delta</th>";
	songStatDisp += "</thead><tbody></tbody></table>";

	function loadAlbumStats() {
		var json;
		openModal();
		$('#displayTab').hide();
		$('#displayTab').empty();
		$('#displayTab').append(albumStatDisp);
		$.getJSON('loadAlbumInfo', {
			searchArtist : artistId
		}, function(jsonResponse) {
			json = $.parseJSON(jsonResponse.albumInfoList);
			$('#albumStatTable').dynatable({
				dataset : {
					records : json
				}
			});
			$('#displayTab').show();
			//document.getElementById('songStatTable').style.display = 'none';
			document.getElementById('albumStatTable').style.display = 'block';
			//document.getElementById('userMsg').style.display = 'none';
			closeModal();
		});
	}

	function loadSongStats() {
		var json;
		openModal();
		$('#displayTab').hide();
		$('#displayTab').empty();
		$('#displayTab').append(songStatDisp);
		$.getJSON('loadSongInfo', {
			searchArtist : artistId
		}, function(jsonResponse) {
			json = $.parseJSON(jsonResponse.songInfoList);
			$('#songStatTable').dynatable({
				dataset : {
					records : json
				}
			});
			$('#displayTab').show();
			document.getElementById('songStatTable').style.display = 'block';
			//document.getElementById('albumStatTable').style.display = 'none';
			//document.getElementById('userMsg').style.display = 'none';
			closeModal();
		});
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
							<%
								if (session.getAttribute("artistName") == null) {
							%>
							<li><a href="loadAboutUs.action">About Us</a></li>
							<li><a href="underconstruction.action">Sign Up</a></li>
							<%
								} else {
							%>
							<li><a href="#" style="color: #f2ab00;"><i>Welcome <%
								out.write(session.getAttribute("artistName").toString());
							%> </i> </a></li>
							<li><a href="loadAboutUs.action">About Us</a></li>
							<li><a href="logout.action">Sign out </a></li>
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
						<%-- <ul class="menu">
							<li><a href="#" onclick="loadAlbumStats();" class="active"><span>Artist Bio</span></a>
							</li>
							<li><a href="#" onclick="loadAlbumStats();"><span>Album Stats</span></a>
							</li>
							<li><a href="#" onclick="loadSongStats();"><span>Song Stats</span></a>
							</li>
						</ul> --%>
						<div id="menu8">
							<ul>
								<li class="current"><a href="#" onclick="loadAlbumStats();">Artist Bio</a>
								</li>
								<li><a href="#" onclick="loadAlbumStats();">Album Stats</a>
								</li>
								<li><a href="#" onclick="loadSongStats();">Song Stats</a>
								</li>
								<!-- <li><a href="#4">Crawl History</a></li> -->
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-2 col-lg-10">
				<div style="padding: 100px 0 10px 0">
					<div class="tableContainer" id="displayTab">
						<div id="userMsg">
							<h5>Please select an option from menu to view the stats</h5>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="content">
		<div id="fade"></div>
		<div id="modal">
			<img id="loader" src="images/map_spinner.gif" />
		</div>
	</div>
</body>
</html>