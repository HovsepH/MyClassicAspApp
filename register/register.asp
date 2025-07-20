<!--#include virtual="/MyClassicAspApp/services/userService.asp"-->

<%
Dim roles
Set roles = GetUserRoles()
%>

<html>
<head>
    <link rel="stylesheet" href="../css/style.css">
    <title>Register</title>
</head>
<body>
    <h2>Register Page</h2>
    <form action="./doRegister.asp" method="post">
        Username: <input type="text" name="username"> <br/>
        Password: <input type="password" name="password"><br/>

        <label for="role">Role:</label>
        <select name="role" id="role">
            <option value="">Select Role </option>
            <%
                Do Until roles.EOF
                    Response.Write "<option value='" & roles("Name") & "'>" & roles("Name") & "</option>"
                    roles.MoveNext
                Loop

                roles.Close
                Set roles = Nothing
            %>
        </select>
       
        <input type="submit" value="Register">
    </form>
</body>
</html>