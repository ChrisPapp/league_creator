
<!-- @author ΠΑΠΠΑΣ ΧΡΗΣΤΟΣ 8170105 ΚΑΙ ΣΙΜΙΤΖΗ ΙΩΑΝΝΑ 8170117 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="league.*" %>
<%@ page import="database.DatabaseAccess" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="LeagueHeadDefaults.jsp" %>
	<link rel="stylesheet" type="text/css" href="css/home.css">
	<link href="https://fonts.googleapis.com/css?family=Lilita+One|Mansalva&display=swap" rel="stylesheet">
</head>
<body>

	<%@ include file="navbar.jsp" %>

	<% 	final int POST_LIMIT = 3;
		List<Post> postList = currentLeague.getPosts(POST_LIMIT);
	%>
	
	<div class="header" style= "font-family: 'Lilita One', cursive;";>
		<div align="center">
			<font color="white"><h1> Welcome to <%= currentLeague.getName() %></h1></font>
		</div>
	</div>
	
	<div class="img-rounded" style="float: left; background-color: #ffff80; width: 315px; height: auto; border: 0px solid black; margin: 10px;">
		<h2 style="color: #2d2d86; text-align: center; margin: 10px; padding: 10px; font-family: 'Lilita One', cursive;";>
			Our announcements
		</h2>
		<div id="cc-homepage-announcements" style="height: 200px; overflow-x: hidden; overflow-y: auto; padding: 6px; text-align: left;">
			<% 
			 for (int i = 0; i < postList.size(); i++) { %>
                <li><a href="post.jsp?post=<%= "" + postList.get(i).getId() %>" class="homeTitle"><%= postList.get(i).getTitle() %></a></li>
            <%} %>
			<% if (postList.size() >= POST_LIMIT) { %><li id="push"><a href="allPosts.jsp">More Posts</a></li> <% } %>
		</div>
	</div>
	
	<div class="img-rounded" style="float: right; background-color: #ffff80; width: 315px; height: 220px; border: 0px solid black; margin: 10px;">
		<h2 style="color: #2d2d86; text-align: center; margin: 10px; padding: 10px; font-family: 'Lilita One', cursive;";>
			
		</h2>
		<div id="cc-homepage-announcements" style="height: 200px; overflow-x: hidden; overflow-y: auto; padding: 6px; text-align: left;">&nbsp;</div>
	</div>
		
</body>
</html>
