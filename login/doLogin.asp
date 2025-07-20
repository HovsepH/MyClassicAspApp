<!--#include virtual="/MyClassicAspApp/helpers/dbHelpers.asp"-->
<!--#include virtual="/MyClassicAspApp/helpers/Crypto.Class.asp"-->
<!--#include virtual="/MyClassicAspApp/helpers/logHelpers.asp" -->
<!--#include virtual="/MyClassicAspApp/services/userRoleService.asp"-->
<!--#include virtual="/MyClassicAspApp/services/userService.asp"-->

<%
Function IsInputValid(username, password)
    IsInputValid = (username <> "" and password <> "")
End Function

Function HashPassword(password)
    Dim crypt
    Set crypt = new crypto
    HashPassword = crypt.hashPassword(password, "SHA256", "b64")
    set crypt = Nothing
End Function

Function AuthenticateUser(username, hashedPassword)
    Dim sql, params, user
    sql = "Select Top 1 * from Users where Username = ? and Password = ?"
    Set user = GetData(sql, Array(username, hashedPassword))

    if user.EOF then
        set AuthenticateUser = Nothing
        user.Close
        set user = Nothing
    Else
        set AuthenticateUser = user
    end if
End Function

Function SetAuthCookies(username)
    Dim role
    role = GetRoleByUserName(username)
    Response.Cookies("role") = role
    Response.Cookies("username") = username
    Response.Cookies("username").Expires = DateAdd("d", 1, Now)
End Function

sub ProcessLogin()
    Dim username, password, hashedPassword, user
    username = Request.Form("username")
    password = Request.Form("password")

    If not IsInputValid(username, password) Then
        Response.Write "<h3>Please enter both username and password</h3>"
        Response.End
    End If

    hashedPassword = HashPassword(password)

    Set user = AuthenticateUser(username, hashedPassword)

    if not user is Nothing then
        SetAuthCookies(username)
        LogLoginAction username, "SUCCESS", "Login"
        Response.Redirect "../index.asp"
        user.Close
        Set user = Nothing
    else 
        LogLoginAction username, "FAILED", "Login"
        Response.Write("<h3>Login failed</h3>")
        Response.Write("<a href='login.asp'>Try again</a>")
    end if
end sub

ProcessLogin()
%>