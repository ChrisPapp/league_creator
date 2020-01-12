<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="league.*" %>

<%-- begin html --%>
<!DOCTYPE html>
<html lang="en">
  	<head>
    	<%@ include file="LeagueHeadDefaults.jsp" %>
      <!-- Import the base grid styles -->
      <link rel="stylesheet" type="text/css" href="css/profile.css">
  	</head>
	<%  User user = null;
		String userParam = request.getParameter("user");
		if (userParam == null) {
			user = currentUser;
		} else {
			user = User.getById(Integer.parseInt(userParam));
		}
	%>
  	<body>
		<%@ include file="navbar.jsp" %>
		<div>
			<div id="profile">
		</div>
    </body>
</html>