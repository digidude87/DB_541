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

<script>
	var artistName = "";
	$(document)
			.ready(
					function() {
						$(".fancybox").attr('rel', 'gallery').fancybox({
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
						$('.fancybox-media').fancybox({
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
											n="<span class='glyphicon glyphicon-user'></span> ";
											$(json)
													.each(
															function(i, val) {
																n += val.artistName;
																/* d = "<div>"
																		+ val.artistDescription
																		+ "</div>"; */
																artistName = val.artistName;
															});
											$("#artistName").append(n);
											/* $("#details").append(d); */

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
											loadImageAndData(artistName);
											closeModal();
										});

						document.getElementById('close').onclick = function() {
							this.parentNode.parentNode.parentNode
									.removeChild(this.parentNode.parentNode);
						};
					});

	function loadImageAndData(artistName) {
		echonestUrl = "http://developer.echonest.com/api/v4/artist/images?api_key=VWDRVXLERPAMVTNEF";
		$
				.getJSON(
						echonestUrl,
						{
							'name' : artistName,
							'results' : 1,
							'start' : 0
						},
						function(jsonResponse) {
							var img = jsonResponse.response.images[0];
							if (img != undefined) {
								imgUrl = img.url;
								document.getElementById("displayImg").src = imgUrl;
							} else {
								document.getElementById("displayImg").src = "images/blank-prof.png";
							}
						});
		echonestUrl = "http://developer.echonest.com/api/v4/artist/biographies?api_key=VWDRVXLERPAMVTNEF";
		$
				.getJSON(
						echonestUrl,
						{
							'name' : artistName,
							'start' : 0
						},
						function(jsonResponse) {
							artistbio = "";
							artistbiourl = "";
							for ( var i = 0; i < jsonResponse.response.biographies.length; i++) {
								var desc = jsonResponse.response.biographies[i];
								if (desc != undefined
										&& (desc.url.indexOf("aol") > -1 || desc.url
												.indexOf("mtv") > -1))
									continue;
								if (desc != undefined) {
									artistbio = desc.text;
									artistbiourl = desc.url;
									break;
								}
							}
							if (artistbiourl == "") {
								d = "<div>Bio not available</div>";
							} else {
								d = "<div>"
										+ artistbio
										+ " ...."
										+ "<a href='"+artistbiourl+"' target='_blank'><i>more</i></a></div>";
							}
							$("#details").append(d);

						});
	}
</script>

<!-- Custom CSS -->
<link href="css/artistopedia.css" rel="stylesheet">
<link href="css/formstyle.css" rel="stylesheet">

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
												results += "<div style='float:right; display: inline;'/><a class='fancybox fancybox.iframe' href='"
														+ val.url
														+ "' onclick='showfade();'><img src='images/youtube.png'/></a>&nbsp;";
												crawlSpotify(val.songName + " "
														+ artistName);
												if (loadFlag != 2) {
													while (loadFlag != 1)
														;
												}
												if (spotifyUri != null
														&& spotifyUri != "") {
													var url = "https://embed.spotify.com/?uri="
															+ spotifyUri;
													results += "<div style='float:right; display: inline;'/><a class='fancybox fancybox.iframe' href='"
															+ url
															+ "' ><img src='images/spotify.png' height='32px' width='32px'/></a>&nbsp;";
												}
												results += "</div><hr>";
											});
							$("#displaySongs").append(results);
							if (loadFlag != 0) {
								closeModal();
								loadFlag = 0;
								spotifyUri = "";
							}
						});
	}
</script>
</head>

<body>
	<form name="noAction"></form>
	<div id="bg">
		<img src="images/back3.jpg" alt="">
	</div>
	<div class="navbar-wrapper" data-role="none">
		<div class="container">

			<div class="navbar navbar-inverse navbar-fixed-top">
				<div class="container">
					<div class="navbar-brand">
						<a href="loadHome.action">Artist-O-Pedia</a>
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

		<div style="padding: 20px 0 20px 0">
			<div id="about" class="spacer">
				<div class="row">
					<div class="col-lg-4 col-sm-4  col-xs-12">
						<div class="imgContainer"
							style="height: 320px; text-align: center;" id="displayImgBox">
							<img src="" class="fillwidth"
								style="height: 300px; max-height: 100%; max-width: 100%;"
								id="displayImg" alt="Image Not Available" />
						</div>
					</div>
					<div class="col-lg-8 col-sm-8  col-xs-12">
						<div class="dataContainer" style="height: 320px;">
							<h3 id="artistName">
							</h3>
							<blockquote>
								<div id="details"></div>
							</blockquote>
						</div>
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
	</div>
</body>
</html>