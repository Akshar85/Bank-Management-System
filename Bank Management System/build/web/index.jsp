<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bank Management System</title>
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
    #login-required-message {
      background-color: #f0f0f0;
      padding: 10px;
      margin: 10px;
      border: 1px solid #ddd;
      display: none;
    }
    .login-links {
      margin-top: 20px;
    }
    /* Additional CSS */
    .container {
      max-width: 800px;
      margin: 0 auto;
      padding: 20px;
    }
    .form-group {
      margin-bottom: 15px;
    }
    label {
      display: block;
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
      color: #fff;
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
  <ul class="navbar">
    <li><a href="home.jsp">Home</a></li>
    <li><a href="withdraw.jsp">Withdraw</a></li>
    <li><a href="deposit.jsp">Deposit</a></li>
    <li><a href="transaction.jsp">Transaction</a></li>
    <li><a href="profile.jsp">Profile</a></li>
    <li style="float:right"><a href="logout.jsp">Logout</a></li>
  </ul>

  <div id="login-required-message">
    You need to be logged in to access this feature.
  </div>
   
  <div class="login-links">
      <a href="login.jsp">Login</a> <br><br>
      <a href="registration.jsp">Registration</a>
  </div>

  <%
    // Check if user is logged in
    boolean isLoggedIn = (session.getAttribute("customerId") != null);
  %>

  <script>
    // Add event listener to all navigation links
    const links = document.querySelectorAll('.navbar a');

    <%-- Convert isLoggedIn JSP variable to JavaScript variable --%>
    const isLoggedIn = <%= isLoggedIn %>;

    links.forEach(link => {
      link.addEventListener('click', (e) => {
        if (!isLoggedIn) {
          e.preventDefault(); // Prevent default link behavior
          document.getElementById('login-required-message').style.display = 'block';
        }
      });
    });
  </script>
</body>
</html>