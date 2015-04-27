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
<script
	src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<!-- Bootstrap Core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<script>
	$(document).bind("mobileinit", function() {
		$.mobile.ignoreContentEnabled = true;
	});
	$(document)
			.ready(
					function() {
						$("#displayAlbums").empty();
						var json;
						openModal();
						$
								.getJSON(
										'loadArtistDetails',
										{},
										function(jsonResponse) {
											json = $
													.parseJSON(jsonResponse.artistDetails);
											$(json)
													.each(
															function(i, val) {
																n = "<div>"
																		+ val.artistName
																		+ "</div>";
																d = "<div>"
																		+ val.artistDescription
																		+ "</div>";
																artistName = val.artistName;
															});
											$("#artistName").append(n);
											$("#details").append(d);

											json = $
													.parseJSON(jsonResponse.albumList);
											results = "";
											d = "";
											$(json)
													.each(
															function(i, val) {
																d = "<div>";
																d += "<a href='#' onclick='show(\""
																		+ val.albumId
																		+ "\")'><img src='images/icon_filterexpand.gif'/></a>   ";
																d += "<a href='#' onclick='loadSongs(\""
																		+ val.albumId
																		+ "\",\""
																		+ artistName
																		+ "\")'>"
																		+ val.albumName
																		+ "</a>";
																d += "<br><div id='"+val.albumId+"' style='display:none'>";
																d += "<div class='sub_res'>Country : "
																		+ val.albumCountry
																		+ "<br>"
																		+ "Language : "
																		+ val.albumLanguage
																		+ "</div></div>";
																d += "</div>";
																results += d;
																results += "<hr>";
															});
											$("#displayAlbums").append(results);
											closeModal();
										});

						document.getElementById('close').onclick = function() {
							this.parentNode.parentNode.parentNode
									.removeChild(this.parentNode.parentNode);
						};
					});
</script>

<!-- Custom CSS -->
<link href="css/artistopedia.css" rel="stylesheet">
<link href="css/formstyle.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jquerymobile/1.4.5/jquery.mobile.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquerymobile/1.4.5/jquery.mobile.min.js"></script>

<script>
	var loadFlag = 0;
	var spotifyUri = "";
	/* $(document).ready(function(){
		$("#displayAlbums").append("<div  style='text-align: center;'><h5>Album Browser<hr/></h5></div>");
		$("#displaySongs").append("<div  style='text-align: center;'><h5>Song Browser<hr/></h5></div>");
	}); */
	function openModal() {
		document.getElementById('modal').style.display = 'block';
		document.getElementById('fade').style.display = 'block';
	}

	function closeModal() {
		document.getElementById('modal').style.display = 'none';
		document.getElementById('fade').style.display = 'none';
	}

	var artistName;

	function show(elementId) {
		if (document.getElementById(elementId).style.display == 'none')
			document.getElementById(elementId).style.display = 'block';
		else {
			document.getElementById(elementId).style.display = 'none';
		}
	}

	function crawlSpotify(query) {
		//alert("CrawlSpotify Query : " + query);
		$.ajax({
			async : false,
			url : 'https://api.spotify.com/v1/search',
			data : {
				q : query,
				type : 'track'
			}
		}).done(function(response) {
			var track = response.tracks.items[0];
			/*audio.src = track.preview_url;
			audio.play(); */
			if (track == undefined) {
				loadFlag = 2;
			} else {
				spotifyUri = track.uri;
				loadFlag = 1;
			}
		});
	}

	function prepareSpotify(response) {
		alert("in");
		var track = response.tracks.items[0];
		/*alert(track);
		 audio.src = track.preview_url;
		audio.play(); */
		if (track != null) {
			retUrl = track.uri;
			loadFlag = 1;
		}
		if (loadFlag == 0) {
			loadFlag = 1;
			return "";
		}
		return retUrl;
		/* document.getElementById("spot").src = "https://embed.spotify.com/?uri="
				+ track.uri; */
	}

	function loadSongs(albId, artistName) {
		var json;
		$("#displaySongs").empty();
		openModal();
		$
				.getJSON(
						'loadSongs',
						{
							albumId : albId
						},
						function(jsonResponse) {
							results = "";
							json = $.parseJSON(jsonResponse.songList);
							$(json)
									.each(
											function(i, val) {
												results += "<div>"
														+ val.songName
														+ "</div>";
												results += "<div style='float:right; display: inline;'/><a href='#' onclick='showplayer(\""
														+ val.url
														+ "\")'><img src='images/youtube.png'/></a>&nbsp;";
												crawlSpotify(val.songName + " "
														+ artistName);
												if (loadFlag != 2) {
													while (loadFlag != 1)
														;
												}
												if (spotifyUri != null
														&& spotifyUri != "") {
													results += "<div style='float:right; display: inline;'/><a href='#' onclick='showspotifyplayer(\""
															+ spotifyUri
															+ "\")'><img src='images/spotify.png' height='32px' width='32px'/></a>&nbsp;";
												}
												results += "</div><hr>";
											});
							$("#displaySongs").append(results);
							if (loadFlag != 0) {
								closeModal();
								loadFlag = 0;
							}
						});
	}

	function showspotifyplayer(spotifyUri) {
		var url = "https://embed.spotify.com/?uri=" + spotifyUri;
		var popup = '<div id="fade"></div><div data-role="popup" id="popupVideo" data-overlay-theme="b" data-theme="a"><a href="#" data-rel="back" class="ui-btn-right ui-btn ui-btn-b ui-corner-all ui-btn-icon-notext ui-icon-delete ui-shadow">Close</a><iframe src="'+url+'" width="560" height="315" frameborder="0" allowfullscreen seamless></iframe></div>';
		/* document.getElementById('fade').style.display = 'block';
		document.getElementById('spplayer').style.display = 'block';
		document.getElementById("spot").src = url; */
		document.getElementById('fade').style.display = 'block';
		$.mobile.loading("show", {
			text : "Loading Spotify...",
			textVisible : true,
			theme : "b",
			overlayTheme : "b"
		});
		$("body").append(popup);
		$("#popupVideo").popup();
		$("#popupVideo iframe").on("load", function() {
			$("#popupVideo").popup({
				afterclose : function() {
					document.getElementById('fade').style.display = 'none';
					$(this).remove();
				},
				dismissible : false,
				history : false,
				positionTo : "window",
				transition : "pop"
			}).popup("open");
			$.mobile.loading("hide");
		});
	}

	function hideSpot(spotifyUri) {
		document.getElementById('spot').src = '';
		document.getElementById('fade').style.display = 'none';
		document.getElementById('spplayer').style.display = 'none';

		//location.reload();
	}

	function showplayer(youtubeUrl) {
		/* document.getElementById('player').style.display = 'block';
		document.getElementById('youtubeplayer').data = youtubeUrl
				+ '&autoplay=1'; */

		var popup = '<div id="fade"></div><div data-role="popup" id="popupVideo" data-overlay-theme="b" data-theme="a"><a href="#" data-rel="back" class="ui-btn-right ui-btn ui-btn-b ui-corner-all ui-btn-icon-notext ui-icon-delete ui-shadow">Close</a><iframe src="'+youtubeUrl+'" width="560" height="315" frameborder="0" allowfullscreen seamless></iframe></div>';
		document.getElementById('fade').style.display = 'block';
		$.mobile.loading("show", {
			text : "Loading video...",
			textVisible : true,
			theme : "b",
			overlayTheme : "b"
		});
		$("body").append(popup);
		$("#popupVideo").popup();
		$("#popupVideo iframe").on("load", function() {
			$("#popupVideo").popup({
				afterclose : function() {
					document.getElementById('fade').style.display = 'none';
					$(this).remove();
				},
				dismissible : false,
				history : false,
				positionTo : "window",
				transition : "pop"
			}).popup("open");
			$.mobile.loading("hide");
		});
	}

	function hidePlayer(youtubeUrl) {
		document.getElementById('youtubeplayer').data = '';
		alert("clearing");
		//document.getElementById('fade').style.display = 'none';
		//document.getElementById('player').style.display = 'none';
		//location.reload();
	}

	/* window.onload = function() {
		document.getElementById('close').onclick = function() {
			this.parentNode.parentNode.parentNode
					.removeChild(this.parentNode.parentNode);
			return false;
		};
	}; */
