<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="league.*" %>
<%@ page import="java.util.List" %>

<%-- begin html --%>
<!DOCTYPE html>
<html lang="en">
  	<head>
    	<%@ include file="LeagueHeadDefaults.jsp" %>
      <!-- Import the base grid styles -->
      <link rel="stylesheet" type="text/css" href="css/team.css">
  	</head>
	<%  Team team = null;
		String teamParam = request.getParameter("team");
		String imgSrc;
		final String altImg = "images/team.jpg";
		boolean isMyTeam, isTeamLeader; // We need to show different things to ourselfs and other things to strangers
        if (teamParam == null && currentUser != null && currentUser.isTeamLeader()) {
            team = Team.getById(currentUser.getTeam().getId(), currentLeague.getId());
        } else {
            if (teamParam == null) { %>
                <h1>No such team in <%=currentLeague.getName()%></h1>
            <%return;
            } else {
                team = Team.getById(Integer.parseInt(teamParam), currentLeague.getId());
            }
        }
		if (team == null) { %> <h1>No such team in <%=currentLeague.getName()%></h1> <% return;} 

		isMyTeam = currentUser != null && currentUser.getTeam() != null && currentUser.getTeam().getId() == team.getId();
        isTeamLeader = currentUser != null && currentUser.isTeamLeader();

		// Set image src
		imgSrc = team.getLogo();
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
            <% if (isTeamLeader) { %> <form method=POST action="updateTeam.jsp"> <% } %>
            <div id="teamContainer">
            	<h1 class="clickable" id="teamName"><%=team.getName()%></h1>
                <img class="clickable" id="teamLogo" src="<%=imgSrc%>" onerror='this.src="<%=altImg%>";'>
                <button type="submit" class="defButton" id="clickableSubmit" style="display: none;">Update Team</button>
            </div>
            <% if (isTeamLeader) { %> </form> <% } %>
			<div id="memberContainer">
                <% for (User member : team.getMembers()) { %>
                    <div class="defBubble" id="<%=member.isTeamLeader() ? "leader" : "member"%>">
                        <a href="profile.jsp?user=<%=member.getId()%>"><img src="<%=member.getProfilePic()%>" onerror='this.src="<%="images/member1.png"%>";'></a>
                        <% if (member.isTeamLeader()) { %>
                            <h4>Team Leader</h4>
                        <% } %>
                        <% if (isTeamLeader && member.getId() != currentUser.getId()) { %>
                            <button class="defButton" onclick="location.href = 'updateUserTeam.jsp?user=<%=member.getId()%>';">Kick member</button>
                        <% } %>
                        <h4>Name: <span class="bubbleInfo"><%=member.getName()%></span></h4>
                        <h4>Surname: <span class="bubbleInfo"><%=member.getSurname()%></span></h4>
                        <h4>Email: <span class="bubbleInfo"><%=member.getEmail()%></span></h4>
                        <% if (isMyTeam) { %>
                            <h4>Phone: <span class="bubbleInfo"><%=member.getPhone()%></span></h4>
                        <% } %>
                    </div>
                <% } %>
			</div>
		</div>
	<% if (isTeamLeader) { /* Import the clickable interface so the user can change the team data */ %>
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
<% session.setAttribute("lastPage", "team.jsp"); %>