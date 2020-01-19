
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
	<link rel="stylesheet" href="css/default_styles.css">

	</head>
	
	<body>

		<div class="container theme-showcase" role="main">

			<!-- Main jumbotron for a primary marketing message or call to action -->
			<div class="header" style= "font-family: 'Lilita One', cursive;";>
				<div align="center">
					<h1 style="color:#00004d">FootClub</h1>
				</div>
			</div>

			<!-- Page Title -->
			<div class="page-header" style= "font-family: 'Montserrat', sans-serif;";>
				<h1 style="color:#00004d"> <p> Create your own League</h1>
			</div>

			
			<form class="form-horizontal" id="form1" name="form1" method="post" action="createleagueController.jsp">

				<div class="form-group">
					<label for="inputLeagueName3" class="col-sm-2 control-label" style= "font-family: 'Montserrat', sans-serif;"> <h4 style="color:#00004d"> Name of League</h4> </label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="inputLeagueName3" name= "leagueName" placeholder="LeagueName">
						</div>
				</div>
				
				<div class="form-group">
					<label for="inputLeagueLogo3" class="col-sm-2 control-label" style= "font-family: 'Montserrat', sans-serif;"> <h4 style="color:#00004d"> Logo of League</h4> </label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="inputLeagueLogo3" name= "logoPath" placeholder="LeagueLogo">
						</div>
				</div>

				<!-- Page Title -->
				<div class="page-header" style= "font-family: 'Montserrat', sans-serif;";>
					<h1 style="color:#00004d"> <p> Create your admin account</h1>
				</div>

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
					<label for="inputphone3" class="col-sm-2 control-label" style= "font-family: 'Montserrat', sans-serif;"> <h4 style="color:#00004d"> Phone </h4> </label>
					<div class="col-sm-10">
					<input type="phone" class="form-control" id="inputPhone3" name="Phone" placeholder="Enter your phone number">
					</div>
				</div>
				
				<div class="form-group">
					<label for="inputpicture3" class="col-sm-2 control-label" style= "font-family: 'Montserrat', sans-serif;"> <h4 style="color:#00004d"> Profile photo </h4> </label>
					<div class="col-sm-10">
					<input type="picture" class="form-control" id="inputpicture3" name="Picture" placeholder="Enter the link of your profile photo">
					</div>
				</div>


				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<button type="submit" class="defButton">Save</button>
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
