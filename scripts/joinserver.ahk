#Requires AutoHotkey v2

#Include ..\lib\json.ahk
#Include ..\lib\WinHTTPRequest.ahk


joinrandomserver() {

    req := WinHTTPRequest("Get", "https://games.roblox.com/v1/games/1537690962/servers/0?sortOrder=1&excludeFullGames=true&limit=100")

    req.Send()
    req.WaitForResponse()
    response := req.ParseResponse()

    RandomServer := response.data[Random(1,100)].id

    run "roblox://placeId=1537690962&gameInstanceId=" RandomServer

}




