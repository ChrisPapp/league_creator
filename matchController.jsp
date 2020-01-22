<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="league.*" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.format.DateTimeParseException" %>
<%@ include file="setLeague.jsp" %>

<%  Match match = (Match) session.getAttribute("matchToUpdate");
    if (currentUser != null && currentUser.canReferee()) {
        String homeGoals = request.getParameter("homeGoals");
        String homeYellows = request.getParameter("homeYellows");
        String homeReds = request.getParameter("homeReds");
        String awayGoals = request.getParameter("awayGoals");
        String awayYellows = request.getParameter("awayYellows");
        String awayReds = request.getParameter("awayReds");
        String matchDate = request.getParameter("date");

        if (homeGoals == null && homeYellows == null && homeReds == null && 
            awayGoals == null && awayYellows == null && awayReds == null && matchDate == null){
                response.sendRedirect("results.jsp");
                return;
            }

        if (homeGoals != null) {
            try {
                match.getHomeStats().goalsScored = Integer.parseInt(homeGoals);
            } catch (Exception e) {
                throw e;
            }
        }
        if (homeYellows != null) {
            try {
                match.getHomeStats().yellowCards = Integer.parseInt(homeYellows);
            } catch (Exception e) {
                throw e;
            }
        }
        if (homeReds != null) {
            try {
                match.getHomeStats().redCards = Integer.parseInt(homeReds);
            } catch (Exception e) {
                throw e;
            }
        }
        if (awayGoals != null) {
            try {
                match.getAwayStats().goalsScored = Integer.parseInt(awayGoals);
            } catch (Exception e) {
                throw e;
            }
        }
        if (awayYellows != null) {
            try {
                match.getAwayStats().yellowCards = Integer.parseInt(awayYellows);
            } catch (Exception e) {
                throw e;
            }
        }
        if (awayReds != null) {
            try {
                match.getAwayStats().redCards = Integer.parseInt(awayReds);
            } catch (Exception e) {
                throw e;
            }
        }
        if (matchDate != null) {  
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("d-M-yyyy HH:mm");
            try {
                LocalDateTime dateTime = LocalDateTime.parse(matchDate, formatter);
                match.setMatchDate(dateTime);
            } catch (DateTimeParseException e) { 
                throw e;
            }
        }
        match.update(currentUser.getId());
        session.removeAttribute("matchToUpdate");
        response.sendRedirect("results.jsp");
        return;
    }
%>