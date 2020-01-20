<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="league.*" %>
<%@ include file="setLeague.jsp" %>

<%  
    if (currentUser != null && currentUser.isTeamLeader()) {
        String teamName = request.getParameter("teamName");
        String teamLogo = request.getParameter("teamLogo");


        if (teamLogo == null && teamName == null) {
                response.sendRedirect("team.jsp");
                return;
         }

        if (teamName != null) {
            currentUser.getTeam().setName(teamName);
        }
        if (teamLogo != null) {
            currentUser.getTeam().setLogo(teamLogo);
        }
        
        currentUser.getTeam().update();
        response.sendRedirect("team.jsp?team=" + currentUser.getTeam().getId());
        return;
    }
%>