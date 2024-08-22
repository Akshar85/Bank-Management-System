<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Transactions</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 100px;
        }
        .navbar {
            list-style: none;
            margin: 0;
            padding: 0;
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
        .transaction-form {
            margin-top: 20px;
            max-width: 300px;
            margin-left: auto;
            margin-right: auto;
        }
        .transaction-form label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .transaction-form input[type="text"],
        .transaction-form input[type="number"],
        .transaction-form input[type="password"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .transaction-form button[type="submit"] {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }
        .transaction-form button[type="submit"]:hover {
            background-color: #0056b3;
        }
        .error-message {
            color: red;
            margin-top: 10px;
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
    <h2>Transactions</h2>

    <div class="transaction-form">
        <form method="post" action="transaction.jsp">
            <label for="recipient-id">Recipient's Customer ID:</label>
            <input type="text" id="recipient-id" name="recipient-id" required>
            <label for="amount">Amount:</label>
            <input type="number" id="amount" name="amount" required>
            <label for="password">Your Password:</label>
            <input type="password" id="password" name="password" required>
            <button type="submit">Submit</button>
        </form>
    </div>

    <% 
        if (request.getMethod().equals("POST")) {
            // Process transaction if form submitted
            String senderCustomerId = (String) session.getAttribute("coustomer_id");
            String recipientCustomerId = request.getParameter("recipient-id");
            double amount = Double.parseDouble(request.getParameter("amount"));
            String password = request.getParameter("password");

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

                // Validate sender's password
                statement = connection.prepareStatement("SELECT password FROM coustomer_detail WHERE coustomer_id = ?");
                statement.setString(1, senderCustomerId);
                resultSet = statement.executeQuery();

                if (resultSet.next()) {
                    String storedPassword = resultSet.getString("password");
                    if (password.equals(storedPassword)) {
                        // Password matched, check sender's balance
                        statement = connection.prepareStatement("SELECT balance FROM customer_balance WHERE coustomer_id = ?");
                        statement.setString(1, senderCustomerId);
                        resultSet = statement.executeQuery();

                        if (resultSet.next()) {
                            double senderBalance = resultSet.getDouble("balance");
                            if (senderBalance >= amount) {
                                // Sufficient balance, proceed with transaction
                                // Insert transaction record
                                statement = connection.prepareStatement("INSERT INTO `transaction` (coustomer_id, amount, transaction_type) VALUES (?, ?, 'Withdrawal')");
                                statement.setString(1, senderCustomerId);
                                statement.setDouble(2, amount);
                                statement.executeUpdate();
                                statement.close();
                                
                                statement = connection.prepareStatement("INSERT INTO `transaction` (coustomer_id, amount, transaction_type) VALUES (?, ?, 'Deposit')");
                                statement.setString(1, recipientCustomerId);
                                statement.setDouble(2, amount);
                                statement.executeUpdate();
                                statement.close();
                                
                                // Update sender's balance
                                statement = connection.prepareStatement("UPDATE customer_balance SET balance = balance - ? WHERE coustomer_id = ?");
                                statement.setDouble(1, amount);
                                statement.setString(2, senderCustomerId);
                                statement.executeUpdate();
                                statement.close();
                                
                                // Update recipient's balance
                                statement = connection.prepareStatement("UPDATE customer_balance SET balance = balance + ? WHERE coustomer_id = ?");
                                statement.setDouble(1, amount);
                                statement.setString(2, recipientCustomerId);
                                statement.executeUpdate();
                                
                                out.println("Transaction successful.");
                            } else {
                                // Insufficient balance
                                out.println("Error: You do not have sufficient balance for this transaction.");
                            }
                        } else {
                            // Balance not found for sender
                            out.println("Error: Balance not found for sender.");
                        }
                    } else {
                        // Incorrect password
                        out.println("Error: Incorrect password.");
                    }
                } else {
                    // Sender not found
                    out.println("Error: Sender not found.");
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
        }
    %>
</body>
</html>