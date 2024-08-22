<%-- 
    Document   : home
    Created on : Apr 20, 2024, 10:58:00 PM
    Author     : Akshar
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Bank Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        .navbar {
            list-style: none;
            margin: 0;
            padding: 10px;
            background-color: #f8f9fa;
            overflow: hidden;
            border-bottom: 1px solid #ccc;
        }
        .navbar li {
            display: inline-block;
            padding: 10px;
        }
        .navbar a {
            text-decoration: none;
            color: #333;
        }
        .navbar a:hover {
            color: #007bff;
        }
        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #f0f0f0;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <ul class="navbar">
        <li><a href="home.jsp">Home</a></li>
        <li><a href="withdraw.jsp">Withdraw</a></li>
        <li><a href="deposit.jsp">Deposit</a></li>
        <li><a href="transaction.jsp">Transaction</a></li>
        <li><a href="profile.jsp">Profile</a></li>
        <li style="float:right"><a href="logout.jsp">Logout</a></li>
    </ul>

    <div class="container">
        <h2>Welcome to Our Bank Management System</h2>
        <p>This bank management system allows you to perform various banking operations conveniently online. You can:</p>
        <ul>
            <li>Withdraw money from your account</li>
            <li>Deposit money into your account</li>
            <li>View your transaction history</li>
            <li>Update your profile information</li>
        </ul>
        <p>Explore the links in the navigation bar to get started.</p>
    </div>
</body>
</html>