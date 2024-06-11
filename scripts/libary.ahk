#NoEnv 
CoordMode, Pixel, Screen 

global current_hive := 1

StartServer() {
    global current_hive
    WinActivate, ahk_class WINDOWSCLIENT ahk_exe RobloxPlayerBeta.exe
    Sleep, 200
    Send, .
    Sleep, 300
    Send, {w down}
    Sleep, 100
    Send, {w up}
    Send, {w down}
    Sleep, 4900
    Send, {w up}
    Send, ,
    Send, {s down}
    Sleep, 500
    Send, {s up}
    current_hive := FindHiveSlot()
    if current_hive {
        ResetCharacter()
    }
}

DetectLoading(loadingColor, timeout) {
    startTime := A_TickCount
    loop {
        PixelGetColor, color, 458, 151, RGB
        if (color = loadingColor) {
            break
        }
        if (A_TickCount - startTime >= timeout) {
            return false ; Timeout reached
        }
        Sleep, 100
    }

    startTime := A_TickCount
    loop {
        PixelGetColor, color, 458, 151, RGB
        if (color != loadingColor) {
            break
        }
        Sleep, 100
    }

    return true ; Loading success
}

ZoomOut() {
    Loop, 5 {
        Send, {o down}
        Sleep, 100
        Send, {o up}
    }
}

CheckUp(){
    WinActivate, ahk_class WINDOWSCLIENT ahk_exe RobloxPlayerBeta.exe
    SendMode, Event
    Sleep, 500
    MouseMove, 100, 100
    Sleep, 500
    MouseClickDrag, middle, 300, 302, 300, 300
    Sleep, 500
}

CheckForNight() {
    WinActivate, ahk_class WINDOWSCLIENT ahk_exe RobloxPlayerBeta.exe
    WinGetPos, x, y, width, height, ahk_class WINDOWSCLIENT ahk_exe RobloxPlayerBeta.exe
    centerX := x + (width // 2)
    PixelGetColor, color, centerX, 150 
    return color
}

FindHiveSlot() {
    global current_hive
    Sleep, 300
    Send, {a down}
    Sleep, 400
    Send, {a up}
    Sleep, 300
    current_hive := 1
    if ClaimHive(current_hive) {
        return current_hive
    }
    Loop, 5 {
        Send, {a down}
        Sleep, 1100
        Send, {a up}
        Sleep, 1100
        current_hive++
        if ClaimHive(current_hive) {
            return current_hive
        }
    }
    return 0
}

ClaimHive(current_hive) {
    ImagePath := "img/Hive.png"
    WinGet, RobloxWindowID, ID, ahk_class WINDOWSCLIENT

    if (RobloxWindowID) {
        WinGetPos, RobloxX, RobloxY, RobloxWidth, RobloxHeight, ahk_id %RobloxWindowID%
        Sleep, 1000

        ImageSearch, FoundX, FoundY, RobloxX, RobloxY, RobloxX + RobloxWidth, RobloxY + RobloxHeight, *32 %ImagePath%

        if (ErrorLevel = 0) {
            Send {e down}
            Sleep, 200
            Send {e up}
            return current_hive
        } else {
            return 0
        }
    } else {
        return 0
    }
}

ResetCharacter() {
    Send, {Esc down}
    Sleep, 100
    Send, {Esc up}
    Sleep, 100
    Send, {r down}
    Sleep, 100
    Send, {r up}
    Sleep, 100
    Send, {Enter down}
    Sleep, 100
    Send, {Enter up}
    Sleep, 10000
    Loop, 5 {
        Send, {i down}
        Sleep, 100
        Send, {i up}
    }
    if (SearchWhereSpawned() == 0xFFFFFF || SearchWhereSpawned() == 0xF6F6F5 || SearchWhereSpawned() == 0x9F9F9F) {
        ZoomOut()
        Send, {w down}
        Sleep, 500
        Send, {w up}
        Sleep, 50
        Send, {s down}
        Sleep, 150
        Send, {s up}
        GoToRamp()
    } else {
        ResetCharacter()
        return

    }
}

SearchWhereSpawned() {
    WinActivate, ahk_class WINDOWSCLIENT ahk_exe RobloxPlayerBeta.exe
    PixelGetColor, color, 1300, 850, RGB
    MouseMove, 1300, 850
    MsgBox, %color%
    return color
}

GoToRamp() {
    global current_hive
    Sleep, 50
    Send, {d down}
    Sleep, 1000 * current_hive 
    Send, {d up}
    Sleep, 500
    Send, {space down}
    Send, {d down}
    Sleep, 200
    Send, {space up}

}

Vic_Detect(ImagePath) {
    WinGet, RobloxWindowID, ID, ahk_class WINDOWSCLIENT

    if RobloxWindowID {
        WinGetPos, RobloxX, RobloxY, RobloxWidth, RobloxHeight, ahk_id %RobloxWindowID%

        SendInput, {/}
        Sleep, 100 

        SendInput, {Enter}
        Sleep, 100 

        Sleep, 1000

        ImageSearch, FoundX, FoundY, RobloxX, RobloxY, RobloxWidth, RobloxHeight, *32 %ImagePath%

        if (ErrorLevel = 0) {
            AttackVic()
            return 1
        } else {
            return 0
        }
    }
}

AttackVic() {
    while (!CheckIfDefeated()) {
        Send, {w down}
        Sleep, 400
        Send, {w up}
        Sleep, 500 

        Send, {a down}
        Sleep, 400
        Send, {a up}
        Sleep, 500 

        Send, {s down}
        Sleep, 400
        Send, {s up}
        Sleep, 500 

        Send, {d down}
        Sleep, 400
        Send, {d up}
        Sleep, 500 
    }
}

CheckIfDefeated(){
    WinGet, RobloxWindowID, ID, ahk_class WINDOWSCLIENT
    ImagePath := "img/Defeated.png"
    if (RobloxWindowID) {
        WinGetPos, RobloxX, RobloxY, RobloxWidth, RobloxHeight, ahk_id %RobloxWindowID%

        SendInput, {/}
        Sleep, 100 

        SendInput, {Enter}
        Sleep, 100 

        ImageSearch, FoundX, FoundY, RobloxX, RobloxY, RobloxX + RobloxWidth, RobloxY + RobloxHeight, *32 %ImagePath%

        if (ErrorLevel = 0) {
            return 1
        } else {
            return 0
        }
    }
    return 0
}
