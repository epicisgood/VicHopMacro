#NoEnv 
CoordMode, Pixel, Screen 

global current_hive := 1

StartServer() {
    global current_hive
    WinActivate, ahk_class WINDOWSCLIENT ahk_exe RobloxPlayerBeta.exe
    SetKeyDelay, 50 
    Sleep, 3000
    CheckSpawnPos()
    Send, .
    Sleep, 300
    Send, {w down}
    Sleep, 5000
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

CheckForNight() {
    WinActivate, ahk_class WINDOWSCLIENT ahk_exe RobloxPlayerBeta.exe
    WinGetPos, x, y, width, height, ahk_class WINDOWSCLIENT ahk_exe RobloxPlayerBeta.exe
    centerX := x + (width // 2)
    MouseMove, centerX, 100
    PixelGetColor, color, centerX, 150 
    return color
}

CheckSpawnPos(){
    ImagePath1 := "img/Egg.png"
    ImagePath2 := "img/NightEgg.png"
    ImagePath3 := "img/SnowEgg.png"
    ImagePath4 := "img/LoadingEgg.png"

    WinGet, RobloxWindowID, ID, ahk_class WINDOWSCLIENT

    if (RobloxWindowID) {
        WinGetPos, RobloxX, RobloxY, RobloxWidth, RobloxHeight, ahk_id %RobloxWindowID%
        Sleep, 1000

        ImageSearch, FoundX1, FoundY1, RobloxX, RobloxY, RobloxX + RobloxWidth, RobloxY + RobloxHeight, *32 %ImagePath1%
        EggFound := (ErrorLevel = 0)

        ImageSearch, FoundX2, FoundY2, RobloxX, RobloxY, RobloxX + RobloxWidth, RobloxY + RobloxHeight, *32 %ImagePath2%
        NightEggFound := (ErrorLevel = 0)

        ImageSearch, FoundX2, FoundY2, RobloxX, RobloxY, RobloxX + RobloxWidth, RobloxY + RobloxHeight, *32 %ImagePath3%
        SnowEgg := (ErrorLevel = 0)

        ImageSearch, FoundX2, FoundY2, RobloxX, RobloxY, RobloxX + RobloxWidth, RobloxY + RobloxHeight, *32 %ImagePath4%
        LoadingEgg := (ErrorLevel = 0)

        if (EggFound || NightEggFound || SnowEgg || LoadingEgg) {
            SetKeyDelay, 100
            Send, ,
            Send, ,
            Send, ,
            Send, ,
            Sleep, 2000
            return 
        } else {
            return 
        }
    } else {
        return 
    }
}

; CheckAtHiveSpawn(){
;     WinGet, RobloxWindowID, ID, ahk_class WINDOWSCLIENT
;     ImagePath1 := "img/YellowHive.png"
;     ImagePath2 := "img/test.png"
;     if (RobloxWindowID) {
;         WinGetPos, RobloxX, RobloxY, RobloxWidth, RobloxHeight, ahk_id %RobloxWindowID%
;         Sleep, 1000

;         ImageSearch, FoundX1, FoundY1, RobloxX, RobloxY, RobloxX + RobloxWidth, RobloxY + RobloxHeight, *32 %ImagePath1%
;         YellowHive := (ErrorLevel = 0)

;         ImageSearch, FoundX1, FoundY1, RobloxX, RobloxY, RobloxX + RobloxWidth, RobloxY + RobloxHeight, *32 %ImagePath2%
;         BrownThing := (ErrorLevel = 0)
;         if (YellowHive || BrownThing){
;             MsgBox, detected 
;         }
;         else {
;             SetKeyDelay, 100
;             Send, ,
;             Send, ,
;             Send, ,
;             Send, ,
;             Sleep, 1500
;             return 
;         }

;     } else {
;         return 
;     }
; }

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
        Sleep, 1045
        Send, {a up}
        Sleep, 1050
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
    ;; check if health bar disappears later detection
    Sleep, 10000
    ZoomOut()
    CheckSpawnPos()
    Send, {PgDn}
    Sleep, 1000
    NightSearchSpawnPoint := NightSearchWhereSpawned()
    SearchSpawnPoint := SearchWhereSpawned()
    if (SearchSpawnPoint == 1 || NightSearchSpawnPoint == 1) {
        Send, {Pgup}
        FalseGoToRamp()
    } else {
        Send, {Pgup}
        ; CheckAtHiveSpawn()
        GoToRamp()
        return

    }
}

SearchWhereSpawned(){
    WinGet, RobloxWindowID, ID, ahk_class WINDOWSCLIENT
    ImagePath := "img/Blue.png"
    if (RobloxWindowID) {
        WinGetPos, RobloxX, RobloxY, RobloxWidth, RobloxHeight, ahk_id %RobloxWindowID%

        ImageSearch, FoundX, FoundY, RobloxX, RobloxY, RobloxX + RobloxWidth, RobloxY + RobloxHeight, *32 %ImagePath%

        if (ErrorLevel = 0) {
            return 1
        } else {
            return 0
        }
    }
    return 0
}

NightSearchWhereSpawned(){
    WinGet, RobloxWindowID, ID, ahk_class WINDOWSCLIENT
    ImagePath := "img/Black.png"
    if (RobloxWindowID) {
        WinGetPos, RobloxX, RobloxY, RobloxWidth, RobloxHeight, ahk_id %RobloxWindowID%

        ImageSearch, FoundX, FoundY, RobloxX, RobloxY, RobloxX + RobloxWidth, RobloxY + RobloxHeight, *32 %ImagePath%

        if (ErrorLevel = 0) {
            return 1
        } else {
            return 0
        }
    }
    return 0
}

GoToRamp() {
    global current_hive
    SendMode, Input 
    SetKeyDelay, 50, 50
    Sleep, 300
    Send, {d down}
    Sleep, 1000 * current_hive
    Send, {d up}
    Sleep, 500
    Send, {space down}
    Send, {d down}
    Sleep, 400
    send, {d up}
    Sleep, 100
    Send, {space up}

}

FalseGoToRamp(){
    SendMode, Input 
    SetKeyDelay, 50, 50
    Send, {w down}
    Sleep, 1800
    Send, {w up}
    Send, {d down}
    Sleep, 3000
    Send, {d up}

    Send, {space down}
    Send, {d down}
    Sleep, 400
    send, {d up}
    Sleep, 100
    Send, {space up}
}

RedCannon(){
    SendMode, Input 
    SetKeyDelay, 50, 50

    Send, {w down}
    Sleep, 400
    Send, {w up}
    Send, {Space down}
    Send, {d down} 
    Sleep, 600
    Send, {Space up}
    Send, {d up}

    Sleep, 400
    Send, {e down}
    Sleep, 50
    Send, {e up}
    Send, {e down}
    Sleep, 50
    Send, {e up}
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
            return 1
        } else {
            return 0
        }
    }
}

