<!--#include virtual="/MyClassicAspApp/helpers/dbHelpers.asp"-->

<%
Function GetUserRoles()
    Dim sql, roles
    sql = "Select Name from UserRoles"
    
    Set roles = GetData(sql, Array())
    Set GetUserRoles = roles
End Function
%>