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
		final String altImg = "images/member1.png";
		boolean isMyProfile; // We need to show different things to ourselfs and other things to strangers
		final int ENTRY_LIMIT = 3;
		List<Result> resultList;
		if (userParam == null || (currentUser != null && currentUser.getId() == Integer.parseInt(userParam))) {
			user = currentUser;
		} else {
			user = User.getById(Integer.parseInt(userParam), currentLeague.getId());
		}
		if (user == null) { %> <h1>No such user in <%=currentLeague.getName()%></h1> <% return;} 

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
			imgSrc = altImg;
		}
	%>
	<%  boolean shouldAnimate = session.getAttribute("lastPage") == "home.jsp";
        String bgClasses, contentClasses;
        if (shouldAnimate) {
          bgClasses = "bg-image";
          contentClasses = "content blur";
        } else {
          bgClasses = "bg-image blur";
          contentClasses = "content";
        }
    %>

  	<body>
		<%@ include file="navbar.jsp" %>
		<div class="<%=bgClasses%>"></div>
		<div class="<%=contentClasses%>">
			<h1 id="title"><%=title%></h1>
			<div id="container">
				<% if (isMyProfile || (currentUser != null && currentUser.isAdmin())) { %> <form method=POST action="updateUser.jsp"> <% } %>
				<div class="defBubble" id="account">
					<img class="clickable" id="profile_pic" src="<%=imgSrc%>" onerror='this.src="<%=altImg%>";'>
					<h4>Name: <span class="bubbleInfo clickable" id="name"><%=user.getName()%></span></h4>
					<h4>Surname: <span class="bubbleInfo clickable" id="surname"><%=user.getSurname()%></span></h4>
					<h4>Email: <span class="bubbleInfo clickable" id="email"><%=user.getEmail()%></span></h4>
					<% if (isMyProfile || (currentUser != null && currentUser.isAdmin())) { %>
						<h4>Phone: <span class="bubbleInfo clickable" id="phone"><%=user.getPhone()%></span></h4>
					<% } %>
					<% if (isMyProfile || (currentUser != null && currentUser.isAdmin())) { 
						session.setAttribute("userToUpdate", user);
					%>
						<button type="submit" class="defButton" id="clickableSubmit" style="display: none;">Update Account</button>
					<% } %>
				</div>
				<% if (isMyProfile || (currentUser != null && currentUser.isAdmin())) { %> </form> <% } %>


				<div class="defBubble" id="team">
					<% if (user.getTeam() == null) { %>
						<img src="images/team.jpg" alt="No team">
						<h2>Free Agent</h2>

						<% if (isMyProfile) { %>
							<button class="defButton" onclick="location.href = 'createteam.jsp';">Create Team</button>
						<%} else if (currentUser != null && currentUser.isTeamLeader()){ %>
							<button class="defButton" onclick="location.href = 'updateUserTeam.jsp?user=<%=user.getId()%>&team=<%=currentUser.getTeam().getId()%>';">Add to your team</button>
						<%} %>
					<%} else {%>
						<a href="team.jsp?team=<%=user.getTeam().getId()%>"><img src="<%= user.getTeam().getLogo()%>" alt="images/team.jpg"></a>
						<% if (isMyProfile && !user.isTeamLeader()) { %>
							<button class="defButton" onclick="location.href = 'updateUserTeam.jsp?user=<%=user.getId()%>';">Leave team</button>
						<%} else if (user.isTeamLeader()) { %>
							<h4>Team Leader</h4>
						<% } %>
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
							<% if (totalMatches > ENTRY_LIMIT) { %>
								<button class="defButton toggleBtn" id="toggleTeam">More</button>
							<% } %>
						</div>
					<% } %>
				</div>

				<% if ((!isMyProfile && currentUser != null && currentUser.isAdmin()) || user.canReferee()) { %>
					<div class="defBubble" id="referee">
						<img src="images/refAvatar.jpg" alt="Matches as referee">
						<% if (currentUser != null && currentUser.isAdmin() && !user.isAdmin()) { 
							session.setAttribute("userToUpdate", user);
						%>
							<button class="defButton" onclick="location.href = 'updateUser.jsp?toggleReferee=0';"><%= user.canReferee() ? "Kick Referee" : "Make Referee"%></button>
						<%} %>

						<% if (user.canReferee()) {
							resultList = user.getMatches(true);
							if (resultList.size() > 0) { %>
								<h2>Recent matches</h2>
								<div class="list">
									<% 
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
							<% } else {%>
								<h2>No matches as referee yet</h2>
							<% } %>
						<% } %>
					</div>
				<% } %>

				<% if ((!isMyProfile && currentUser != null && currentUser.isAdmin()) || user.canPost()) { %>
					<div class="defBubble" id="posts">
						<img src="images/postIcon.jpg" alt="Recent posts">
						<% if (currentUser != null && currentUser.isAdmin() && !user.isAdmin()) { 
							session.setAttribute("userToUpdate", user);
						%>
							<button class="defButton" onclick="location.href = 'updateUser.jsp?togglePoster=0';"><%= user.canPost() ? "Ban Posting" : "Allow Posting"%></button>
						<%} %>

						<% if (isMyProfile && user.canPost()) { %>
							<button class="defButton" onclick="location.href = 'createpost.jsp';">Create Post</button>
						<%} %>

						<% if (user.canPost()) {
							List<Post> postList = currentLeague.getPosts(user.getId(), -1);
							if (postList.size() > 0) { %>
								<h2>Recent Posts by <span class="bubbleName"><%= user.getName() %></span></h2>
								<div class="list">
									<% 
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
							<% } else {%>
								<h2>No posts have been made by <span class="bubbleName"><%=user.getFullName()%></span></h2>
							<% } %>
						<% } %>
					</div>
				<% } %>
			</div>
		</div>
		<%-- Code for More/Less buttons --%>
      <script src="js/moreLessBtn.js"></script> 
	<% if (isMyProfile || (currentUser != null && currentUser.isAdmin())) { /* Import the clickable interface so the user can change the account data */ %>
	  	<script src="js/clickable.js"></script>
	<% } %>

	<% if (shouldAnimate) { %>
      <script src="js/jquery.min.js"></script>
      <script>
          $(document).ready(function(e){
              $(".bg-image , .content").toggleClass("blur");
            });
      </script>
    <% } %>
    </body>
</html>
<% session.setAttribute("lastPage", "profile.jsp"); %>