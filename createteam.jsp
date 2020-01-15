
<!-- @author ΣΙΜΙΤΖΗ ΙΩΑΝΝΑ 8170117 -->
<%@ page import="league.*, java.util.List" %>


<!DOCTYPE html>
<html lang="en">
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<!-- Bootstrap core CSS -->
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<!-- Bootstrap Optional theme -->
	<link rel="stylesheet" href="css/bootstrap-theme.min.css">
	<link rel="stylesheet" href="css/default.css">
    <%@ include file="LeagueHeadDefaults.jsp" %>

	</head>

	<%
		if (session.getAttribute("user") == null) {
			request.setAttribute("message", "You have to log in, in order to use this site!");
		%>  
		<jsp:forward page= "login.jsp" />
	<% } else {
		
		 User user = (User) session.getAttribute("user");
		
	}%>
	

	
	<body>
		
		<%@ include file="navbar.jsp" %>

		<div class="container theme-showcase" role="main">

			<!-- Main jumbotron for a primary marketing message or call to action -->
			<div class="header" style= "font-family: 'Lilita One', cursive;";>
				<div align="center">
					<h1 style="color:#00004d">FootClub</h1>
				</div>
			</div>

			<!-- Page Title -->
			<div class="page-header" style= "font-family: 'Montserrat', sans-serif;";>
				<h1 style="color:#00004d"> <p> Create your team</h1>
			</div>

			
			<form class="form-horizontal" id="form1" name="form1" method="post" action="createteamController.jsp">

				<div class="form-group">
					<label for="TeamName" class="col-sm-2 control-label" style= "font-family: 'Montserrat', sans-serif;"> <h4 style="color:#00004d"> Name of Team</h4> </label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="TeamName" name= "TeamName" placeholder="TeamName">
						</div>
				</div>
				
				<div class="form-group">
					<label for="TeamLogo" class="col-sm-2 control-label" style= "font-family: 'Montserrat', sans-serif;"> <h4 style="color:#00004d"> Logo of League</h4> </label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="TeamLogo" name= "TeamLogo" placeholder="TeamLogo">
						</div>
				</div>
				

				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<button type="submit" class="defButton">Create</button>
					</div>
				</div>
			</form>
		</div>
		<!-- /container -->

		<script src="js/jquery.min.js"></script>
		<!-- Bootstrap core JavaScript -->
		<script	src="js/bootstrap.min.js"></script>
</body>
</html>
