<!--#include file="db.asp"-->
<%
Function ExecuteQuery(sql, params)
    Dim connection, command, i
    Set connection = GetConnection()
    Set command = Server.CreateObject("ADODB.Command")
    Set command.ActiveConnection = connection

    command.CommandText = sql
    command.CommandType = 1

    if IsArray(params) then
        For i = 0 to UBound(params)
            command.Parameters.Append command.CreateParameter("param" & i, 200, 1, 255, params(i))
        Next
    end if

    command.Execute
    connection.Close
    Set command = Nothing
    Set connection = Nothing
End Function

Function GetData(sql, params)
    Dim connection, command, result, i
    Set connection = GetConnection()
    Set command = Server.CreateObject("ADODB.Command")
    Set command.ActiveConnection = connection

    command.CommandText = sql
    command.CommandType = 1

    if IsArray(params) then
        For i = 0 to UBound(params)
            command.Parameters.Append command.CreateParameter("param" & i, 200, 1, 255, params(i))
        Next
    end if

    Set result = command.Execute
    Set GetData = result
End Function
%>