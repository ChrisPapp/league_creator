
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


	
	<% 	final int POST_LIMIT = 2;
		List<Post> postList = currentLeague.getPosts(-1, -1);
	%>
<body>

	<%@ include file="navbar.jsp" %>
	<%  boolean shouldAnimate = session.getAttribute("lastPage") != "home.jsp";
        String bgClasses, contentClasses;
        if (shouldAnimate) {
          bgClasses = "bg-image blur";
        } else {
          bgClasses = "bg-image";
        }
    %>

    <div class="<%=bgClasses%>"></div>
    <div class="content">
		<div class="header" style= "font-family: 'Lilita One', cursive;";>
			<div align="center">
				<font color="white"><h1> Welcome to <%= currentLeague.getName() %></h1></font>
			</div>
		</div>
		
		<div id="homeContainer">
			<div class="defBubble" id="leaguePosts">
				<img src="images/postIcon.jpg" alt="Recent posts">
				<% 
					if (postList.size() > 0) { %>
						<h2>Posts in <span class="bubbleName"><%= currentLeague.getName() %></span></h2>
						<div class="list">
							<% 
								for (int i = 0; i < postList.size(); i++) { 
									Post post = postList.get(i);
							%>
								<% if (i < POST_LIMIT) { %> <div class="listItem"> <% } else { %> <div class="listItem togglePost" style="display: none;"> <% } %>
									<a href="post.jsp?post=<%=post.getId()%>" class="link"><%=post.getTitle()%></a>
									<p class="listParag" style="text-align: right;"> <%=post.getDateString()%> </p>
								</div>
							<%	}%>
							<p class="total">Total posts: <span class="count"><%=postList.size()%></span></p>
							<% if (postList.size() > POST_LIMIT) { %>
								<button class="defButton toggleBtn" id="togglePost">More</button>
							<% } %>
						</div>
					<% } else {%>
						<h2>No posts have been made in <span class="bubbleName"><%=currentLeague.getName()%></span></h2>
					<% } %>
			</div>
			
			<div class="img-rounded" style="float: right; background-color: #ffff80; width: 375px; height: 150px; border: 0px solid black; margin: 10px;">
				<h2 style="color: #2d2d86; text-align: center; margin: 10px; padding: 10px; font-family: 'Lilita One', cursive;";>
					
				</h2>
				<div id="cc-homepage-announcements" style="height: 200px; overflow-x: hidden; overflow-y: auto; padding: 6px; text-align: left;">&nbsp;</div>
			</div>
		</div>

	</div>
	<script src="js/moreLessBtn.js"></script>
	<% if (shouldAnimate) { %>
      <script src="js/jquery.min.js"></script>
      <script>
          $(document).ready(function(e){
              $(".bg-image").toggleClass("blur");
            });
      </script>
    <% } %>
</body>
</html>
<% session.setAttribute("lastPage", "home.jsp"); %>
