<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="league.*" %>
<%@ page import="java.util.List" %>

<%-- begin html --%>
<!DOCTYPE html>
<html lang="en">
  	<head>
    	<%@ include file="LeagueHeadDefaults.jsp" %>
      <!-- Import the base grid styles -->
      <link rel="stylesheet" type="text/css" href="css/profile.css">
  	</head>
	<%  User user = null;
		String userParam = request.getParameter("user");
		String title;
		String imgSrc;
		boolean isMyProfile; // We need to show different things to ourselfs and other things to strangers
		final int ENTRY_LIMIT = 3;
		List<Result> resultList;
		if (userParam == null || (currentUser != null && currentUser.getId() == Integer.parseInt(userParam))) {
			user = currentUser;
		} else {
			user = User.getById(Integer.parseInt(userParam));
		}
		if (user == null) { %> <jsp:forward page="login.jsp"/> <%} 

		isMyProfile = currentUser != null && user.getId() == currentUser.getId();

		// Set page title
		if (isMyProfile) {
			title = "My Profile";
		} else {
			title = user.getFullName();
		}

		// Set image src
		imgSrc = user.getProfilePic();
		if (imgSrc == null) {
			imgSrc = "images/member1.png";
		}
	%>

  	<body>
		<%@ include file="navbar.jsp" %>
		<div class="bg-image"></div>
		<div class="content">
			<h1 id="title"><%=title%></h1>
			<div id="container">


				<% if (isMyProfile) { %> <form method=POST action="updateUser.jsp"> <% } %>
				<div class="profileBubble" id="account">
					<img class="clickable" id="profile_pic" src="<%=imgSrc%>" alt="<%=user.getFullName()%>">
					<h4>Name: <span class="bubbleInfo clickable" id="name"><%=user.getName()%></span></h4>
					<h4>Surname: <span class="bubbleInfo clickable" id="surname"><%=user.getSurname()%></span></h4>
					<h4>Email: <span class="bubbleInfo clickable" id="email"><%=user.getEmail()%></span></h4>
					<% if (isMyProfile || (currentUser != null && currentUser.isAdmin())) { %>
						<h4>Phone: <span class="bubbleInfo clickable" id="phone"><%=user.getPhone()%></span></h4>
					<% } %>
					<% if (isMyProfile) { 
						session.setAttribute("userToUpdate", user);
					%>
						<button class="defButton" id="clickableSubmit" style="display: none;">Update Account</button>
					<% } %>
				</div>
				<% if (isMyProfile) { %> </form> <% } %>


				<div class="profileBubble" id="team">
					<% if (user.getTeam() == null) { %>
						<img src="images/team.jpg" alt="No team">
						<h2>Free Agent</h2>

						<% if (isMyProfile) { %>
							<button class="defButton" onclick="location.href = 'createTeam.jsp';">Create Team</button>
						<%} else if (currentUser != null && currentUser.isTeamLeader()){ %>
							<button class="defButton" onclick="location.href = 'updateUserTeam.jsp?user=<%=user.getId()%>&team=<%=currentUser.getTeam().getId()%>';">Add to your team</button>
						<%} %>
					<%} else {%>
						<img src="<%= user.getTeam().getLogo()%>" alt="<%= user.getTeam().getName()%>">
						<% if (isMyProfile) { %>
						<button class="defButton" onclick="location.href = 'updateUserTeam.jsp?user=<%=user.getId()%>';">Leave team</button>
						<%} %>
						<h2>Recent matches</h2>
						<div class="list">
							<% 	resultList = user.getMatches(false);
								int totalMatches = 0;
								for (int i = 0; i < resultList.size(); i++) { 
									Result result = resultList.get(i);
									if (result.goalsHome == null || result.goalsAway==null) {
										continue;
									}
									totalMatches++;
							%>
								<% if (i < ENTRY_LIMIT) { %> <div class="listItem"> <% } else { %> <div class="listItem toggleTeam" style="display: none;"> <% } %>
									<a href="match.jsp?match=<%=result.matchId%>" class="link"><%=result.getMatchName()%></a>
									<p class="listParag"> <%=result.getScore()%> </p>
								</div>
							<%	}%>
							<p class="total">Total matches: <span class="count"><%=totalMatches%></span></p>
							<% if (resultList.size() > ENTRY_LIMIT) { %>
								<button class="defButton toggleBtn" id="toggleTeam">More</button>
							<% } %>
						</div>
					<% } %>
				</div>


				<div class="profileBubble" id="referee">
					<img src="images/refAvatar.jpg" alt="Matches as referee">
					<h2>Recent matches</h2>
					<div class="list">
						<% 	resultList = user.getMatches(true);
							for (int i = 0; i < resultList.size(); i++) { 
								Result result = resultList.get(i);
						%>
							<% if (i < ENTRY_LIMIT) { %> <div class="listItem"> <% } else { %> <div class="listItem toggleMatch" style="display: none;"> <% } %>
								<a href="match.jsp?match=<%=result.matchId%>" class="link"><%=result.getMatchName()%></a>
								<p class="listParag"> <%=result.getScore()%> </p>
							</div>
						<%	}%>
						<p class="total">Total matches: <span class="count"><%=resultList.size()%></span></p>
						<% if (resultList.size() > ENTRY_LIMIT) { %>
							<button class="defButton toggleBtn" id="toggleMatch">More</button>
						<% } %>
					</div>
				</div>


				<div class="profileBubble" id="posts">
					<img src="images/postIcon.jpg" alt="Recent posts">
					<h2>Recent Posts</h2>
					<div class="list">
						<% 	List<Post> postList = currentLeague.getPosts(user.getId(), -1);
							for (int i = 0; i < postList.size(); i++) { 
								Post post = postList.get(i);
						%>
							<% if (i < ENTRY_LIMIT) { %> <div class="listItem"> <% } else { %> <div class="listItem togglePost" style="display: none;"> <% } %>
								<a href="post.jsp?post=<%=post.getId()%>" class="link"><%=post.getTitle()%></a>
								<p class="listParag" style="text-align: right;"> <%=post.getDateString()%> </p>
							</div>
						<%	}%>
						<p class="total">Total posts: <span class="count"><%=postList.size()%></span></p>
						<% if (postList.size() > ENTRY_LIMIT) { %>
							<button class="defButton toggleBtn" id="togglePost">More</button>
						<% } %>
					</div>
				</div>
			</div>
		</div>
		<%-- Code for More/Less buttons --%>
      <script src="js/profile.js"></script> 
	<% if (isMyProfile) { /* Import the clickable interface so the user can change the account data */ %>
	  	<script src="js/clickable.js"></script>
	<% } %>
    </body>
</html>