<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="setLeague.jsp" %>
<%@ page import="league.*"%>
<%@ page import="java.util.ArrayList"%>

<%
    String groupName = null;
    String[] selectedTeams = null;
    String deleteGroup = null;
	if (currentUser != null && currentUser.isAdmin()) {
        
        deleteGroup = request.getParameter("deleteGroup");
        if (deleteGroup != null) {
            Group.deleteById(Integer.parseInt(deleteGroup));
            response.sendRedirect("results.jsp");
            return;
        }
		groupName = request.getParameter("GroupName"); 
		selectedTeams = request.getParameterValues("team");
        if (selectedTeams == null || selectedTeams.length <= 1 ) {
            response.sendRedirect("results.jsp");
            return;
        }
        ArrayList<Integer> teamIds = new ArrayList<Integer>();
        for (String teamIdString : selectedTeams) {
            teamIds.add(Integer.parseInt(teamIdString));
        }
        if (teamIds.size() > 0) {
            Group.createGroup(teamIds, groupName, currentLeague.getId());
        }
	}
    response.sendRedirect("results.jsp");
%>
 