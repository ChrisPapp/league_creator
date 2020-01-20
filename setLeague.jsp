<%@ page import="league.League" %>
<%@ page import="league.User" %>
   
   <% 
    // Set currentUser variable. Temporary hardcode user for testing...
    User currentUser =  (User) session.getAttribute("user");
    
    // First try to get League from params
    League currentLeague;
    String paramLeague = request.getParameter("league");
    if (paramLeague != null) {
      currentLeague = League.getByName(paramLeague);
      session.setAttribute("league", currentLeague);
    } else {
    // Find current league in session
      currentLeague = (League) session.getAttribute("league");
      if (currentLeague == null) {
        // If still not found, go to "Choose League" page.
        if (currentLeague == null) {
          response.sendRedirect("chooseLeague.jsp");
          return;
        }
        session.setAttribute("league", currentLeague);
      }
    
    // Make sure the user is in the current league
    if (currentUser != null && currentUser.getLeagueid() != currentLeague.getId()) {
      currentUser = null;
      session.removeAttribute("user");
    }
    }%>