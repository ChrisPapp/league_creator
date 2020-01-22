
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
		request.setAttribute("message", "You have to log in, in order to post!");
		%>  
		<jsp:forward page= "login.jsp" />
	<% } else {
		
		User user = (User) session.getAttribute("user");
		
	}%>
	
	<body>
		
		<%@ include file="navbar.jsp" %>

		<% request.setCharacterEncoding("UTF-8"); %>
		<% if (currentUser != null && currentUser.canPost()) { %>

		<div class="container theme-showcase" role="main">

			<!-- Main jumbotron for a primary marketing message or call to action -->
			<div class="header" style= "font-family: 'Lilita One', cursive;";>
				<div align="center">
					<h1 style="color:#00004d">FootClub</h1>
				</div>
			</div>


			<form class="form-horizontal" id="form1" name="form1" method="post" action="createpostController.jsp">
				<div class="form-group" style= "font-family: 'Montserrat', sans-serif;">
					<label for="imputtitle1">Post title</label>
						<input type="title" class="form-control" id="inputtitle1" placeholder="your title" name="Title">
				</div>
			
				<div class="form-group" style= "font-family: 'Montserrat', sans-serif;">
					<label for="inputcontent1">Post content</label>
					<textarea class="form-control" id="inputcontent1" rows="3" name="Content"></textarea>
				</div>
				
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<button type="submit" class="defButton">Post!</button>
					</div>
				</div>
			</form>
		<div>
		
			
			
			
			
		<script src="js/jquery.min.js"></script>
		<!-- Bootstrap core JavaScript -->
		<script	src="js/bootstrap.min.js"></script>

		<% } else { %>
			<h1> You are not allowed to post </h1>
		<% } %>
</body>
</html>