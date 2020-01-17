<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="league.*" %>
<%@ page import="database.DatabaseAccess" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>

<%-- begin html --%>
<!DOCTYPE html>
<html lang="en">
	<head> 	
<%@ include file="LeagueHeadDefaults.jsp" %>
    <!-- Import the base grid styles -->
    <link rel="stylesheet" type="text/css" href="css/grid.css">
    <!-- Result specific styles -->
    <link rel="stylesheet" type="text/css" href="css/results.css">
	</head>
	<body>
		<%@ include file="navbar.jsp" %>
    
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
    <div class="<%=bgClasses%>"></div>
    <div class="<%=contentClasses%>">
      <% 
        ArrayList<Group> groups = currentLeague.getLeagueGroups(); %>
      <% if (groups.size() == 0) { %>
        <h1 class="group-title"><%=currentLeague.getName()%> has no groups yet</h1>
      <%return;}%>
      <% if (currentUser != null && currentUser.isAdmin()) { %>
        <div style="display: flex; justify-content: center; padding-bottom: 50px;">
          <button class="defButton toggleBtn" id="togglePost" onClick="location.href = 'createGroup.jsp';">Create Group</button>
        </div>
      <% } %>
      <div class="group-container">
        <% for (Group group : groups)  { %>
        <div class="grid-container">
            <div class="group-title">
              <h2><%= group.getName() %></h2>
            </div>
            <% if (currentUser != null && currentUser.isAdmin()) { %>
              <div style="display: flex; justify-content: center;">
                <button class="defButton toggleBtn" id="togglePost" onClick="location.href = 'groupController.jsp?deleteGroup=<%=group.getId()%>';">Delete Group</button>
              </div>
            <% } %>
          <div class="grid">
          <% ArrayList<Team> teams = group.getGroupTeams(); 
          // First create the upper left column with all the logos. First goes the league Logo, the logo of every team.
          %>
            <div class="grid-col grid-col--fixed-left">
              <div class="grid-item grid-item--header grid-corner">
                <img src=<%= currentLeague.getLogo() %> alt=<%= currentLeague.getName() %>>
              </div>
          <% for (Team team: teams) { %>
              <div class="grid-item grid-item--header">
                <img src=<%= team.getLogo() %> alt=<%= team.getName() %>>
              </div>
          <%} %>
            </div>
            <% // Now create the column (away teams) per-team, first goes team-logo, then follow the results with every team (homeTeam) of the group.
              HashMap<Integer, HashMap<Integer, Result>> resultMap = group.getGroupResults();
              for (Team awayTeam: teams) { %>
              <div class="grid-col">
                <div class="grid-item grid-item--header">
                  <img src=<%= awayTeam.getLogo() %> alt=<%= awayTeam.getName() %>>
                </div>
                <% for (Team homeTeam: teams) {
                  // Handle table diagonal
                  if (homeTeam.equals(awayTeam)) { %>
                    <div class="grid-item result">
                      <p>X</p>
                    </div>
                  <% continue;
                  } %>
                <%  
                  Result result = result = resultMap.get(homeTeam.getId()).get(awayTeam.getId()); // If you crashed here, 
                                                                                                  // it probably means that you created a new Group, 
                                                                                                  // but not it's respective Matches and Stats in the database
                  String resultString = "";
                  String className = "";
                  if (result.matchId == null || result.goalsHome == null || result.goalsAway == null) {
                    resultString = "Scheduled";
                    className = "result_pending";
                  } else {
                      resultString = result.goalsHome + " - " + result.goalsAway;
                      if (result.goalsHome > result.goalsAway) {
                        className = "result_win";
                      } else if (result.goalsHome < result.goalsAway) {
                        className = "result_loss";
                      } else {
                        className = "result_draw";
                      }
                  }
                %>
                  <div class="grid-item result <%= className %>">
                    <a href = "match.jsp?match=<%=result.matchId%>">
                      <p><%= resultString %></p>
                    </a>
                  </div> 
          <% } %>
                </div>   
          <% } %>
          </div>
          </div>
        <%} %>
      </div>
    </div>
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
<% session.setAttribute("lastPage", "post.jsp"); %>