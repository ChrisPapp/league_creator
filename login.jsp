
<!-- @author ΣΙΜΙΤΖΗ ΙΩΑΝΝΑ 8170117 -->

<%@ page import="league.*, java.util.List" %>

<!DOCTYPE html>
<html lang="en">
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" href="images/favicon.ico">

	<title>Log in FootClub</title>

	<!-- Bootstrap core CSS -->
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<!-- Bootstrap Optional theme -->
	<link rel="stylesheet" href="css/bootstrap-theme.min.css">
	<link rel="stylesheet" href="css/default.css">
	<%@ include file="LeagueHeadDefaults.jsp" %>
	<!-- Custom styles for this template -->

	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
		  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->
	</head>

	<body>
		
		<nav>
			<ul class=main-nav>
				<li id="home"><a href="home.jsp" style= "font-family: 'Montserrat', sans-serif;";>Home</a></li>
				<li id="results"><a href="results.jsp" style= "font-family: 'Montserrat', sans-serif;";>Results</a></li>
				<li id="ranking"><a href="ranking.jsp" style= "font-family: 'Montserrat', sans-serif;";>Ranking</a></li>
				<li id="login"><a href="login.jsp" style= "font-family: 'Montserrat', sans-serif;";>Log in</a></li>
				<li id="register"><a href="register.jsp" style= "font-family: 'Montserrat', sans-serif;";>Register</a></li>
				<link href="https://fonts.googleapis.com/css?family=Mansalva&display=swap" rel="stylesheet">
				<link href="https://fonts.googleapis.com/css?family=Lilita+One|Mansalva&display=swap" rel="stylesheet">
				<link href="https://fonts.googleapis.com/css?family=Montserrat&display=swap" rel="stylesheet">
			</ul>
		</nav>

		<div class="container theme-showcase" role="main">

			<!-- Main jumbotron for a primary marketing message or call to action -->
			<div class="header" style= "font-family: 'Lilita One', cursive;";>
				<div align="center">
					<h1 style="color:#00004d"> FootClub</h1>
				</div>
			</div>
			
			<br>
			<br>
			<br>
			
			<div class="container">
				<form class="form-signin" method="post" action="<%=request.getContextPath() %>/loginController.jsp">
					<h2 class="form-signin-heading text-center" style= "font-family: 'Montserrat', sans-serif; color:#00004d";>Log in</h2>
			<br>
			<br>
			<br>
			<br>
			
				<label for="inputusername" class="sr-only" style= "font-family: 'Lilita One', cursive;";>Username</label>
				<input type="text" name="username" id="inputusername" class="form-control" placeholder="username" required>
			<br>
			<br>
				<label for="inputpassword" class="sr-only" style= "font-family: 'Lilita One', cursive;";>Password</label>
				<input name="password" type="password" id="inputpassword" class="form-control" placeholder="password" required>
			<br>
			<br>
				<button class="btn btn-lg btn-primary btn-success" type="submit" style= "font-family: 'Lilita One', cursive;";>Log in</button>
			
				</form>
			</div>
		</div>
</body>
</html>