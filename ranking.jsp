<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="league.*" %>
<%@ page import="database.DatabaseAccess" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.TreeSet" %>

<%-- begin html --%>
<!DOCTYPE html>
<html lang="en">
	<head>
  	<%@ include file="LeagueHeadDefaults.jsp" %>
    <!-- Import the base grid styles -->
    <link rel="stylesheet" type="text/css" href="css/grid.css">
    <!-- Ranking specific styles -->
    <link rel="stylesheet" type="text/css" href="css/ranking.css">
	</head>
	<body>
		<%@ include file="navbar.jsp" %>
    <div class="bg-image"></div>
    <div class="content">
      <% ArrayList<Group> groups = currentLeague.getLeagueGroups(); %>
      <div class="group-container">
        <% for (Group group : groups)  { %>
        <div class="grid-container">
            <div class="group-title">
              <h2><%= group.getName() %></h2>
            </div> 
          <div class="grid">
          <% TreeSet<TeamStats> rankings = group.getGroupRankings(); 
          // First create the upper left column with all the logos. First goes the league Logo, the logo of every team.
          %>
            <div class="grid-col grid-col--fixed-left">
              <div class="grid-item grid-item--header grid-corner">
                <img src=<%= currentLeague.getLogo() %> alt=<%= currentLeague.getName() %>>
              </div>
              <% for (TeamStats ts: rankings) { %>
                  <div class="grid-item grid-item--header">
                    <img src=<%= ts.team.getLogo() %> alt=<%= ts.team.getName() %>>
                  </div>
              <%} %>
            </div>
            <div class="grid-col">
              <div class="grid-item grid-item--header">
                <h2>Points</h2>
              </div>
              <% for (TeamStats ts: rankings) { %>
                  <div class="grid-item">
                    <p><%=ts.getPoints()%></p>
                  </div>
              <%} %>
            </div>

            <div class="grid-col">
              <div class="grid-item grid-item--header">
                <h2>Matches</h2>
              </div>
              <% for (TeamStats ts: rankings) { %>
                  <div class="grid-item">
                    <p><%=ts.getTotalMatches()%></p>
                  </div>
              <%} %>
            </div>

            <div class="grid-col">
              <div class="grid-item grid-item--header">
                <h2>Wins</h2>
              </div>
              <% for (TeamStats ts: rankings) { %>
                  <div class="grid-item">
                    <p><%=ts.wins%></p>
                  </div>
              <%} %>
            </div>

            <div class="grid-col">
              <div class="grid-item grid-item--header">
                <h2>Draws</h2>
              </div>
              <% for (TeamStats ts: rankings) { %>
                  <div class="grid-item">
                    <p><%=ts.draws%></p>
                  </div>
              <%} %>
            </div>

            <div class="grid-col">
              <div class="grid-item grid-item--header">
                <h2>Defeats</h2>
              </div>
              <% for (TeamStats ts: rankings) { %>
                  <div class="grid-item">
                    <p><%=ts.defeats%></p>
                  </div>
              <%} %>
            </div>

            <div class="grid-col">
              <div class="grid-item grid-item--header">
                <h2>Goals For</h2>
              </div>
              <% for (TeamStats ts: rankings) { %>
                  <div class="grid-item">
                    <p><%=ts.goalsScored == null ? "-" : ts.goalsScored%></p>
                  </div>
              <%} %>
            </div>
            <div class="grid-col">
              <div class="grid-item grid-item--header">
                <h2>Goals Against</h2>
              </div>
              <% for (TeamStats ts: rankings) { %>
                  <div class="grid-item">
                    <p><%=ts.goalsAgainst == null ? "-" : ts.goalsAgainst%></p>
                  </div>
              <%} %>
            </div>
          </div>
        </div>
        <%} %>
      </div>
    </div>
  </body>
</html>