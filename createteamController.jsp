<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="setLeague.jsp" %>
<%@ page import="league.*"%>

<%
	if (currentUser != null && currentUser.getTeam() == null) {
		String teamname = request.getParameter("TeamName"); 
		String logopath = request.getParameter("TeamLogo");

		
		int idleague = currentLeague.getId();
		int idleader = currentUser.getId();
		
		Team team = new Team( 1, idleague, teamname, logopath, idleader ); 
		
		int id = Team.createTeam(team);
		team.setId(id);
		currentUser.setTeam(team); // Update front end object
	}
    %>
 
  <jsp:forward page="profile.jsp"/>
 
 
 
 </body>
 </html>
 
 