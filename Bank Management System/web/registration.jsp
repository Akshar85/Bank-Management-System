<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bank Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 100px;
        }
        .container {
            max-width: 400px;
            margin: 0 auto;
        }
        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        input[type="text"],
        input[type="password"],
        input[type="number"],
        input[type="date"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        #passwordError {
            color: red;
            display: none;
        }
    </style>
</head>
<body>
<header>
    <!-- Your header code here -->
</header>

<div class="container">
    <h2>Registration</h2>
    <form method="post" onsubmit="return validateForm()">
        <div class="form-group">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>
        </div>
        <div class="form-group">
            <label for="address">Address:</label>
            <input type="text" id="address" name="address" required>
        </div>
        <div class="form-group">
            <label for="phone">Phone:</label>
            <input type="number" id="phone" name="phone" required>
        </div>
        <div class="form-group">
            <label for="pancard">PAN Card:</label>
            <input type="text" id="pancard" name="pancard" required>
        </div>
        <div class="form-group">
            <label for="dob">Date of Birth:</label>
            <input type="date" id="dob" name="dob" required>
        </div>
        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="form-group">
            <label for="repassword">Re-enter Password:</label>
            <input type="password" id="repassword" name="repassword" required>
            <span id="passwordError">Passwords don't match</span>
        </div>
        <input type="submit" value="Submit">
    </form>
</div>

<script>
    function validateForm() {
        var password = document.getElementById("password").value;
        var repassword = document.getElementById("repassword").value;

        if (password !== repassword) {
            document.getElementById("passwordError").style.display = "block";
            return false;
        }
        return true;
    }
</script>

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
    String username = request.getParameter("name");
    String address = request.getParameter("address");
    String phone = request.getParameter("phone");
    String pancard = request.getParameter("pancard");
    String dob = request.getParameter("dob");
    String password = request.getParameter("password");

    // Check if passwords match
    String repassword = request.getParameter("repassword");

    if (!password.equals(repassword)) {
        out.println("Passwords don't match");
        return; // Stop execution if passwords don't match
    }

    // Generate unique customer_id
    PreparedStatement maxIdStatement = connection.prepareStatement("SELECT MAX(coustomer_id) AS max_id FROM coustomer_detail");
    ResultSet resultSet = maxIdStatement.executeQuery();
    int maxId = 0;
    if (resultSet.next()) {
        maxId = resultSet.getInt("max_id");
    }
    maxIdStatement.close();
    int newCustomerId = maxId + 1;

    // Check if 'password' column exists in the table
    DatabaseMetaData metaData = connection.getMetaData();
    ResultSet columnResultSet = metaData.getColumns(null, null, "coustomer_detail", "password");

    if (!columnResultSet.next()) {
        // 'password' column doesn't exist, add it to the table
        Statement addColumnStatement = connection.createStatement();
        addColumnStatement.executeUpdate("ALTER TABLE coustomer_detail ADD COLUMN password VARCHAR(255)");
        addColumnStatement.close();
    }

    // Insert data into the database
    PreparedStatement statement = connection.prepareStatement("INSERT INTO coustomer_detail (coustomer_id, name, address, phone, pancard, dob, password) VALUES (?, ?, ?, ?, ?, ?, ?)");
    statement.setInt(1, newCustomerId);
    statement.setString(2, username);
    statement.setString(3, address);
    statement.setString(4, phone);
    statement.setString(5, pancard);
    statement.setString(6, dob);
    statement.setString(7, password);
    statement.executeUpdate();
    statement.close();
    
    if (newCustomerId != -1) {
            PreparedStatement balanceStatement = connection.prepareStatement("INSERT INTO customer_balance (coustomer_id, balance) VALUES (?, ?)");
            balanceStatement.setInt(1, newCustomerId);
            balanceStatement.setDouble(2, 0.0); // Set initial balance to 0
            balanceStatement.executeUpdate();
            balanceStatement.close();
    }

    // Redirect to login.jsp after successful registration
    response.sendRedirect("login.jsp");
} catch (Exception e) {
    out.println("Error: " + e.getMessage());
} finally {
    if (connection != null) {
        try {
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
%>
</body>
</html>