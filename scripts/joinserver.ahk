#Requires AutoHotkey v2
#Include ..\lib\json.ahk

joinrandomserver() {
    try {
        req := ComObject("WinHTTP.WinHTTPRequest.5.1")
        serverIds := []
        cursor := ""

        Loop 10 {
            url := "https://games.roblox.com/v1/games/1537690962/servers/0?sortOrder=1&excludeFullGames=true&limit=100" (cursor ? "&cursor=" cursor : "")
            req.open("GET", url, true)
            req.send()
            req.WaitForResponse()

            response := JSON.parse(req.responsetext, true, false)

            for server in response.data {
                serverIds.push(server.id)
            }

            cursor := response.nextPageCursor
            if !cursor
                break ;; this is never gonna happen fr
        }

        RandomServer := serverIds[Random(1, 1000)]

        run "roblox://placeId=1537690962&gameInstanceId=" RandomServer

    } catch Error as e {
        return
    }
}
