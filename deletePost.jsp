<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="setLeague.jsp" %>
<%@ page import="league.*"%>
<%
    String postIdParam = request.getParameter("post");
    Integer postId = null;
    try {
        postId = Integer.parseInt(postIdParam);
    } catch (Exception e) {

    }
    if (postId == null) { %>
        <h1>Invalid post</h1>
    <% return;
    }
    Post post = Post.getById(postId, currentLeague.getId());
    boolean canRemove = currentUser != null && (currentUser.getId() == post.getPoster().getId() || currentUser.isAdmin()); %>
    <%if (!canRemove) { %>
        <h1>You cannot remove this post</h1>
    <%return;
    }
    if (!Post.removeById(postId)) { %>
        <h1>Something went wrong</h1>
    <%
    return;
    }
    response.sendRedirect("home.jsp");
    return;
%>