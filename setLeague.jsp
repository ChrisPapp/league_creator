<%@ page import="league.League" %>
<%@ page import="league.User" %>
   
   <% 
    // Set currentUser variable. Temporary hardcode user for testing...
    User currentUser =  (User) session.getAttribute("user");
    if (currentUser == null) {
      currentUser = new User(1, "Chris", "Pappas", "chrispappas99@yahoo.gr", "chrispappas", "1234", true);
    }
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