PepperAttackVic(){
    while (!CheckIfDefeated()) {
        ElapsedTime := A_TickCount - StartTime
        if (ElapsedTime > 300000) {
            break
        }
        Loop, 2{
            Send, {w down}
            Sleep, 400
            Send, {w up}
            Sleep, 500 
        }

        Send, {a down}
        Sleep, 400
        Send, {a up}
        Sleep, 500 

        Send, {s down}
        Sleep, 400
        Send, {s up}
        Sleep, 500 
        Loop, 2{
            Send, {d down}
            Sleep, 400
            Send, {d up}
            Sleep, 500 
        }
    }
    Sleep, 5000
    return
}

AttackVic() {
    while (!CheckIfDefeated()) {
        ElapsedTime := A_TickCount - StartTime
        if (ElapsedTime > 200000) {
            break
        }
        Loop, 2{
            Send, {w down}
            Sleep, 400
            Send, {w up}
            Sleep, 500 
        }
        Loop, 2{

            Send, {a down}
            Sleep, 400
            Send, {a up}
            Sleep, 500 
        } 
        Loop, 2{
            Send, {s down}
            Sleep, 400
            Send, {s up}
            Sleep, 500 
        }
        Loop, 2{

            Send, {d down}
            Sleep, 400
            Send, {d up}
            Sleep, 500 
        }
    }
    Sleep, 5000
    return
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
