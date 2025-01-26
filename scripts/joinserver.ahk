serverIds := []
joinrandomserver() {
    global serverIds
    if (serverIds.Length > 1) {
        global RandomServer := serverIds.RemoveAt(Random(1, serverIds.Length))
        ; PlayerStatus("GameinstanceID = " RandomServer, "0x1F8B4C", , false, , false)
        run '"roblox://placeId=1537690962&gameInstanceId=' RandomServer '"'        
    } else {
        GetServerIds()
    }

}
GetServerIds(amount := 8) {
    
        global serverIds := []
        cursor := ""
        ratelimit := 45000
        loop amount {
            try {
                url := "https://games.roblox.com/v1/games/1537690962/servers/0?sortOrder=1&excludeFullGames=true&limit=100" (
                    cursor ? "&cursor=" cursor : "")
                req := ComObject("WinHttp.WinHttpRequest.5.1")
                req.open("GET", url, true)
                req.send()
                req.WaitForResponse()
                response := JSON.parse(req.responsetext, true, false)
            } catch Error as e {
                return
            }
            try {
                if (response.errors[1].message == "Too many requests"){
                    PlayerStatus("Waiting for " ratelimit/1000 " seconds. Requests: {" A_Index "/" amount "}",
                    0, ,false , , false)
                    response := JSON.parse(req.responsetext, true, false)
                    Sleep ratelimit
                    ratelimit *= 1.3
                    continue
                }
                PlayerStatus("Error in roblox API [ Code: " response.errors[1].code ", Message: " response.errors[1].message " ]",
                0, , , , false)
                return
            } catch Error as e {
                ratelimit := 45000
                ; this is kinda stupid tbh idk if theres a better way to handle errors like this
            }
        
            cursor := response.nextPageCursor
            data := response.data
            for server in data {
                serverIds.push(server.id)
                if (server.playing == 3){
                    return
                }
            }

        }
}
