<!DOCTYPE html>

<!-- @author ΣΙΜΙΤΖΗ ΙΩΑΝΝΑ 8170117 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="league.*"%>

<html lang="en">

	<head>
		<%@ include file="LeagueHeadDefaults.jsp" %>

	</head>
	
	
	<body>
		
		<% request.setCharacterEncoding("UTF-8"); %>
		<%
		if (currentUser != null && currentUser.canPost()) {
			String title = request.getParameter("Title"); 
			String content = request.getParameter("Content"); 

			
			Post post = new Post( -1 , title, content, currentUser, null);
				
			post.register();
			response.sendRedirect("post.jsp?post=" + post.getId());
			%>
			
			
		<% } else { %>
			<h1> You are not allowed to post </h1>
		<% } %>

 </body>
 </html>