</script>
</head>

<body>
	<form name="noAction"></form>
	<div id="bg">
		<img src="images/back2.jpg" alt="">
	</div>
	<div class="navbar-wrapper" data-role="none">
		<div class="container">

			<div class="navbar navbar-inverse navbar-fixed-top">
				<div class="container">
					<div class="navbar-header">
						<!-- Logo Starts -->
						<div class="navbar-brand">Artist-O-Pedia</div>
						<!-- #Logo Ends -->

					</div>


					<!-- Nav Starts -->
					<div class="navbar-collapse  collapse">
						<ul class="nav navbar-nav navbar-right">
							<li class="active"><a href="#home">Home</a></li>
							<li><a href="#about">About</a></li>
							<li><a href="#playlist">Contact Us</a></li>
							<li><a href="#">Sign Up</a>
							</li>
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

		<div style="padding: 20px 0 20px 0">
			<div id="about" class="spacer">
				<div class="row">
					<div class="col-lg-4 col-sm-4  col-xs-12">
						<div class="imgContainer"
							style="height: 320px; text-align: center;" id="displayImgBox">
							<img src="" class="fillwidth" style="height: 280px;"
								id="displayImg" alt="Image Not Available" />
						</div>
					</div>
					<div class="col-lg-8 col-sm-8  col-xs-12">
						<h3 id="artistName">
							<span class='glyphicon glyphicon-user'></span>
						</h3>
						<blockquote>
							<div id="details"></div>
						</blockquote>
					</div>
				</div>
			</div>
		</div>
		<div class="row" align="center">
			<div class="col-lg-4 col-sm-4  col-xs-12">
				<div class="headerContainer"
					style="height: 50px; text-align: center">
					<h5>Album Browser</h5>
				</div>
			</div>
			<div class="col-lg-8 col-sm-8  col-xs-12">
				<div class="headerContainer"
					style="height: 50px; text-align: center">
					<h5>Song Browser</h5>
				</div>
			</div>
		</div>
		<div class="row" align="center">
			<div class="col-lg-4 col-sm-4  col-xs-12">
				<div class="dataContainer" style="height: 520px;" id="displayAlbums"></div>
			</div>
			<div class="col-lg-8 col-sm-8  col-xs-12">
				<div class="dataContainer" style="height: 520px;" id="displaySongs"></div>
			</div>
		</div>
		<div class="row" align="center" style="height: 5%">
			<div class="col-lg-12">
				<div class="copyright" style="width: 100%; text-align: center;">Copyright&copy;abhiDBharsh</div>
			</div>
		</div>
	</div>
	<div id="content">
		<div id="fade"></div>
		<div id="modal">
			<img id="loader" src="images/map_spinner.gif" />
		</div>
		<div class="player" id="player">
			<span id='close'><a href="#" onclick='hidePlayer();'>X</a> </span>
			<object id="youtubeplayer" width=600px height=400px></object>
		</div>
		<div class="player" id="spplayer">
			<span id='close'><a href="#" onclick='hideSpot();'>X</a> </span>
			<iframe id="spot" width="300" height="380" frameborder="0"
				allowtransparency="true"></iframe>
		</div>
	</div>
</body>
</html>