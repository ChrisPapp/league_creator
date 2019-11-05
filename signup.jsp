<!DOCTYPE html>
<html lang="en">
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
	<meta name="description" content="Lab exercise template 2019-2020">
	<meta name="author" content="sofos@aueb.gr">
	<link rel="icon" href="images/favicon.ico">

	<title>1η Ατομική Άσκηση</title>

	<!-- Bootstrap core CSS -->
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<!-- Bootstrap Optional theme -->
	<link rel="stylesheet" href="css/bootstrap-theme.min.css">
	<!-- Custom styles for this template -->
	<link href="css/theme_8XXXXXX.css" rel="stylesheet">
	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
		  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->
	</head>

	<body>

		<!-- Fixed navbar -->
		<nav class="navbar navbar-inverse navbar-fixed-top">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span> <span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="#">8170117</a>
				</div>
				<div id="navbar" class="navbar-collapse collapse">
					<ul class="nav navbar-nav">
						<li><a href="index_8170117.jsp">Home</a></li>
						<li class="active"><a href="register_8170117.jsp">Register</a></li>
						<li><a href="about_8170117.jsp">About</a></li>
					</ul>

				</div>
				<!--/.nav-collapse -->
			</div>
		</nav>

		<div class="container theme-showcase" role="main">

			<!-- Main jumbotron for a primary marketing message or call to action -->
			<div class="jumbotron">
				<h1>PROPATHLIMA
				</h1>
			</div>

			<!-- Page Title -->
			<div class="page-header">
				<h1> <p> Registration Form</h1>
			</div>

		</div>
		<!-- /container -->

		<!-- footer -->
		<footer class="navbar-inverse">
			<div class="container">
				<div class="row">
					<div class="col-xs-12">
						<p class="text-center">&copy; Copyright 2019 by ismgroup62</p>
					</div>
				</div>
			</div>
		</footer>
		<!-- End footer -->

		<!-- =================== Place all javascript at the end of the document so the pages load faster =================== -->
		<!-- jQuery library -->
		<script src="js/jquery.min.js"></script>
		<!-- Bootstrap core JavaScript -->
		<script	src="js/bootstrap.min.js"></script>

<div class="alert alert-warning" role="alert"> <b> <center> Please fill in the following form to create an account. </b> </center> </div>


<form class="form-horizontal" id="form1" name="form1" method="post" action="registerController_8170117.jsp">

   <div class="form-group">
      <label for="inputName3" class="col-sm-2 control-label">Name</label>
      <div class="col-sm-10">
        <input type="Name" class="form-control" id="inputName3" name= "Name" placeholder="Name">
      </div>
  </div>

  <div class="form-group">
      <label for="inputSurname3" class="col-sm-2 control-label">Surname</label>
      <div class="col-sm-10">
        <input type="Surname" class="form-control" id="inputSurname3" name= "Surname" placeholder="Surname">
      </div>
  </div>


  <div class="form-group">
    <label for="inputEmail3" class="col-sm-2 control-label">Email</label>
    <div class="col-sm-10">
      <input type="email" class="form-control" id="inputEmail3" name= "Email" placeholder="Email">
    </div>
  </div>

  <div class="form-group">
        <label for="input	Username3" class="col-sm-2 control-label">Username</label>
        <div class="col-sm-10">
          <input type="Username" class="form-control" id="inputUsername3" name= "Username" placeholder="Username">
        </div>
    </div>


  <div class="form-group">
      <label for="exampleInputPassword1" class="col-sm-2 control-label">Password</label>
      <div class="col-sm-10">
      <input type="password" class="form-control" id="exampleInputPassword1" name= "Password" placeholder="Password">
  </div>
</div>

  <div class="form-group">
    <label for="inputpassword3" class="col-sm-2 control-label">Confirm</label>
    <div class="col-sm-10">
      <input type="Password" class="form-control" id="inputPassword3" placeholder="confirm your password">
    </div>
  </div>


  <div class="form-group">
  	<div class="col-sm-offset-2 col-sm-10">
  		<div class="radio">


    <div class="form-group">
      <div class="col-sm-offset-2 col-sm-10">
        <div class="checkbox">
          <label>
            <input type="checkbox" class="form-control" id="inputAnswer3" name="Answer"> I agree to the terms and conditions
          </label>
        </div>
      </div>
  </div>

  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
     	<button type="submit" class="btn btn-success" action="registerController_8170117.jsp">Submit</button>
     	<button type="button" class="btn btn-danger">Cancel</button>
    </div>

</form>

</body>
</html>