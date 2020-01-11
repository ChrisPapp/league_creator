<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="league.*" %>

<%-- begin html --%>
<!DOCTYPE html>
<html lang="en">
  	<head>
    	<%@ include file="LeagueHeadDefaults.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/post.css">
  	</head>
  	<body>
  		<%@ include file="navbar.jsp" %>
        <%  Integer postId = null;
          String postIdParam = request.getParameter("post");
          Post currentPost = null;
          if (postIdParam != null) {
            try {
              postId = Integer.parseInt(postIdParam);
              currentPost = Post.getById(postId, currentLeague.getId());
            } catch (Exception e) {
              // What could possibly go wrong?
            }
          }
          if (postId == null || currentPost == null) { // If everything fails, go to home page.
        %>
            <jsp:forward page="home.jsp"/> 
        <% } %>

        <article>
            <h1 id="postTitle"><%= currentPost.getTitle() %></h1>
            <div id="postInfo">
                <a href="profile.jsp?user=<%=currentPost.getPoster().getId()%>" id="poster">Author: <%=currentPost.getPoster().getName() + " " + currentPost.getPoster().getSurname() %></a>
                <div id="date"><%=currentPost.getDateString()%></div>
            </div>
            <div id="postContent">
                <p><%= currentPost.getContent() %></p>
            </div>
        </article>
  </body>
</html>>