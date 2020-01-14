<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="league.*" %>
<%@ include file="setLeague.jsp" %>

<%  User userUpdated = (User) session.getAttribute("userToUpdate");
    if (userUpdated != null && currentUser != null && (currentUser.getId() == userUpdated.getId() || currentUser.isAdmin())) {
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String profilePic = request.getParameter("profile_pic");
        String makeReferee = request.getParameter("toggleReferee");
        String makePoster = request.getParameter("togglePoster");


        if (name == null && surname == null && email == null && phone == null && profilePic == null && makeReferee == null && makePoster == null) {
                response.sendRedirect("home.jsp");
                return;
         }

        if (name != null) {
            userUpdated.setName(name);
        }
        if (surname != null) {
            userUpdated.setSurname(surname);
        }
        if (email != null) {
            userUpdated.setEmail(email);
        }
        if (phone != null) {
            userUpdated.setPhone(phone);
        }
        if (profilePic != null) {
            userUpdated.setProfilePic(profilePic);
        }
        if (makeReferee != null && currentUser.isAdmin()) {
            userUpdated.setReferee(!userUpdated.canReferee());
        }
        if (makePoster != null && currentUser.isAdmin()) {
            userUpdated.setPoster(!userUpdated.canPost());
        }
        
        userUpdated.update();
        session.removeAttribute("userToUpdate");
        response.sendRedirect("profile.jsp?user=" + userUpdated.getId());
        return;
    }
%>