#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
CoordMode, Pixel, Screen ; Set coordinate mode to screen.

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
    Loop, 10 {
        Send, {WheelDown}
        Sleep, 100
    }
}

FindHiveSlot() {
    global current_hive
    Sleep, 300
    Send, {a down}
    Sleep, 500
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
    ZoomOut()
    Send, {w down}
    Sleep, 3000
    Send, {w up}
    Sleep, 50
    Send, {s down}
    Sleep, 150
    Send, {s up}
    GoToRamp()
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

        ; If the image is found 
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
        Sleep, 700
        Send, {w up}
        Send, {a down}
        Sleep, 700
        Send, {a up}
        Send, {s down}
        Sleep, 700
        Send, {s up}
        Send, {d down}
        Sleep, 700
        Send, {d up}
    }
}

CheckIfDefeated(){
    WinGet, RobloxWindowID, ID, ahk_class WINDOWSCLIENT
    ImagePath := "img/Defeated.png"
    if (RobloxWindowID) {
        WinGetPos, RobloxX, RobloxY, RobloxWidth, RobloxHeight, ahk_id %RobloxWindowID%

        ImageSearch, FoundX, FoundY, RobloxX, RobloxY, RobloxX + RobloxWidth, RobloxY + RobloxHeight, *32 %ImagePath%

        if (ErrorLevel = 0) {
            MsgBox, Successfully defeated Vicious Bee
            return 1
        } else {
            return 0
        }
    }
    return 0
}
