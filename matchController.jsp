<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="league.*" %>
<%@ include file="setLeague.jsp" %>

<%  Match match = (Match) session.getAttribute("matchToUpdate");
    if (currentUser != null && currentUser.canReferee()) {
        String homeGoals = request.getParameter("homeGoals");
        String homeYellows = request.getParameter("homeYellows");
        String homeReds = request.getParameter("homeReds");
        String awayGoals = request.getParameter("awayGoals");
        String awayYellows = request.getParameter("awayYellows");
        String awayReds = request.getParameter("awayReds");

        if (homeGoals != null) {
            try {
                match.getHomeStats().goalsScored = Integer.parseInt(homeGoals);
            } catch (Exception e) {
                // Ignored, referee should be careful.
            }
        }
        if (homeYellows != null) {
            try {
                match.getHomeStats().yellowCards = Integer.parseInt(homeYellows);
            } catch (Exception e) {
                // Ignored, referee should be careful.
            }
        }
        if (homeReds != null) {
            try {
                match.getHomeStats().redCards = Integer.parseInt(homeReds);
            } catch (Exception e) {
                // Ignored, referee should be careful.
            }
        }
        if (awayGoals != null) {
            try {
                match.getAwayStats().goalsScored = Integer.parseInt(awayGoals);
            } catch (Exception e) {
                // Ignored, referee should be careful.
            }
        }
        if (awayYellows != null) {
            try {
                match.getAwayStats().yellowCards = Integer.parseInt(awayYellows);
            } catch (Exception e) {
                // Ignored, referee should be careful.
            }
        }
        if (awayReds != null) {
            try {
                match.getAwayStats().redCards = Integer.parseInt(awayReds);
            } catch (Exception e) {
                // Ignored, referee should be careful.
            }
        }
        match.update(currentUser.getId());
    }
%>

<jsp:forward page="match.jsp"/>