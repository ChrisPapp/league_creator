<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="league.*" %>
<%@ include file="setLeague.jsp" %>

<%  
    String userParam = request.getParameter("user");
    String teamParam = request.getParameter("team");
    request.removeAttribute("team");
    String link = "profile.jsp";


    if (currentUser == null) { %>
            <jsp:forward page="login.jsp"/>
    <% } %>
    <%
    if (userParam == null) { %>
            <jsp:forward page="profile.jsp"/>
    <% } %>

<%
    Integer teamId = null;
    Integer userId = null;

    try {
        userId = Integer.parseInt(userParam);
        if (teamParam != null){
            teamId = Integer.parseInt(teamParam);
        }
        // To avoid tricks, we have to ensure that the target has is not in another Team.
        // Or if the target is the one who made the request, then we can only allow to clear his team and not join any team
        if (currentUser.getId() == userId) {
            if (teamId == null && !currentUser.isTeamLeader()) { // We don't want to leave a team without a leader
                currentUser.updateTeam(null);
                currentUser.setTeam(null);
            }
        } else {
            User user = User.getById(userId, currentLeague.getId());
            if (currentUser.isTeamLeader() && user.getTeam() == null) {
                user.updateTeam(teamId);
            }
        }
    } catch (Exception e) {
    }
%>
<jsp:forward page="profile.jsp"/>
