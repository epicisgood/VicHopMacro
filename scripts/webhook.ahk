#Requires AutoHotkey v2.0

global Attempts := 0


PlayerStatus(statusTitle, statusColor, Mentions) {
    try {
        FileExist("ss.jpg") ? FileDelete("ss.jpg") : ""
    } catch Error as e {
        return 0
    }
    
    DiscordUserId := IniRead("settings.ini", "Settings", "discordID")

    pToken := Gdip_Startup()
    hwnd := GetRobloxHWND()
    GetRobloxClientPos(hwnd)


    pBitmap := Gdip_BitmapFromScreen((windowWidth > 0) ? (windowX "|" windowY "|" windowWidth "|" windowHeight) : 0)

    Gdip_SaveBitmapToFile(pBitmap, "ss.jpg")
    
    
    if (Mentions == true) {
        payload_json := '{"content": "<@' DiscordUserId '>", "embeds":[{"title":"' statusTitle '", "color":"' statusColor + 0 '", "image":{"url":"attachment://ss.jpg"}}]}'
        objParam := Map("payload_json", payload_json, "file", ["ss.jpg"])
    }
    else {
        payload_json := '{"embeds":[{"title":"' statusTitle '", "color":"' statusColor + 0 '", "image":{"url":"attachment://ss.jpg"}}]}'
        objParam := Map("payload_json", payload_json, "file", ["ss.jpg"])
    }
    
    Gdip_DisposeImage(pBitmap)
    
    try {
        CreateFormDataClass(&postdata, &hdr_ContentType, objParam)
        webhook := ComObject("WinHttp.WinHttpRequest.5.1")
        webhook.Open("POST", url, true)
        webhook.SetRequestHeader("User-Agent", "AHK")
        webhook.SetRequestHeader("Content-Type", hdr_ContentType)
        webhook.Send(postdata)
        webhook.WaitForResponse()
        
        FileExist("ss.jpg") ? FileDelete("ss.jpg") : ""
    } catch Error as e {
        return
    } 

}


NoIMGPlayerStatus(StatusTitle, statusColor) {
    global Attempts
    if (StatusTitle == 'Searching For Night Servers.'){
        Attempts += 1
        AttemptCount := Attempts
        payload_json := '{"embeds":[{"title":"' statusTitle " " AttemptCount "x" '", "color":"' statusColor + 0 '"}]}'
    } else {
        payload_json := '{"embeds":[{"title":"' statusTitle '", "color":"' statusColor + 0 '"}]}'
    }
    try {
        WebRequest := ComObject("WinHttp.WinHttpRequest.5.1")
        WebRequest.Open("POST", url, false)
        WebRequest.SetRequestHeader("Content-Type", "application/json")
        WebRequest.Send(payload_json)
        
    } catch Error as e {
        return
    }


}