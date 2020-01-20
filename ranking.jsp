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


      <%  session.setAttribute("lastPage", "ranking.jsp");
          ArrayList<Group> groups = currentLeague.getLeagueGroups(); %>
      
      <% if (groups.size() == 0) { %>
        <h1 style="text-align: center;"><%=currentLeague.getName()%> has no groups yet</h1>
         <% if (currentUser != null && currentUser.isAdmin()) { %>
          <div style="display: flex; justify-content: center; padding-bottom: 50px;">
            <button class="defButton toggleBtn" id="togglePost" onClick="location.href = 'createGroup.jsp';">Create Group</button>
          </div>
        <% } %>
      <%}%>
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
                    <a href="team.jsp?team=<%=ts.team.getId()%>"><img src="<%= ts.team.getLogo() %>" alt="<%= ts.team.getName() %>"></a>
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