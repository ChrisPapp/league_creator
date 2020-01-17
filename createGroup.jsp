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
    <%@ include file="LeagueHeadDefaults.jsp" %>

	</head>

	<%
		if (currentUser == null) {
			session.setAttribute("message", "You have to log in, in order to use this site!");
            response.sendRedirect("login.jsp");
            return;
        
        } else if (!currentUser.isAdmin()){
		
		     response.sendRedirect("results.jsp");
             return;
        }%>
	

	
	<body>
		
		<%@ include file="navbar.jsp" %>

        <% List<Team> teams = currentLeague.getLeagueTeams(); %>

        <style type="text/css" media="screen">

            .check{
                opacity:0.5;
                color:#996;
                
            }

            img {
                width: 50px;
                height: 50px !important;
                object-fit: contain;
            }

        </style>


		<div class="container theme-showcase" role="main">

			<!-- Main jumbotron for a primary marketing message or call to action -->
			<div class="header" style= "font-family: 'Lilita One', cursive;";>
				<div align="center">
					<h1 style="color:#00004d"><%=currentLeague.getName()%></h1>
				</div>
			</div>

			<!-- Page Title -->
			<div class="page-header" style= "font-family: 'Montserrat', sans-serif;" align="center">
				<h1 style="color:#00004d"> <p> Name your group and select its teams</h1>
			</div>

            <%-- Image selector based on: https://bootsnipp.com/snippets/Zl6ql --%>
			
			<form class="form-horizontal" id="form1" name="form1" method="post" action="groupController.jsp">

				<div class="form-group">
					<label for="GroupName" class="col-sm-2 control-label" style= "font-family: 'Montserrat', sans-serif;"> <h4 style="color:#00004d"> Group Name</h4> </label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="TeamName" name= "GroupName" placeholder="Name of the new group">
						</div>
				</div>
				
				<div class="form-group">
                    <% 	for (Team team : teams) { %>
                    <div class="col-md-3" align="center" style="margin: 20px;"><label class="btn btn-primary clickable">
                        <img src="<%=team.getLogo()%>" alt="<%=team.getName()%>" class="img-thumbnail img-check">
                        <input type="checkbox" name="team" value="<%=team.getId()%>" class="hidden" autocomplete="off">
                    </label></div>
                    <% } %>
                </div>

				<div class="form-group">
					<div class="col-sm-12" align="center">
						<button type="submit" class="defButton">Create</button>
					</div>
				</div>
			</form>
		</div>
		<!-- /container -->

		<script src="js/jquery.min.js"></script>
		<!-- Bootstrap core JavaScript -->
		<script	src="js/bootstrap.min.js"></script>
        <script>
            $(document).ready(function(e){
               
                // Add the click event to the whole label, because clicking on the border would not change the color
                $(".clickable").click(function(event){
                    event.preventDefault();
                    $(this).find('img').toggleClass("check");
                    var checkBox = $(this).find('input:checkbox'); 
                    checkBox.attr('checked', !checkBox.attr('checked'));
                });
	        });
        </script>
</body>
</html>
