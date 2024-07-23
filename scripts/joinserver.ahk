#Requires AutoHotkey v2
#Include ..\lib\json.ahk


global serverIds := []
global JoinAttempts := 0
joinrandomserver() {
    global JoinAttempts, serverIds
    if (serverIds.Length > 1) {
        
        RandomServer := serverIds[Random(1, serverIds.Length)]
        ; NoIMGPlayerStatus("Picked this server " RandomServer, 0)

        JoinAttempts++
        run '"roblox://placeId=1537690962&gameInstanceId=' RandomServer '"'
    } else {
        GetServerIds()
        PlayerStatus("An error happend in fetching roblox servers", 0, false)
    }

    if (JoinAttempts == 15){
        GetServerIds()
        JoinAttempts := 0
    }

}




GetServerIds() {
    global serverIds
    try {
        serverIds := []
        cursor := ""

        Loop 20 {
            url := "https://games.roblox.com/v1/games/1537690962/servers/0?sortOrder=1&excludeFullGames=true&limit=100" (cursor ? "&cursor=" cursor : "")
            req := ComObject("WinHttp.WinHttpRequest.5.1")
            req.open("GET", url, true)
            req.send()
            req.WaitForResponse()

            response := JSON.parse(req.responsetext, true, false)

            for server in response.data {
                serverIds.push(server.id)
            }

            cursor := response.nextPageCursor
            if !cursor
                break
        }


    } catch Error as e {
        return
    }
}