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
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">


<!--[if lte IE 8]><script src="/css/ie/html5shiv.js"></script><![endif]-->
<script
	src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

<script src="js/bootstrap.min.js"></script>
<!-- Bootstrap Core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/tabmenu.css" rel="stylesheet">
<!-- Custom CSS -->
<link href="css/artistopedia.css" rel="stylesheet">
<link href="css/formstyle.css" rel="stylesheet">

<script>
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
	function loadResults() {
		openModal();
		$("#displayTxt").empty();
		$("#displayErr").empty();
		$('#displayTxt').css("display", "none");
		$('#displayErr').css("display", "none");
		var json;
		var c = 0;
		results = "<br>";
		var searchField = $("#loadArtists").val();
		$.getJSON('loadSuggestions', {
			searchText : searchField
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
				$('#displayTxt').css("display", "block");
				$("#displayTxt").append("<h5> Search Results for \'"+searchField+"\'</h5><hr>");
				$("#displayTxt").append(results);
			} else {
				$('#displayErr').css("display", "block");
				$("#displayErr").append(
						"<div class='results'>No records returned</div>");
			}
			closeModal();
		});
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
						<div class="navbar-brand"><a href="loadHome.action">Artist-O-Pedia</a></div>
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





	<div class="container overlay">

		<div style="padding: 60px">
			<div id="about" class="spacer">
				<div class="row" align="center" style="height: 40%;">
					<div class="col-lg-12">
						<nav>
							<ul class="fancyNav">
								<li id="name"><a href="loadartistbrowser.action">Name</a>
								</li>
								<li id="location"><a href="loadartistbrowserlocation.action">Location</a>
								</li>
								<li id="genre"><a href="loadartistbrowsergenre.action">Genres</a>
								</li> 
							</ul>
						</nav>
					</div>
				</div>
				<div class="row" align="center">
					<div class="col-lg-8">
						<form action="#">
							<input type="hidden" name="artistId" id="selectedId">
							<div class="input-group">
								<input type="text" class="form-control"
									placeholder=" Type an artist name to search	 ...."
									name="searchText" id="loadArtists"
									onkeydown="checkKey(event, this)"> <span
									class="input-group-btn">
									<button type="button" class="btn btn-search"
										onclick="loadResults();" id="searchButton">Search</button> </span>
							</div>
						</form>
					</div>
				</div>

				<div class="row" align="center">
					<div class="col-lg-12">
						<div class="textContainer" style="height: 260px; display: none"
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