<html>
<head>
    <title>Weather</title>
    <link rel="stylesheet" href="css/weather.css">
</head>
<body>
    <div class="container">
        <h2>Check Weather</h2>
        <form method="get" action="weather.asp">
            <label for="city">City:</label>
            <input type="text" name="city" id="city" required>
            
            <label for="days">Forecast Days (1-14):</label>
            <input type="number" name="days" id="days" min="1" max="14" value="1">

            <input type="submit" value="Get Weather">
        </form>

        <%
        Dim city, days, url
        city = Request.QueryString("city")
        days = Request.QueryString("days")
        url = "http://api.weatherapi.com/v1/forecast.json?key=8e76a50efb3a4447a0a195632242309&q=" & city & "&days=" & days

        if city <> "" then
            Dim http, response, status, tempC, condition, icon, errorCode, errorMessage

            Set http = Server.CreateObject("MSXML2.XMLHTTP")
            http.Open "Get", url, False
            http.Send
            response = http.responseText
            status = http.Status
            Set http = Nothing

            If status <> 200 Then
                 errorCode = Mid(response, InStr(response, """code"":") + 7)
                errorCode = Left(errorCode, InStr(errorCode, ",") - 1)

                errorMessage = Mid(response, InStr(response, """message"":""") + 11)
                errorMessage = Left(errorMessage, InStr(errorMessage, """") - 1)

                Response.Write "<div class='error'>"
                Response.Write "<h3>Weather API Error</h3>"
                Response.Write "<p><strong>Code:</strong> " & errorCode & "</p>"
                Response.Write "<p><strong>Message:</strong> " & errorMessage & "</p>"
                Response.Write "</div>"
            Else
                tempC = Mid(response, InStr(response, """temp_c"":") + 9)
                tempC = Left(tempC, InStr(tempC, ",") - 1)

                 condition = Mid(response, InStr(response, """text"":""") + 8)
                condition = Left(condition, InStr(condition, """") - 1)

                icon = Mid(response, InStr(response, """icon"":""") + 8)
                icon = Left(icon, InStr(icon, """") - 1)

                Response.Write "<div class='weather-result'>"
                Response.Write "<h3>Weather in " & city & ":</h3>"
                Response.Write "<p><strong>Temperature:</strong> " & tempC & "°C</p>"
                Response.Write "<p><strong>Condition:</strong> " & condition & "</p>"
                Response.Write "<img src='https:" & icon & "' alt='Weather Icon'>"
                Response.Write "</div>"
            End If
        Else
            Response.Write "<p class='error'>Please enter both city and days.</p>"
        end if
        %>
    </div>
</body>
</html>
