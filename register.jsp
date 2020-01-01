
<!-- @author ΣΙΜΙΤΖΗ ΙΩΑΝΝΑ 8170117 -->
<%@ page import="league.*, java.util.List" %>

<!DOCTYPE html>
<html lang="en">
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>Sign up FootClub</title>

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
	<!-- Custom styles for this template -->

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
					<h1 style="color:#00004d">FootClub</h1>
				</div>
			</div>

			<!-- Page Title -->
			<div class="page-header" style= "font-family: 'Montserrat', sans-serif;";>
				<h1 style="color:#00004d"> <p> Registration Form</h1>
			</div>

		</div>
		<!-- /container -->


<div class="alert alert-success" role="success" style= "font-family: 'Montserrat', sans-serif;"; <b> <center> <h4 style="color:#00004d"> Fill in the following form to create an account. </h4> </b> </center> </div>


<form class="form-horizontal" id="form1" name="form1" method="post" action="registerController.jsp">

   <div class="form-group">
      <label for="inputName3" class="col-sm-2 control-label" style= "font-family: 'Montserrat', sans-serif;"> <h4 style="color:#00004d"> Name </h4> </label>
      <div class="col-sm-10">
        <input type="text" class="form-control" id="inputName3" name= "Name" placeholder="Name">
      </div>
  </div>

  <div class="form-group">
      <label for="inputSurname3" class="col-sm-2 control-label" style= "font-family: 'Montserrat', sans-serif;"> <h4 style="color:#00004d">Surname </h4> </label>
      <div class="col-sm-10">
        <input type="text" class="form-control" id="inputSurname3" name= "Surname" placeholder="Surname">
      </div>
  </div>


  <div class="form-group">
    <label for="inputEmail3" class="col-sm-2 control-label" style= "font-family: 'Montserrat', sans-serif;"> <h4 style="color:#00004d"> Email </h4> </label>
    <div class="col-sm-10">
      <input type="email" class="form-control" id="inputEmail3" name= "Email" placeholder="Email">
    </div>
  </div>

  <div class="form-group">
        <label for="inputUsername3" class="col-sm-2 control-label" style= "font-family: 'Montserrat', sans-serif;"> <h4 style="color:#00004d"> Username </h4> </label>
        <div class="col-sm-10">
          <input type="text" class="form-control" id="inputUsername3" name= "Username" placeholder="Username">
        </div>
    </div>


  <div class="form-group">
      <label for="exampleInputPassword1" class="col-sm-2 control-label" style= "font-family: 'Montserrat', sans-serif;"> <h4 style="color:#00004d"> Password </h4> </label>
      <div class="col-sm-10">
      <input type="password" class="form-control" id="exampleInputPassword1" name= "Password" placeholder="Password">
  </div>
</div>

  <div class="form-group">
    <label for="inputpassword3" class="col-sm-2 control-label" style= "font-family: 'Montserrat', sans-serif;"> <h4 style="color:#00004d"> Confirm </h4> </label>
    <div class="col-sm-10">
      <input type="password" class="form-control" id="inputPassword3" name="Confirm" placeholder="confirm your password">
    </div>
  </div>


  <div class="form-group">
  	<div class="col-sm-offset-2 col-sm-10">
  		<div class="radio">


  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
     	<button type="submit" class="btn btn-success" style= "font-family: 'Montserrat', sans-serif;">Submit</button>
     	<button type="button" class="btn btn-danger" style= "font-family: 'Montserrat', sans-serif;">Cancel</button>
    </div>

 </div>
</form>
<br>
<br>
<br>
<br>

		<!-- =================== Place all javascript at the end of the document so the pages load faster =================== -->
		<!-- jQuery library -->
		<script src="js/jquery.min.js"></script>
		<!-- Bootstrap core JavaScript -->
		<script	src="js/bootstrap.min.js"></script>
</body>
</html>
