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
<script type="text/javascript"
	src="https://github.com/douglascrockford/JSON-js/blob/master/json2.js"></script>

<script>
	var artistName = "";
	var albumArr = new Array();
	var urlArr = new Array();

	function addUrl(youtubeUrl, spotifyUrl, songName) {
		url = new Object();
		url.artist = artistName;
		url.songName = songName;
		if (youtubeUrl != "") {
			for ( var i in urlArr) {
				y = urlArr[i];
				if (y.youtubeUrl == youtubeUrl)
					return;
			}
			url.youtubeUrl = youtubeUrl;
			url.spotifyUrl = "";
		}
		if (spotifyUrl != "") {
			for ( var i in urlArr) {
				y = urlArr[i];
				if (y.spotifyUrl == spotifyUrl)
					return;
			}
			url.spotifyUrl = spotifyUrl;
			url.youtubeUrl = "";
		}

		urlArr.push(url);
		urls = JSON.stringify(urlArr);
		localStorage['visited'] = urls;
	}

	function showVid(url, type, songName) {
		$(".fancybox").fancybox({
			type : 'iframe',
			autoSize : true,
			openEffect : 'none',
			closeEffect : 'none',
			closeBtn : 'true',
			href : url,
			helpers : {
				overlay : {
					closeClick : false
				},
				media : {}
			}
		});
		if (type == "you")
			addUrl(url, "", songName);
		else if (type == "spot")
			addUrl("", url, songName);
	}

	$(document)
			.ready(
					function() {
						if (localStorage['visited']) {
							//alert("in");
							parsed = JSON.parse(localStorage['visited']);
							for ( var x in parsed) {
								urlArr.push(parsed[x]);
							}
						}
						//alert(JSON.stringify(urlArr));
						//alert(localStorage['visited']);
						if (localStorage['visited']) {
							//alert("in");
							document.getElementById('visited').style.display = 'block';
						} else {
							//alert("2");
							document.getElementById('visited').style.display = 'none';
						}

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
											n = "<span class='glyphicon glyphicon-user'></span> ";
											$(json).each(function(i, val) {
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
											co = 0;
											$(json)
													.each(
															function(i, val) {
																//alert("here");
																albumArr
																		.push(val.albumName);
																albumName = (val.albumName)
																		.split(
																				"\'")
																		.join(
																				"");
																albumName = albumName
																		.split(
																				"\"")
																		.join(
																				"");
																/* albumName = (val.albumName)
																		.replace(
																				"\"",
																				""); */
																//alert(albumName);
																/* alert("Name : "+val.albumName+"   Country :  "+val.albumCountry+"   Artist : "+artistName); */
																d = "<div>";
																d += "<a href='#' onclick='show(\""
																		+ albumName
																		+ val.albumCountry
																		+ "\")'><img src='images/icon_filterexpand.gif'/></a>   ";
																d += "<a href='#' onclick='loadSongs(\""
																		+ artistName
																		+ "\",\""
																		+ co
																		+ "\")'>"
																		+ val.albumName
																		+ "</a>";
																d += "<br><div id='"+albumName+val.albumCountry+"' style='display:none'>";
																d += "<div class='sub_res'>Country : "
																		+ val.albumCountry
																		+ "<br>"
																		+ "Language : "
																		+ val.albumLanguage
																		+ "</div></div>";
																d += "</div>";
																results += d;
																results += "<hr>";
																co++;
															});
											/* alert(results); */
											$("#displayAlbums").append(results);
											loadImageAndData(artistName);
											results="";
											json = $
													.parseJSON(jsonResponse.topSongList);
											$(json)
													.each(
															function(i, val) {
																results += "<div>"
																		+ val.songName
																		+ "       ";
																results += "<div style='float:right; display: inline;'/><a class='fancybox fancybox.iframe' href='#' onclick='showVid(\""
																		+ val.url
																		+ "\",\"you\",\""
																		+ val.songName
																		+ "\");'><img src='images/youtube.png'/></a>&nbsp;";
																crawlSpotify(val.songName
																		+ " "
																		+ artistName);
																if (loadFlag != 2) {
																	while (loadFlag != 1)
																		;
																}
																if (spotifyUri != null
																		&& spotifyUri != "") {
																	var url = "https://embed.spotify.com/?uri="
																			+ spotifyUri;
																	results += "<div style='float:right; display: inline;'/><a class='fancybox fancybox.iframe' href='#' onclick='showVid(\""
																			+ url
																			+ "\",\"spot\",\""
																			+ val.songName
																			+ "\");' ><img src='images/spotify.png' height='32px' width='32px'/></a>&nbsp;";
																}
																results += "</div><hr>";
															});
											results += "</div>";
											$("#displayTop").append(results);
											if (loadFlag != 0) {
												closeModal();
												loadFlag = 0;
												spotifyUri = "";
												loadSuggestedArtists();
											}

										});

						document.getElementById('close').onclick = function() {
							this.parentNode.parentNode.parentNode
									.removeChild(this.parentNode.parentNode);
						};
					});

	function loadSuggestedArtists() {
		c = 0;
		results = "<h5 style='text-align:center;'> ARTIST ROULETTE : Click on one of the images to explore a similar artist RANDOMLY !!</h5><hr>";
		$
				.getJSON(
						'loadSuggestedArtist',
						{},
						function(jsonResponse) {
							json = $.parseJSON(jsonResponse.suggestedArtists);
							$(json)
									.each(
											function(i, val) {
												if (c > 14)
													return false;

												d = "<a href='loadartistPage.action?artistId="
														+ val.artistId
														+ " '><img style=\"margin: 0px 5px 15px 19px;\" src=\"images/blank-prof.png\" width='50' height='50'>"
														+ "</a>";
												results += d;
												c++;

											});
							$("#displaySuggestions").append(results);
							$("#suggestionRow").show();
						});

	}

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

	function loadSongs(artistName, counter) {
		albumName = albumArr[counter];
		//alert(artistName+"  "+albumName);
		var json;
		$("#displaySongs").empty();

		openModal();
		$
				.getJSON(
						'loadSongs',
						{
							albumName : albumName
						},
						function(jsonResponse) {
							results = "";
							uurl="";
							json = $.parseJSON(jsonResponse.songList);
							if (Object.keys(json).length > 0) {
								$(json)
										.each(
												function(i, val) {
													uurl = val.url;
													results += "<div>"
															+ val.songName
															+ "       ";
													results += "<div style='float:right; display: inline;'/><a class='fancybox fancybox.iframe' href='#' onclick='showVid(\""
															+ uurl
															+ "\",\"you\",\""
															+ val.songName
															+ "\");'><img src='images/youtube.png'/></a>&nbsp;";
													crawlSpotify(val.songName
															+ " " + artistName);
													if (loadFlag != 2) {
														while (loadFlag != 1)
															;
													}
													if (spotifyUri != null
															&& spotifyUri != "") {
														var url = "https://embed.spotify.com/?uri="
																+ spotifyUri;
														results += "<div style='float:right; display: inline;'/><a class='fancybox fancybox.iframe' href='#' onclick='showVid(\""
																+ url
																+ "\",\"spot\",\""
																+ val.songName
																+ "\");' ><img src='images/spotify.png' height='32px' width='32px'/></a>&nbsp;";
													}
													results += "</div><hr>";
												});
								results += "</div>";
								$("#displaySongs").append(results);
								if (loadFlag != 0) {
									closeModal();
									loadFlag = 0;
									spotifyUri = "";
								}
							} else {
								$("#displaySongs")
										.append(
												"<div>Songs not available in database</div><hr>");
								closeModal();
							}
						});
	}

	function goback() {
		document.forms['noAction'].action = 'loadartistbrowser';
		document.forms['noAction'].submit();
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


	<!-- overlay -->

	<div class="container overlay">

		<div style="padding: 20px 0 20px 0">
			<div id="about" class="spacer">
				<div class="row">
					<div class="col-lg-12">
						<input type="button" value="Back to Browse Artists"
							onclick="goback()">
					</div>
				</div>
				<br>
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
							<h3 id="artistName"></h3>
							<blockquote>
								<div id="details"></div>
							</blockquote>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row" align="center">
			<div class="col-lg-12">
				<div class="headerContainer"
					style="height: 50px; text-align: center">
					<h5>Most Viewed Songs</h5>
				</div>
			</div>
		</div>
		<div class="row" align="center">
			<div class="col-lg-12">
					<div class="dataContainer" style="height: 320px;" id="displayTop"></div>
			</div>
		</div>
		
		<div class="row" align="center">
			<div class="col-lg-12">
				<div class="dataContainer"
					style="height: 70px; text-align: center">
					<h3>Discography : Click on album to listen to it's songs</h3>
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
		<div class="row" align="center" id="suggestionRow"
			style="display: none;">
			<div class="col-lg-12">
				<div class="imgContainer" style="height: 140px;"
					id="displaySuggestions"></div>
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