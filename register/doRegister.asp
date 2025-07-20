<!--#include virtual="/MyClassicAspApp/helpers/Crypto.Class.asp"-->
<!--#include virtual="/MyClassicAspApp/helpers/dbHelpers.asp"-->
<!--#include virtual="/MyClassicAspApp/services/userRoleService.asp"-->

<%
Dim username, password, role, roleId

username = Request.Form("username")
password = Request.Form("password")
role = Request.Form("role")

roleId = GetRoleIdByName(role)

set crypt = new crypto
hashedPassword = crypt.hashPassword(password, "SHA256", "b64")

sql = "Insert into Users (Username, Password, RoleId) values (?,?,?)"
params = Array(username, hashedPassword, roleId)

Call ExecuteQuery(sql, params)

Response.Redirect "../login/login.asp"
%>