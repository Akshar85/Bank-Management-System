<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Logout</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 100px;
        }
        h2 {
            color: #007bff;
        }
        p {
            margin-bottom: 20px;
        }
        a {
            text-decoration: none;
            color: #007bff;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h2>Logout</h2>

    <%
        // Invalidate the session
        session.invalidate();
    %>

    <p>You have been logged out successfully.</p>
    <p><a href="login.jsp">Login Again</a></p>
    <br>
     <p>OR</p>
     <br>
    <p>You want to register new user </p>
    <p><a href="registration.jsp">Register</a></p>
    
</body>
</html>