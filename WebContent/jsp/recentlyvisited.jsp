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
<link rel="icon" type="image/gif" href="images/music.png">


<!--[if lte IE 8]><script src="/css/ie/html5shiv.js"></script><![endif]-->
<script
	src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

<script src="js/bootstrap.min.js"></script>

<link rel="stylesheet"
	href="fancybox/source/jquery.fancybox.css?v=2.1.5" type="text/css"
	media="screen" />
<script type="text/javascript"
	src="fancybox/source/jquery.fancybox.pack.js?v=2.1.5"></script>


<link rel="stylesheet"
	href="fancybox/source/helpers/jquery.fancybox-buttons.css?v=1.0.5"
	type="text/css" media="screen" />
<script type="text/javascript"
	src="fancybox/source/helpers/jquery.fancybox-buttons.js?v=1.0.5"></script>
<script type="text/javascript"
	src="fancybox/source/helpers/jquery.fancybox-media.js?v=1.0.6"></script>

<link rel="stylesheet"
	href="fancybox/source/helpers/jquery.fancybox-thumbs.css?v=1.0.7"
	type="text/css" media="screen" />
<script type="text/javascript"
	src="fancybox/source/helpers/jquery.fancybox-thumbs.js?v=1.0.7"></script>
	
<!-- Bootstrap Core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/tabmenu.css" rel="stylesheet">
<!-- Custom CSS -->
<link href="css/artistopedia.css" rel="stylesheet">
<link href="css/formstyle.css" rel="stylesheet">

<script>
	$(document).ready(function() {
		//localStorage['visited']="";
		loadUrls();
		if (localStorage['visited']) {
			//alert("in");
			document.getElementById('visited').style.display = 'block';
		} else {
			//alert("2");
			document.getElementById('visited').style.display = 'none';
		}
		$(".fancybox").fancybox({
			type : 'iframe',
			autoSize : true,
			openEffect : 'none',
			closeEffect : 'none',
			closeBtn : 'true',
			helpers : {
				overlay : {
					closeClick : false
				},
				media : {}
			}
		});
	});
	var results;
	function openModal() {
		document.getElementById('modal').style.display = 'block';
		document.getElementById('fade').style.display = 'block';
	}
	var urlArr = new Array();
	function loadUrls() {
		openModal();
		$("#displayTxt").empty();
		$('#displayTxt').append("<h3 style=\"text-align: center;\">Youtube Videos</h3><hr>");
		$("#displayErr").empty();
		$('#displayTxt').css("display", "none");
		$('#displayErr').css("display", "none");
		$("#displayTxt2").empty();
		$('#displayTxt2').append("<h3 style=\"text-align: center;\">Songs on Spotify</h3><hr>");
		$("#displayErr2").empty();
		$('#displayTxt2').css("display", "none");
		$('#displayErr2').css("display", "none");
		//alert(localStorage['visited']);
		parsed = JSON.parse(localStorage['visited']);
		for ( var x in parsed) {
			urlArr.push(parsed[x]);
		}
		c = 0;
		d = "";
		for ( var i in urlArr) {
			//alert(urlArr[y]);
			y = urlArr[i];
			if (y.spotifyUrl == "") {
				imgUrl = (y.youtubeUrl).replace("www", "img");
				imgUrl = (imgUrl).replace("/v/", "/vi/");
				//alert(y.youtubeUrl+"+"+c);
				d += "<div>" + y.artist + " : " + y.songName + "</div>";
				d += "<a class='fancybox fancybox.iframe' href='"+y.youtubeUrl+"'>";
				d += "<img src=\""+imgUrl+"/default.jpg\"/></a>";
				d += "<hr>";
				c++;
			}
		}
		if(c>0){
			$('#displayTxt').append(d);
			$('#displayTxt').show();
		}
		else {
			$("#displayErr").append(
			"<div class='results'>No videos viewed on Youtube</div>");
			$('#displayErr').show();
		}
		c = 0;
		d="";
		for ( var i in urlArr) {
			//alert(urlArr[y]);
			y = urlArr[i];
			if (y.youtubeUrl == "") {
				d += "<div>" + y.artist + " : " + y.songName + "</div>";
				d += "<a class='fancybox fancybox.iframe' href='"+y.spotifyUrl+"'>";
				d += "<img src='images/spotify.png' height='32px' width='32px'/></a>";
				d += "<hr>";
				c++;
			}
		}
		if(c>0){
			$('#displayTxt2').append(d);
			$('#displayTxt2').show();
		}
		else {
			$("#displayErr2").append(
			"<div class='results'>No songs listened on Spotify</div>");
			$('#displayErr2').show();
		}
		closeModal();
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
							<li id="visited" style="display: none;"><a href="visited.action">Recently Viewed</a></li>
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
							<li id="visited" style="display: none;"><a href="visited.action">Recently Viewed</a></li>
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
				<div class="row" align="center">
					<div class="col-lg-12">
						<div class="textContainer">
							<h2 style="text-align: center;">RECENTLY VIEWED</h2>
						</div>
					</div>
				</div>
				<div class="row" align="center" style="height: 40%;">
					<div class="col-lg-6">
						<div class="textContainer" style="display: none" id="displayTxt">
						</div>
						<div class="textContainer" style="height: 50px; display: none"
							id="displayErr"></div>
					</div>
					<div class="col-lg-6">
						<div class="textContainer" style="display: none" id="displayTxt2">
							<h3 style="text-align: center;">Spotify Urls</h3>
							<hr>
						</div>
						<div class="textContainer" style="height: 50px; display: none"
							id="displayErr2"></div>
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