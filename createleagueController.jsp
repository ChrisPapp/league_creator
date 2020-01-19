<!DOCTYPE html>

<!-- @author ΣΙΜΙΤΖΗ ΙΩΑΝΝΑ 8170117 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="league.*"%>

<%
 String leaguename = request.getParameter("leagueName"); 
 String logopath = request.getParameter("logoPath"); 
 
 String name = request.getParameter("Name");

 String surname = request.getParameter("Surname");

 String email = request.getParameter("Email");

 String username = request.getParameter("Username");

 String password = request.getParameter("Password");

 String confirm = request.getParameter("Confirm");
 
 String phone = request.getParameter("Phone");
 
 String profilePic = request.getParameter("Picture");

if (leaguename == null || username == null ||(
	name == null && surname == null && email == null &&
	username == null && password == null && phone == null && profilePic == null)) {
		response.sendRedirect("createLeague.jsp");
		return;
}
 if ( confirm.equals(password) ){
 	
 	League league = new League( -1, leaguename, logopath);
	User user = new User(-1, name, surname, email, username, phone, profilePic, true, true, true, -1, null);
	try {
		League.createLeagueAndAdmin(league, user, password);
		session.setAttribute("user", user);
		session.setAttribute("league", league);
		response.sendRedirect("home.jsp");
	} catch (Exception e) {
		throw e;
	}
 }
%>
 
 
 