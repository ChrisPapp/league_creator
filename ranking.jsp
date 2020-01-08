<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="league.Team" %>
<%@ page import="league.League" %>
<%@ page import="database.DatabaseAccess" %>
<%@ page import="java.util.ArrayList" %>

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


    <% 
      DatabaseAccess db = new DatabaseAccess();

      ArrayList<Team> teams = currentLeague.getLeagueTeams();
    %>
    <div class="group-container">
      <div class="grid-container">
        <div class="grid">
          <div class="grid-col grid-col--fixed-left">
            <div class="grid-item grid-item--header">
              <img src="https://seeklogo.com/images/G/greece-super-league-logo-19FBE0771B-seeklogo.com.gif" alt="Super League Logo">
            </div>
            <%
              for (int i = 0; i < teams.size(); i++) {
            %>
              <div class="grid-item">
                <img src=<%= teams.get(i).getLogo() %> alt=<%= teams.get(i).getName() %>>
              </div>
            <%
              }
            %>
          </div>

          <div class="grid-col">
            <div class="grid-item grid-item--header">
              <h2>Points</h2>
            </div>
            <div class="grid-item result">
              <p>33</p>
            </div>
            <div class="grid-item result">
              <p>20</p>
            </div>
            <div class="grid-item result">
              <p>19</p>
            </div>
            <div class="grid-item result">
              <p>17</p>
            </div>
            <div class="grid-item result">
              <p>10</p>
            </div>
            <div class="grid-item result">
              <p>3</p>
            </div>
          </div>

          <div class="grid-col">
            <div class="grid-item grid-item--header">
              <h2>Matches</h2>
            </div>
            <div class="grid-item result">
              <p>11</p>
            </div>
            <div class="grid-item result">
              <p>11</p>
            </div>
            <div class="grid-item result">
              <p>11</p>
            </div>
            <div class="grid-item result">
              <p>11</p>
            </div>
            <div class="grid-item result">
              <p>11</p>
            </div>
            <div class="grid-item result">
              <p>11</p>
            </div>
          </div>

          <div class="grid-col">
            <div class="grid-item grid-item--header">
              <h2>Wins</h2>
            </div>
            <div class="grid-item result">
              <p>11</p>
            </div>
            <div class="grid-item result">
              <p>6</p>
            </div>
            <div class="grid-item result">
              <p>5</p>
            </div>
            <div class="grid-item result">
              <p>4</p>
            </div>
            <div class="grid-item result">
              <p>3</p>
            </div>
            <div class="grid-item result">
              <p>0</p>
            </div>
          </div>

          <div class="grid-col">
            <div class="grid-item grid-item--header">
              <h2>Draws</h2>
            </div>
            <div class="grid-item result">
              <p>0</p>
            </div>
            <div class="grid-item result">
              <p>2</p>
            </div>
            <div class="grid-item result">
              <p>4</p>
            </div>
            <div class="grid-item result">
              <p>1</p>
            </div>
            <div class="grid-item result">
              <p>2</p>
            </div>
            <div class="grid-item result">
              <p>3</p>
            </div>
          </div>

          <div class="grid-col">
            <div class="grid-item grid-item--header">
              <h2>Losses</h2>
            </div>
            <div class="grid-item result">
              <p>0</p>
            </div>
            <div class="grid-item result">
              <p>3</p>
            </div>
            <div class="grid-item result">
              <p>2</p>
            </div>
            <div class="grid-item result">
              <p>6</p>
            </div>
            <div class="grid-item result">
              <p>6</p>
            </div>
            <div class="grid-item result">
              <p>8</p>
            </div>
          </div>

          <div class="grid-col">
            <div class="grid-item grid-item--header">
              <h2>Goals For</h2>
            </div>
            <div class="grid-item result">
              <p>29</p>
            </div>
            <div class="grid-item result">
              <p>18</p>
            </div>
            <div class="grid-item result">
              <p>13</p>
            </div>
            <div class="grid-item result">
              <p>10</p>
            </div>
            <div class="grid-item result">
              <p>9</p>
            </div>
            <div class="grid-item result">
              <p>5</p>
            </div>
          </div>
          <div class="grid-col">
            <div class="grid-item grid-item--header">
              <h2>Goals Against</h2>
            </div>
            <div class="grid-item result">
              <p>4</p>
            </div>
            <div class="grid-item result">
              <p>8</p>
            </div>
            <div class="grid-item result">
              <p>10</p>
            </div>
            <div class="grid-item result">
              <p>13</p>
            </div>
            <div class="grid-item result">
              <p>15</p>
            </div>
            <div class="grid-item result">
              <p>20</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>