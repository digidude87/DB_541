<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SpotifyTest</title>
<script
	src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script>
	function crawl(query) {
		$
				.ajax({
					url : 'https://api.spotify.com/v1/search',
					data : {
						q : query,
						type : 'track'
					},
					success : function(response) {
						alert("in");
						var track = response.tracks.items[0];
						//alert(track.uri);
						/* audio.src = track.preview_url;
						audio.play(); */
						alert("https://embed.spotify.com/?uri=" + track.uri);
						document.getElementById("spot").src = "https://embed.spotify.com/?uri="
								+ track.uri;
					}
				});
	}
</script>
</head>
<body>
	<form action="#">
	<input type="button" onclick="crawl('Ya No Vuelvas Conmigo')" value="Crawl">
	</form>
	<iframe id="spot" width="300" height="380" frameborder="0"
		allowtransparency="true"></iframe>
</body>
</html>