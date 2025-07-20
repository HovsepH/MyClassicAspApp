<!--#include virtual="/MyClassicAspApp/helpers/dbHelpers.asp"-->

<%
Function GetRoleIdByName(name)
    Dim id, sql, rs

    sql = "Select Top 1 Id from UserRoles where Name = ?"

    Set rs = GetData(sql, Array(name))
    
    if not rs.EOF then 
        id = rs("Id")
    Else
        Err.Raise vbObjectError + 513, "GetRoleIdByName", "Role not found for name: " & name
    end if

    rs.Close
    Set rs = Nothing

    GetRoleIdByName = id
End Function

Function GetRoleByUserName(userName)
    Dim sql, rs

    sql = "Select Top 1 UserRoles.Name from UserRoles " & _
    "join Users on Users.RoleId = UserRoles.Id " & _ 
    "where Users.Username = ?"

    Set rs = GetData(sql, Array(userName))
    
    if not rs.EOF then 
        GetRoleByUserName = rs("Name")
    Else
        Err.Raise vbObjectError + 513, "GetRoleByUserName", "Role not found for user: " & userName
    end if

    rs.Close
    Set rs = Nothing
End Function
%>