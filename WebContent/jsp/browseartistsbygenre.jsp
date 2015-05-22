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
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="">
<meta name="author" content="">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
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
<link href="css/tabmenu.css" rel="stylesheet">
<script type="text/javascript">
	$(document).ready(function() {
		//alert(localStorage['visited']);
		if (localStorage['visited']) {
			//alert("in");
			document.getElementById('visited').style.display = 'block';
		} else {
			//alert("2");
			document.getElementById('visited').style.display = 'none';
		}
	});
	function loadSub(text) {
		if (text == "HIP-HOP") {
			text = "HIP HOP";
		} else if (text == "EASY" || text == "LISTENING") {
			text = "EASY LISTENING";
		} else if (text == "NEW" || text == "WAVE") {
			text = "NEW WAVE";
		} else if (text == "CHILL" || text == "OUT") {
			text = "CHILL-OUT";
		} else if (text == "OLD" || text == "TIME") {
			text = "OLD-TIME";
		} else if (text == "AND" || text == "ROLL") {
			text = "ROCK AND ROLL";
		} else if (text == "DRUM" || text == "BASS") {
			text = "DRUM AND BASS";
		}
		$('#subgenre').empty();
		openModal();
		results = "<div class=\"textContainer\" style=\"height: 400px;\"><h5 style=\"text-align : center;\">Sub-Genres : "
				+ text + " </h5><hr/>";
		$.getJSON('loadSubgenres', {
			genre : text
		}, function(jsonResponse) {
			json = $.parseJSON(jsonResponse.subGenresList);
			$(json).each(
					function(i, val) {
						/* d = "<div class='title'><a href='" + val.completeUrl
						+ " \")' target='_blank'>" + val.artistName
						+ "</a></div>"; */
						d = "<div><a href='#' onclick='loadArtist(\""
								+ val.name + "\")'>" + val.name + "</a></div>";
						results += d;
						results += "<hr>";
					});
			results += "</div>";
			$("#subgenre").append(results);
			document.getElementById('subgenre').style.display = "block";
			closeModal();
		});

	}

	function loadArtist(genre) {
		openModal();
		$("#displayTxt").empty();
		$("#displayErr").empty();
		$('#displayTxt').css("display", "none");
		$('#displayErr').css("display", "none");
		results = "<h5 style=\"text-align : center;\">Search results for Sub-Genre : "
				+ genre + " </h5><hr/>";
		c = 0;
		$.getJSON('loadSuggestionsGenre', {
			genre : genre
		}, function(jsonResponse) {
			json = $.parseJSON(jsonResponse.suggestionList);
			$(json).each(
					function(i, val) {
						/* d = "<div class='title'><a href='" + val.completeUrl
						+ " \")' target='_blank'>" + val.artistName
						+ "</a></div>"; */
						d = "<div><a href='loadartistPage.action?artistId="
								+ val.artistId + " '>" + val.artistName
								+ "</a></div>";
						results += d;
						results += "<hr>";
						c++;
					});
			if (c > 0) {
				$("#displayTxt").append(results);
				$('#displayTxt').css("display", "block");
			} else {
				$('#displayErr').css("display", "block");
				$("#displayErr").append(
						"<div class='results'>No records returned</div>");
			}
			closeModal();
		});
	}

	var results;
	function checkKey(e, textarea) {
		var code = (e.keyCode ? e.keyCode : e.which);
		if (code == 13) { //Enter keycode
			e.preventDefault();
			loadResults();
		}
	}
	function openModal() {
		document.getElementById('modal').style.display = 'block';
		document.getElementById('fade').style.display = 'block';
	}

	function closeModal() {
		document.getElementById('modal').style.display = 'none';
		document.getElementById('fade').style.display = 'none';
	}

	function directTo(artistId) {
		alert(artistId);
		/* document.getElementById('selectedId').value = artistId; */
		document.forms['noform'].action = 'loadartistPage?artistId=' + artistId;
		document.forms['noform'].submit();
	}
</script>
</head>

<body>
	<form id="noform"></form>
	<div id="bg">
		<img src="images/back1.jpg" alt="">
	</div>
	<div class="navbar-wrapper ">
		<div class="container">
			<div class="navbar navbar-inverse navbar-fixed-top" id="top-nav">
				<div class="container">
					<div class="navbar-header">
						<!-- Logo Starts -->
						<div class="navbar-brand">
							<a href="loadHome.action">Artist-O-Pedia</a>
						</div>
						<!-- #Logo Ends -->

					</div>


					<!-- Nav Starts -->
					<div class="navbar-collapse  collapse">
						<ul class="nav navbar-nav navbar-right">
							<%
								if (session.getAttribute("artistName") == null) {
							%>
							<li id="visited" style="display: none;"><a
								href="visited.action">Recently Viewed</a>
							</li>
							<li><a href="loadAboutUs.action">About Us</a></li>
							<li><a href="underconstruction.action">Sign Up</a></li>
							<%
								} else {
							%>
							<li><a href="#" style="color: #f2ab00;"><i>Welcome <%
								out.write(session.getAttribute("artistName").toString());
							%> </i> </a></li>
							<li id="visited" style="display: none;"><a
								href="visited.action">Recently Viewed</a>
							</li>
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





	<div class="container overlay">

		<div style="padding: 60px">
			<div id="about" class="spacer">
				<div class="row" align="center" style="height: 40%;">
					<div class="col-lg-12">
						<nav>
							<ul class="fancyNav">
								<li id="name"><a href="loadartistbrowser.action">Name </a>
								</li>
								<li id="location"><a
									href="loadartistbrowserlocation.action">Location</a>
								</li>
								<li id="genre"><a href="loadartistbrowsergenre.action">Genres</a>
								</li>
								<li id="top"><a href="loadartistbrowsertop.action">Top
										20</a></li>
							</ul>
						</nav>
					</div>
				</div>

				<div class="row" align="center">
					<div class="col-lg-8" id='genrecloud'>
						<div class="textContainer" style="height: 400px;">
							<script src="http://cdn.tagul.com/embed/a5uma6xzxidy"></script>
							<!-- Please don't remove attribution to Tagul.com -->
						</div>
					</div>
					<div class="col-lg-4 col-lg-4" style="display: none;" id='subgenre'>
					</div>
				</div>
				<div class="row" align="center">
					<div class="col-lg-12">
						<div class="textContainer" style="height: 320px; display: none"
							id="displayTxt"></div>
						<div class="textContainer" style="height: 50px; display: none"
							id="displayErr"></div>
					</div>
				</div>
				<div class="row" align="center" style="height: 5%">
					<div class="col-lg-12">
						<div class="copyright" style="width: 100%; text-align: center;">Copyright&copy;abhiDBharsh</div>
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