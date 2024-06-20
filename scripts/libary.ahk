
CoordMode "Pixel", "Screen"

global current_hive := 1

StartServer() {
    global current_hive
    WinActivate "ahk_class WINDOWSCLIENT ahk_exe RobloxPlayerBeta.exe"
    SetKeyDelay 50
    Sleep 3000
    CheckSpawnPos()
    Send "."
    Sleep 300
    Send "{w down}"
    Sleep 5000
    Send "{w up}"
    Send ","
    Send "{s down}"
    Sleep 500
    Send "{s up}"
    current_hive := FindHiveSlot()
    if (current_hive) {
        ResetCharacter()
    }
}

DetectLoading(loadingColor, timeout) {
    startTime := A_TickCount
    loop {
        color := PixelGetColor(458, 151)
        if (color = loadingColor) {
            break
        }
        if (A_TickCount - startTime >= timeout) {
            return false ; Timeout reached
        }
        Sleep 100
    }

    startTime := A_TickCount
    loop {
        color := PixelGetColor(458, 151)
        if (color != loadingColor) {
            break
        }
        Sleep 100
    }

    return true ; Loading success
}

ZoomOut() {
    Loop 5 {
        Send "{o down}"
        Sleep 100
        Send "{o up}"
    }
}

CheckForNight() {
    WinActivate "ahk_class WINDOWSCLIENT ahk_exe RobloxPlayerBeta.exe"
    WinGetPos &x, &y, &width, &height, "ahk_class WINDOWSCLIENT ahk_exe RobloxPlayerBeta.exe"
    centerX := x + (width // 2)
    MouseMove centerX, 100
    color := PixelGetColor(centerX, 150)
    return color
}

CheckSpawnPos() {
    ImagePath1 := "img/Egg.png"
    ImagePath2 := "img/NightEgg.png"
    ImagePath3 := "img/SnowEgg.png"
    ImagePath4 := "img/LoadingEgg.png"

    RobloxWindowID := WinExist("Roblox ahk_exe RobloxPlayerBeta.exe")

    if (RobloxWindowID) {
        WinGetPos &RobloxX, &RobloxY, &RobloxWidth, &RobloxHeight, "ahk_id " . RobloxWindowID
        Sleep 1000

        ; Perform image searches and set flags based on results
        if ImageSearch(&FoundX1, &FoundY1, RobloxX, RobloxY, RobloxX + RobloxWidth, RobloxY + RobloxHeight, "*32 " . ImagePath1) {
            EggFound := true
        } else {
            EggFound := false
        }

        if ImageSearch(&FoundX2, &FoundY2, RobloxX, RobloxY, RobloxX + RobloxWidth, RobloxY + RobloxHeight, "*32 " . ImagePath2) {
            NightEggFound := true
        } else {
            NightEggFound := false
        }

        if ImageSearch(&FoundX3, &FoundY3, RobloxX, RobloxY, RobloxX + RobloxWidth, RobloxY + RobloxHeight, "*32 " . ImagePath3) {
            SnowEgg := true
        } else {
            SnowEgg := false
        }

        if ImageSearch(&FoundX4, &FoundY4, RobloxX, RobloxY, RobloxX + RobloxWidth, RobloxY + RobloxHeight, "*32 " . ImagePath4) {
            LoadingEgg := true
        } else {
            LoadingEgg := false
        }

        if (EggFound || NightEggFound || SnowEgg || LoadingEgg) {
            SetKeyDelay 100
            Send ",,,,"
            Sleep 2000
            return
        }
    }
}

FindHiveSlot() {
    global current_hive
    Sleep 300
    Send "{a down}"
    Sleep 400
    Send "{a up}"
    Sleep 1500
    current_hive := 1
    if (ClaimHive(current_hive)) {
        return current_hive
    }
    Loop 5 {
        Send "{a down}"
        Sleep 1045
        Send "{a up}"
        Sleep 1500
        current_hive++
        if (ClaimHive(current_hive)) {
            return current_hive
        }
    }
    return 0
}

ClaimHive(current_hive) {
    ImagePath := "img/Hive.png"
    RobloxWindowID := WinExist("Roblox ahk_exe RobloxPlayerBeta.exe")

    if (RobloxWindowID) {
        WinGetPos &RobloxX, &RobloxY, &RobloxWidth, &RobloxHeight, "ahk_id " . RobloxWindowID
        Sleep 1000

        if ImageSearch(&FoundX, &FoundY, RobloxX, RobloxY, RobloxX + RobloxWidth, RobloxY + RobloxHeight, "*32 " . ImagePath) {
            Send "{e down}"
            Sleep 200
            Send "{e up}"
            return current_hive
        }
    }
    return 0
}

ResetCharacter() {
    Send "{Esc down}"
    Sleep 100
    Send "{Esc up}"
    Sleep 100
    Send "{r down}"
    Sleep 100
    Send "{r up}"
    Sleep 100
    Send "{Enter down}"
    Sleep 100
    Send "{Enter up}"
    ;; check if health bar disappears later detection
    Sleep 10000
    ZoomOut()
    CheckSpawnPos()
    Send "{PgDn}"
    Sleep 1000
    NightSearchSpawnPoint := NightSearchWhereSpawned()
    SearchSpawnPoint := SearchWhereSpawned()
    if (SearchSpawnPoint == 1 || NightSearchSpawnPoint == 1) {
        Send "{Pgup}"
        FalseGoToRamp()
    } else {
        Send "{Pgup}"
        GoToRamp()
    }
}

SearchWhereSpawned() {
    ImagePath := "img/Blue.png"
    RobloxWindowID := WinExist("Roblox ahk_exe RobloxPlayerBeta.exe")

    if (RobloxWindowID) {
        WinGetPos &RobloxX, &RobloxY, &RobloxWidth, &RobloxHeight, "ahk_id " . RobloxWindowID

        if ImageSearch(&FoundX, &FoundY, RobloxX, RobloxY, RobloxX + RobloxWidth, RobloxY + RobloxHeight, "*32 " . ImagePath) {
            return 1 
        }
    }
    return 0 
}

NightSearchWhereSpawned() {
    ImagePath := "img/Black.png"
    RobloxWindowID := WinExist("Roblox ahk_exe RobloxPlayerBeta.exe")

    if (RobloxWindowID) {
        WinGetPos &RobloxX, &RobloxY, &RobloxWidth, &RobloxHeight, "ahk_id " . RobloxWindowID

        FoundX := 0
        FoundY := 0

        if ImageSearch(&FoundX, &FoundY, RobloxX, RobloxY, RobloxX + RobloxWidth, RobloxY + RobloxHeight, "*32 " . ImagePath) {
            return 1
        }
    }
    return 0 
}

GoToRamp() {
    global current_hive
    SetKeyDelay 50, 50
    Sleep 300
    Send "{d down}"
    Sleep 1000 * current_hive
    Send "{d up}"
    Sleep 500
    Send "{space down}"
    Send "{d down}"
    Sleep 100
    Send "{space up}"
    Sleep 200
    Send "{d up}"
}

FalseGoToRamp() {
    SetKeyDelay 50, 50
    Send "{w down}"
    Sleep 1800
    Send "{w up}"
    Send "{d down}"
    Sleep 3000
    Send "{d up}"
    Send "{space down}"
    Send "{d down}"
    Sleep 100
    Send "{space up}"
    Sleep 200
    Send "{d up}"
}

RedCannon() {
    SetKeyDelay 50, 50
    Sleep 100
    Send "{w down}"
    Sleep 400
    Send "{w up}"
    Send "{Space down}"
    Send "{d down}"
    Sleep 600
    Send "{Space up}"
    Send "{d up}"

    Sleep 1000

}

Vic_Detect(ImagePath) {
    RobloxWindowID := WinExist("Roblox ahk_exe RobloxPlayerBeta.exe")

    if (RobloxWindowID) {
        WinGetPos &RobloxX, &RobloxY, &RobloxWidth, &RobloxHeight, "ahk_id " . RobloxWindowID

        Send "{/}"
        Sleep 100
        Send "{Enter}"
        Sleep 100

        Sleep 1000

        if ImageSearch(&FoundX, &FoundY, RobloxX, RobloxY, RobloxX + RobloxWidth, RobloxY + RobloxHeight, "*32 " . ImagePath) {
            return 1 
        }
    }
    return 0 
}

PepperAttackVic() {
    StartTime := A_TickCount
    while (!CheckIfDefeated()) {
        ElapsedTime := A_TickCount - StartTime
        if (ElapsedTime > 300000) {
            break
        }
        Loop 2 {
            Send "{w down}"
            Sleep 400
            Send "{w up}"
            Sleep 500
        }

        Send "{a down}"
        Sleep 400
        Send "{a up}"
        Sleep 500

        Send "{s down}"
        Sleep 400
        Send "{s up}"
        Sleep 500
        Loop 2 {
            Send "{d down}"
            Sleep 400
            Send "{d up}"
            Sleep 500
        }
    }
    Sleep 5000
    return
}

AttackVic() {
    StartTime := A_TickCount
    while (!CheckIfDefeated()) {
        ElapsedTime := A_TickCount - StartTime
        if (ElapsedTime > 200000) {
            break
        }
        Loop 2 {
            Send "{w down}"
            Sleep 400
            Send "{w up}"
            Sleep 500
        }
        Loop 2 {
            Send "{a down}"
            Sleep 400
            Send "{a up}"
            Sleep 500
        }
        Loop 2 {
            Send "{s down}"
            Sleep 400
            Send "{s up}"
            Sleep 500
        }
        Loop 2 {
            Send "{d down}"
            Sleep 400
            Send "{d up}"
            Sleep 500
        }
    }
    Sleep 5000
    return
}

CheckIfDefeated() {
    RobloxWindowID := WinExist("Roblox ahk_exe RobloxPlayerBeta.exe")
    ImagePath := "img/Defeated.png"

    if (RobloxWindowID) {
        WinGetPos &RobloxX, &RobloxY, &RobloxWidth, &RobloxHeight, "ahk_id " . RobloxWindowID

        Send "{/}"
        Sleep 100
        Send "{Enter}"
        Sleep 100

        Sleep 1000

        if ImageSearch(&FoundX, &FoundY, RobloxX, RobloxY, RobloxX + RobloxWidth, RobloxY + RobloxHeight, "*32 " . ImagePath) {
            return 1 
        }
    }
    return 0 
}

