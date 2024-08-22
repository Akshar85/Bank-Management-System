<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*, java.util.Date" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <style>
          body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
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
          /* Additional CSS */
          .profile-info {
            background-color: #fff;
            padding: 20px;
            margin: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            max-width: 400px;
            margin: auto;
            text-align: left;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
          }
          .profile-info label {
            font-weight: bold;
            margin-right: 10px;
            color: #333;
          }
          .profile-info div {
            margin-bottom: 10px;
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

  <h2>User Profile</h2>

  <%
      // Retrieve customer ID of the logged-in user from the session
      String customerId = (String)session.getAttribute("coustomer_id");
  %>
  <br>
  <%
      // Check if customer ID is present in the session and not empty
      if (customerId != null && !customerId.isEmpty()) {
          // JDBC connection parameters
          String dbUrl = "jdbc:mysql://localhost:3306/akshar";
          String dbUser = "root";
          String dbPassword = "Root";

          Connection connection = null;
          PreparedStatement statement = null;
          ResultSet resultSet = null;

          try {
              // Establish connection
              Class.forName("com.mysql.cj.jdbc.Driver");
              connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

              // Query to retrieve user information based on customer ID
              statement = connection.prepareStatement("SELECT * FROM coustomer_detail WHERE coustomer_id = ?");
              statement.setString(1, customerId);
              resultSet = statement.executeQuery();

              if (resultSet.next()) {
                  // Retrieve user information from the result set
                  String username = resultSet.getString("name");
                  String address = resultSet.getString("address");
                  String phone = resultSet.getString("phone");
                  String pancard = resultSet.getString("pancard");
                  Date dob = resultSet.getDate("dob");
                  String password = resultSet.getString("password");

                  // Display user information
  %>
                  <div class="profile-info">
                      <div>
                          <label for="name">Name:</label>
                          <%= username %>
                      </div>
                      <div>
                          <label for="address">Address:</label>
                          <%= address %>
                      </div>
                      <div>
                          <label for="phone">Phone:</label>
                          <%= phone %>
                      </div>
                      <div>
                          <label for="pancard">PAN Card:</label>
                          <%= pancard %>
                      </div>
                      <div>
                          <label for="dob">Date of Birth:</label>
                          <%= dob %>
                      </div>
                      <div>
                          <label for="password">Password:</label>
                          <%= password %>
                      </div>
                  </div>
  <%
              } else {
                  // User not found
                  out.println("User not found.");
              }
          } catch (ClassNotFoundException | SQLException e) {
              out.println("Error: " + e.getMessage());
          } finally {
              // Close resources in the finally block
              try {
                  if (resultSet != null) resultSet.close();
                  if (statement != null) statement.close();
                  if (connection != null) connection.close();
              } catch (SQLException e) {
                  out.println("Error closing resources: " + e.getMessage());
              }
          }
      } else {
          // Session error: Customer ID not found in session
          out.println("Session error: Customer ID not found.");
      }
  %>
</body>
</html>