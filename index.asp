<%@ Language="VBScript" %>
<%@ LCID=1033 %>

<% 
dim username, userRole
username= Request.Cookies("username")
userRole = Request.Cookies("role")
%>

<html>
    <head>
        <link rel="stylesheet" href="./css/style.css">
        <title>Home</title>
    </head>
    <body>

    <% if username <> "" then %>
        <h2>Welcome <%= username %> </h2>
        <h3>User Role: <%= userRole %></h3>

        <form action="logout/logout.asp" method="post">
            <input type="submit" value="Logout">
        </form>

        <form action="weather.asp" method="get">
            <input type="submit" value="Check weather">
        </form>
    <% Else %>
        <h2>Welcome to My Classic ASP Project</h2>
        
        <form action="login/login.asp" method="get">
            <input type="submit" value="Login">
        </form>

        <form action="register/register.asp" method="get">
            <input type="submit" value="Register">
        </form>
    <% end if %>
    </body>
<html>