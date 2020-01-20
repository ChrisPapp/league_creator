<!-- @author ΠΑΠΠΑΣ ΧΡΗΣΤΟΣ 8170105 ΚΑΙ ΣΙΜΙΤΖΗ ΙΩΑΝΝΑ 8170117 -->
<nav>
	<ul class=main-nav>
		<li id="home"><a href="home.jsp" style= "font-family: 'Montserrat', sans-serif;";>Home</a></li>
		<li id="results"><a href="results.jsp" style= "font-family: 'Montserrat', sans-serif;";>Results</a></li>
		<li id="ranking"><a href="ranking.jsp" style= "font-family: 'Montserrat', sans-serif;";>Ranking</a></li>
		<% if (currentUser == null) { %>
			<div class="push" style="display:flex;">
				<li id="login"><a href="login.jsp" style= "font-family: 'Montserrat', sans-serif;";>Login</a></li>
				<li id="register"><a href="register.jsp" style= "font-family: 'Montserrat', sans-serif;";>Register</a></li>
			</div>
		<% } else { %>
			<div class="push" style="display:flex;">
				<li id="profile"><a href="profile.jsp" class="underline" style= "font-family: 'Montserrat', sans-serif;";><%= currentUser.getName() + " " + currentUser.getSurname() %></a></li>
				<li id="logout"><a href="logout.jsp" style= "font-family: 'Montserrat', sans-serif;";>Logout</a></li>
			</div>
		<% } %>
		<li id="chooseLeague"><a href="chooseLeague.jsp" style= "font-family: 'Montserrat', sans-serif;";>Exit League</a></li>	
		<link href="https://fonts.googleapis.com/css?family=Mansalva&display=swap" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css?family=Lilita+One|Mansalva&display=swap" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css?family=Montserrat&display=swap" rel="stylesheet">

	</ul>
	<%-- <div style="height 50px"></div> --%>
</nav>
