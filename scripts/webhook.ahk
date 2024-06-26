#Requires AutoHotkey v2.0
SetWorkingDir A_ScriptDir


#Include "..\lib"
#Include json.ahk
#Include WinHTTPRequest.ahk
#Include Gdip_All.ahk
#Include FormData.ahk




global Attempts := 0


PlayerStatus(statusTitle, statusColor, Mentions) {
    url := IniRead("settings.ini", "Settings", "url")
    DiscordUserId := IniRead("settings.ini", "Settings", "discordID")

    pToken := Gdip_Startup()

    hwnd := GetRobloxHWND()

    GetRobloxClientPos(hwnd)

    pBitmap := Gdip_BitmapFromScreen((windowWidth > 0) ? (windowX "|" windowY "|" windowWidth "|" windowHeight) : 0)

    Gdip_SaveBitmapToFile(pBitmap, "ss.jpg")

    gdip_disposeimage(pBitmap)


    if (Mentions == true) {
        payload_json := '{"content": "<@' DiscordUserId '>", "embeds":[{"title":"' statusTitle '", "color":"' statusColor + 0 '", "image":{"url":"attachment://ss.jpg"}}]}'
    }
    else {
        payload_json := '{"embeds":[{"title":"' statusTitle '", "color":"' statusColor + 0 '", "image":{"url":"attachment://ss.jpg"}}]}'
    }

    objParam := Map("payload_json", payload_json, "file", ["ss.jpg"])
    
    try {
        CreateFormDataClass(&postdata, &hdr_ContentType, objParam)
        webhook := ComObject("WinHttp.WinHttpRequest.5.1")
        webhook.Open("POST", url, true)
        webhook.SetRequestHeader("User-Agent", "AHK")
        webhook.SetRequestHeader("Content-Type", hdr_ContentType)
        webhook.Send(postdata)
        webhook.WaitForResponse()

    } catch Error as e {
        return
    } finally {
        FileExist("ss.jpg") ? FileDelete("ss.jpg") : ""
        Gdip_Shutdown(pToken)
        global Attempts := 0
    }

}


NoIMGPlayerStatus(StatusTitle, statusColor) {
    global Attempts
    try {
        Attempts += 1
        AttemptCount := Attempts
        url := IniRead("settings.ini", "Settings", "url")
        payload_json := '{"embeds":[{"title":"' statusTitle " " AttemptCount "x" '", "color":"' statusColor + 0 '"}]}'
    
        WebRequest := ComObject("WinHttp.WinHttpRequest.5.1")
        WebRequest.Open("POST", url, false)
        WebRequest.SetRequestHeader("Content-Type", "application/json")
        WebRequest.Send(payload_json)
        
    } catch Error as e {
        return
    }


}