<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*, java.util.*, java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 100px;
        }
        form {
            margin-top: 20px;
            max-width: 300px;
            margin-left: auto;
            margin-right: auto;
        }
        form div {
            margin-bottom: 10px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        button[type="submit"] {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }
        button[type="submit"]:hover {
            background-color: #0056b3;
        }
        .error-message {
            color: red;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <h2>Login</h2>
    <form method="post" action="login.jsp">
        <div>
            <label for="customer_id">Customer ID:</label>
            <input type="text" id="coustomer_id" name="coustomer_id" required>
        </div>
        <div>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <button type="submit">Login</button>
    </form>

    <%-- Java code to handle form submission --%>
    <%
        // JDBC connection parameters
        String dbUrl = "jdbc:mysql://localhost:3306/akshar";
        String dbUser = "root";
        String dbPassword = "Root";

        Connection connection = null;
        try {
            // Establish connection
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            // Retrieve form data
            String customerId = request.getParameter("coustomer_id");
            String password = request.getParameter("password");
            
            //out.println(customerId+"/n");

            // Check if credentials match database records
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM coustomer_detail WHERE coustomer_id = ? AND password = ?");
            statement.setString(1, customerId);
            statement.setString(2, password);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                // Login successful, set customer ID in session and redirect to profile page
                session.setAttribute("coustomer_id", customerId); // Set customer ID in session
                response.sendRedirect("home.jsp");
            } else {
                // Login failed, display error message
    %>
               
    <%
            }

            statement.close();
        } catch (ClassNotFoundException | SQLException e) {
            //out.println("Error: " + e.getMessage());
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    out.println("Error closing connection: " + e.getMessage());
                }
            }
        }
    %>
</body>
</html>