<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="league.*, java.util.List" %>


<!-- @author ΣΙΜΙΤΖΗ ΙΩΑΝΝΑ 8170117 -->

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		<meta name="description" content="Login FootClub">
		<meta name="author" content="">
		<link rel="icon" href="<%=request.getContextPath() %>/images/favicon.ico">

		<title>Login FootClub</title>

		<!-- Bootstrap core CSS -->
		<link rel="stylesheet" href="<%=request.getContextPath() %>/css/bootstrap.min.css">

		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
			  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
			  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->
  </head>
  <body>
	
	<%
	String username = request.getParameter("username");
	
    String password = request.getParameter("password");
	
	UserDAO userDAO = new UserDAO();
	
	
	try{
	
	userDAO.authenticate( username, password);
	User user = userDAO.authenticate( username, password);
	session.setAttribute("user1",user);%>	
	<jsp:forward page="profile.jsp"/>
	
	<% } catch (Exception e){
	  request.setAttribute("message", e.getMessage());
	  %>
	  <jsp:forward page="login.jsp"/>
	 
	 <% } %>
	 

	<!-- Bootstrap core JavaScript
	================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="<%=request.getContextPath() %>/js/jquery.min.js"></script>
	<script	src="<%=request.getContextPath() %>/js/bootstrap.min.js"></script>

  </body>
</html>