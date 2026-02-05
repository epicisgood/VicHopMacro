serverIds := []
JoinSeverProcesId := ''

joinrandomserver() {
    global serverIds, JoinSeverProcesId
    file := A_ScriptDir "\serverlist.txt"

    if FileExist(file) {
        serverIds := []
        for line in StrSplit(FileRead(file), "`n") {
            if line := Trim(line)
                serverIds.Push(line)
        }
        FileDelete file
        try WinClose "ahk_class AutoHotkey ahk_pid " JoinSeverProcesId.pid
        PlayerStatus("Found " serverIds.Length " Server Id's" ,0,,false,,false)
    }
    
    if (serverIds.Length > 1) {
        RandomServer := serverIds.RemoveAt(Random(1, serverIds.Length))
        Run 'roblox://placeId=1537690962&gameInstanceId=' RandomServer
        return true
    }

    if FileExist(A_ScriptDir "\pendingserverlist.txt") {
        PlayerStatus("Waiting for New Server Id's..." ,0,,false,,false)
        while (!FileExist(file)){
            Sleep(100)
        }        
    } else {
        GetServerIds(8)
        CloseRoblox()
    }   

    return false
}

GetServerIds(amount) {
    global serverIds
    PlayerStatus("Getting New Server Id's" ,0,,false,,false)
    script := 
    (
        '
        
    #Requires AutoHotkey v2.0
    #Include %A_ScriptDir%\lib\json.ahk
    cursor := ""
    ratelimit := 45000
    loop ' amount ' {
        try {
            url := "https://games.roblox.com/v1/games/1537690962/servers/0?sortOrder=1&excludeFullGames=true&limit=100" (
                cursor ? "&cursor=" cursor : "")
            req := ComObject("WinHttp.WinHttpRequest.5.1")
            req.open("GET", url, true)
            req.send()
            req.WaitForResponse()
            response := JSON.parse(req.responsetext, true, false)
        } catch Error as e {
            break
        }
        try {
            if (response.errors[1].message == "Too many requests"){
                ; PlayerStatus("Waiting for " ratelimit/1000 " seconds. Requests: {" A_Index "/" amount "}",0,,false,,false)
                response := JSON.parse(req.responsetext, true, false)
                Sleep ratelimit
                ratelimit *= 1.3
                continue
            }
            ; PlayerStatus("Error in roblox API [ Code: " response.errors[1].code ", Message: " response.errors[1].message " ]",0,,,,false)
            break
        } catch {
            ratelimit := 45000
        }
        try {
            cursor := response.nextPageCursor
            for server in response.data {
                FileAppend server.id . Chr(13) . Chr(10), A_ScriptDir "\pendingserverlist.txt"
                if (server.playing == 3)
                    break
            }
        } catch {
            break
        }
    }
    try FileCopy(A_ScriptDir "\pendingserverlist.txt", A_ScriptDir "\serverlist.txt", true)
    try FileDelete(A_ScriptDir "\pendingserverlist.txt")
    '
    )
    

    shell := ComObject("WScript.Shell")
    exec := shell.Exec('"' A_AhkPath '" /script /force *')
    global JoinSeverProcesId := exec.ProcessID
    exec.StdIn.Write(script)
    exec.StdIn.Close()

    
    Sleep(3000)
}


