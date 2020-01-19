
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
	<link rel="stylesheet" href="css/chooseLeague.css">

	</head>
	
		<% 	
			List<LeagueStats> leagueStats = League.getAllLeagueStats();
			session.removeAttribute("league"); // Reset currentLeague;
			session.removeAttribute("user"); // Reset currentUser;
		%>
	
	<body>
		<div class="bg-image blur"></div>
    	<div class="content">
			<div class="container theme-showcase" role="main">

				<div class="header" style= "font-family: 'Lilita One', cursive;";>
					<div align="center">
						<h1 style="color:white">FootClub</h1>
					</div>
				</div>

				<div style="display: flex; justify-content: flex-end; padding-bottom: 10px;">
					<button class="defButton" onClick="location.href = 'createLeague.jsp';">Create League</button>
				</div>
				<div class="page-header" align=center style= "font-family: 'Montserrat', sans-serif;";>
					<h1 style="color: white"> <p> Choose one the available Leagues</h1>
				</div>
				

				<div class="leagueGrid">
						<% for (LeagueStats stats: leagueStats) { %>
						
								<div class="leagueContainer" onclick="location.href='home.jsp?league=<%=stats.league.getName()%>'">
									<img class="leagueLogo" src="<%=stats.league.getLogo()%>" onerror='this.src="images/league.jfif";'>
									<div class="leagueInfo">
										<h2> <%=stats.league.getName() %> </h3>
										<h3> Participants: <span class="info"><%=stats.userCount%></span>
										<h3> Teams: <span class="info"><%=stats.teamCount%></span>
									</div>
								</div>
							
						<% } %>
				</div>
			
			</div>
		</div>
	</div>
</body>
</html>