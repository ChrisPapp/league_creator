<!DOCTYPE html>

<!-- @author ΣΙΜΙΤΖΗ ΙΩΑΝΝΑ 8170117 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="LeagueHeadDefaults.jsp" %>
<%@ page import="league.*"%>

<html lang="en">

	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
	
	<link rel="icon" href="images/favicon.ico">

	<title>Sign up FootClub  </title>

	<!-- Bootstrap core CSS -->
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<!-- Bootstrap Optional theme -->
	<link rel="stylesheet" href="css/bootstrap-theme.min.css">
	<link rel="stylesheet" href="css/navbar.css">
	<link rel="stylesheet" href="css/default.css">
	<link rel="stylesheet" type="text/css" href="css/default_styles.css">
	<link rel="stylesheet" type="text/css" href="css/navbar.css">
	<!-- Import the base grid styles -->
	<link rel="stylesheet" type="text/css" href="css/grid.css">
	<!-- Ranking specific styles -->
	<link rel="stylesheet" type="text/css" href="css/ranking.css">
	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
		  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->
	</head>

	<body>
		
		<% request.setCharacterEncoding("UTF-8"); %>
		<!-- Fixed navbar -->
		
		<nav>
			<ul class=main-nav>
				<li><a href="index.jsp" style= "font-family: 'Lilita One', cursive;";>Home</a></li>
				<li><a href="results.jsp" style= "font-family: 'Lilita One', cursive;";>Results</a></li>
				<li><a href="ranking.jsp" style= "font-family: 'Lilita One', cursive;";>Ranking</a></li>
				<li id="signin"><a href="login.html" style= "font-family: 'Lilita One', cursive;";>Log in</a></li>
				<li id="register"><a href="register.html" style= "font-family: 'Lilita One', cursive;";>Register</a></li>
			</ul>
		</nav>

		<div class="container theme-showcase" role="main">

			<div class="header" style= "font-family: 'Lilita One', cursive;";>
				<div align="center">
					<h1>FootClub</h1>
				</div>
			</div>

		
		<!-- /container -->

<%
 String leaguechoice = request.getParameter("leaguename");

 if (session.getAttribute("user1") == null) {
	 
%>

	<jsp:forward page ="login.jsp"></jsp:forward>
	
 <% } else {
	 
	 UserDAO userDAO = new UserDAO();
	 LeagueDAO leagueDAO = new LeagueDAO();
	 User user = (User) session.getAttribute("user1");
	 League idleague = leagueDAO.getLeagueByName(leaguechoice);
	 userDAO.insertleague(user, idleague);
 }
%>
		 
	 
<div class="page-header" style= "font-family: 'Lilita One', cursive;";>
 <h1> <p> Registration done! </h1>
 </div>


</body>
</html>












 