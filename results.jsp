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
    <div class=bg-image></div>
    <div class=content>
      <% ArrayList<Group> groups = currentLeague.getLeagueGroups(); %>
      <div class="group-container">
        <% for (Group group : groups)  { %>
        <div class="grid-container">
            <div class="group-title">
              <h2><%= group.getName() %></h2>
            </div>
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
  </body>
</html>