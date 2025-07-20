<%
Function GetConnection()
    Dim connection
    
    Set connection = Server.CreateObject("ADODB.Connection")
    connection.Open "Provider=SQLOLEDB;Data Source=mainuser;Initial Catalog=SimpleDB;User ID=myAsp;Password=myAsp"
    Set GetConnection = connection
End Function
%>