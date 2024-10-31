global serverIds := []
global errorMessage := ""
joinrandomserver() {
    global JoinAttempts, serverIds
    if (serverIds.Length > 1) {
        global RandomServer := serverIds[Random(1, serverIds.Length)]
        JoinAttempts++
        run '"roblox://placeId=1537690962&gameInstanceId=' RandomServer '"'

    } else {
        global errorMessage
        PlayerStatus("Error in roblox API [ Code: " errorMessage.errors[1].code ", Message: " errorMessage.errors[1].message " ]",
            0, , , , false)
        Sleep 5000
    }

}
GetServerIds() {
    try {
        global serverIds := []
        cursor := ""

        loop 2 {
            url := "https://games.roblox.com/v1/games/1537690962/servers/0?sortOrder=1&excludeFullGames=true&limit=100" (
                cursor ? "&cursor=" cursor : "")
            req := ComObject("WinHttp.WinHttpRequest.5.1")
            req.open("GET", url, true)
            req.send()
            req.WaitForResponse()

            response := JSON.parse(req.responsetext, true, false)

            cursor := response.nextPageCursor
            data := response.data
            for server in data {
                serverIds.push(server.id)
            }
        }
    } catch Error {
        response := JSON.parse(req.responsetext, true, false)
        global errorMessage := response
        return
    }

}
