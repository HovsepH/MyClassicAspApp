<!--#include virtual="/MyClassicAspApp/helpers/logHelpers.asp" -->

<% 
Dim username 
username = Request.Cookies("username")

LogLoginAction username, "SUCCESS", "Logout"

Response.Cookies("username") = ""
Response.Cookies("username").Expires = DateAdd("d", -1, Now)
Response.Redirect "../index.asp"
%> 