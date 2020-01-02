<%@ page import="league.League" %>   
   
   <% 
    // Find current league in session or request params
    League currentLeague = (League) session.getAttribute("league");
    if (currentLeague == null) {
      String paramLeague = request.getParameter("league");
      if (paramLeague != null)
        currentLeague = League.getByName(paramLeague);
      // If still not found, go to "Create/Select League" page.
      if (currentLeague == null) { %>
      <%-- <jsp:forward page="createLeague.jsp"/> --%>
      <%
      // Temporarily set Super League as the currentLeague for testing, instead of the forward command above.
      currentLeague = new League(2, "Super League", "https://seeklogo.com/images/G/greece-super-league-logo-19FBE0771B-seeklogo.com.gif");
      %>
      <% }
      session.setAttribute("league", currentLeague);
    }%>