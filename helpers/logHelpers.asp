<%
Sub LogLoginAction(username, status, action)
    Dim fs, logFile, logPath, logData
    logPath = Server.MapPath("/MyClassicAspApp/logs/activity.log")
    
    logData = Now() & " | User: " & username & " | Status: " & status & " | Action: " & action & vbCrLf

    On Error Resume Next
    Set fs = Server.CreateObject("Scripting.FileSystemObject")

    If Not fs.FileExists(logPath) Then 
        Set logFile = fs.CreateTextFile(logPath, True)
    Else
        Set logFile = fs.OpenTextFile(logPath, 8, True) 
    End If

    If Not logFile Is Nothing Then
        logFile.Write logData
        logFile.Close
        Set logFile = Nothing
    End If

    Set fs = Nothing
    On Error GoTo 0
End Sub
%>
