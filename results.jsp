<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="league.*" %>
<%@ page import="database.DatabaseAccess" %>
<%@ page import="java.util.ArrayList" %>

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
		<%@ include file="navbar.html" %>
    <% ArrayList<Group> groups = currentLeague.getLeagueGroups(); %>
    <div class="group-container">
      <% for (Group group : groups)  { %>
       <div class="grid-container">
        <div class="grid">
        <% ArrayList<Team> teams = group.getGroupTeams(); 
         // First create the upper left column with all the logos. First goes the league Logo, the logo of every team.
        %>
          <div class="grid-col grid-col--fixed-left">
            <div class="grid-item grid-item--header">
              <img src=<%= currentLeague.getLogo() %> alt=<%= currentLeague.getName() %>>
            </div>
         <% for (Team team: teams) { %>
            <div class="grid-item grid-item--header">
              <img src=<%= team.getLogo() %> alt=<%= team.getName() %>>
            </div>
         <%} %>
          </div>
          <% // Now create the column per-team, first goes team-logo, then follow the results with every team of the group.
            for (Team team: teams) { %>
            <div class="grid-col">
              <div class="grid-item grid-item--header">
                <img src=<%= team.getLogo() %> alt=<%= team.getName() %>>
              </div>
              <%-- TODO: Make these dynamic as well --%>
              <div class="grid-item result">
                <a href="match.html"><p>1-0</p></a>
              </div>
              <div class="grid-item result">
                <a href="match.html"><p>2-0</p></a>      
              </div>
              <div class="grid-item result">
                <a href="match.html"><p>3-0</p></a>
              </div>
            </div>
         <%} %>
         </div>
        </div>
      <%} %>
    </div>
  </body>
</html>