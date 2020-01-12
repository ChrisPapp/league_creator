<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="league.*" %>

<%-- begin html --%>
<!DOCTYPE html>
<html lang="en">
  	<head> 
      <%@ include file="LeagueHeadDefaults.jsp" %>
      <!-- Import the base grid styles -->
      <link rel="stylesheet" type="text/css" href="css/grid.css">
      <!-- Match specific styles -->
      <link rel="stylesheet" type="text/css" href="css/match.css">
  	</head>
  	<body>
  		<%@ include file="navbar.jsp" %>
      <%  Integer matchId = null;
          String matchIdParam = request.getParameter("match");
          Match currentMatch = null;
          if (matchIdParam != null) {
            try {
              matchId = Integer.parseInt(request.getParameter("match"));
              currentMatch = Match.getById(matchId);
            } catch (Exception e) {
              // What could possibly go wrong?
            }
          }
          if (matchId == null || currentMatch == null) {
       %>
            <jsp:forward page="results.jsp"/>
          <% } %>
      
      <%  if (currentUser != null && currentUser.canReferee()) {
          session.setAttribute("matchToUpdate", currentMatch);
      %>
        <form method="post" action="matchController.jsp">
      <% } %> 
    	<div class="grid-container">
      <div class="grid">
        <div class="grid-col grid-col--fixed-left">
          <div class="grid-item grid-item--header">
            <img src=<%= currentLeague.getLogo() %> alt=<%= currentLeague.getName() %>>
          </div>
          <div class="grid-item">
            <h2>Goals</h2>
          </div>
          <div class="grid-item">
            <h2>Yellow Cards</h2>
          </div>
          <div class="grid-item">
            <h2>Red Cards</h2>
          </div>
        </div>
        <div class="grid-col">
          <div class="grid-item grid-item--header">
            <img src=<%= currentMatch.getHome().getLogo() %> alt=<%= currentMatch.getHome().getName() %>>
          </div>
          <div class="grid-item result clickable" id="homeGoals">
            <p><%= currentMatch.getHomeStats().goalsScored != null ? currentMatch.getHomeStats().goalsScored : "-" %></p>
          </div>
          <div class="grid-item result clickable" id="homeYellows">
            <p><%= currentMatch.getHomeStats().yellowCards != null ? currentMatch.getHomeStats().yellowCards : "-" %></p>       
          </div>
          <div class="grid-item result clickable" id="homeReds">
            <p><%= currentMatch.getHomeStats().redCards != null ? currentMatch.getHomeStats().redCards : "-" %></p>
          </div>
        </div>

        <div class="grid-col">
          <div class="grid-item grid-item--header">
            <img src=<%= currentMatch.getAway().getLogo() %> alt=<%= currentMatch.getAway().getName() %>>
          </div>
          <div class="grid-item result clickable" id="awayGoals">
            <p><%= currentMatch.getAwayStats().goalsScored != null ? currentMatch.getAwayStats().goalsScored : "-" %></p>
          </div>
          <div class="grid-item result clickable" id="awayYellows">
            <p><%= currentMatch.getAwayStats().yellowCards != null ? currentMatch.getAwayStats().yellowCards : "-" %></p>       
          </div>
          <div class="grid-item result clickable" id="awayReds">
            <p><%= currentMatch.getAwayStats().redCards != null ? currentMatch.getAwayStats().redCards : "-" %></p>
          </div>
        </div>
      </div>
    </div>

    <div id="matchInfo">
      <div>
        <p>Referee: <% if (currentMatch.getReferee() != null) { %><a href="profile.jsp?user=<%=currentMatch.getReferee().getId()%>"><span id="refereeName"><%=currentMatch.getReferee().getFullName()%></span></a> <% } %></p>
      </div>
      <div class=clickable id="date">
        <p><%=currentMatch.getDateString()%></p>
      </div>
    </div>

    <% if (currentUser != null && currentUser.canReferee()) { %>
      <div class="submitContainer">
        	<button class="defButton" type="submit">Update match</button>
      </div>
      </form>	
      <%-- Code for clicking and changing to input box --%>
      <script src="js/match.js"></script> 
    <% } %>    
  </body>
</html>