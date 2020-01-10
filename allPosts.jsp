<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="league.*" %>
<%@ page import="database.*" %>
<%@ page import="java.util.ArrayList" %>

<%-- begin html --%>
<!DOCTYPE html>
<html lang="en">
  	<head>
    	<%@ include file="LeagueHeadDefaults.jsp" %>
      <link rel="stylesheet" type="text/css" href="css/allPost.css">
  	</head>
  	<body>
  		<%@ include file="navbar.jsp" %>
        <ul class="postList">
        <%  ArrayList<Post> postList = currentLeague.getPosts();
            for (Post post : postList) { %>
                <li><a href="post.jsp?post=<%= "" + post.getId() %>"><%= post.getTitle() %></a></li>
            <%}
        %>
        </ul>
        <h3><%= postList.size()%></h3>
  </body>
</html>