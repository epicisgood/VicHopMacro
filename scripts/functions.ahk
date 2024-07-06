CoordMode "Pixel", "Screen"


;; roblox x,y,width,height
global windowX, windowY, windowWidth, windowHeight

GetRobloxClientPos(hwnd?)
{
    global windowX, windowY, windowWidth, windowHeight
    if !IsSet(hwnd)
        hwnd := GetRobloxHWND()

    try
        WinGetClientPos &windowX, &windowY, &windowWidth, &windowHeight, "ahk_id " hwnd
    catch TargetError
        return windowX := windowY := windowWidth := windowHeight := 0
    else
        return 1
}

GetRobloxHWND()
{
    if (hwnd := WinExist("Roblox ahk_exe RobloxPlayerBeta.exe"))
        return hwnd
    else if (WinExist("Roblox ahk_exe ApplicationFrameHost.exe"))
    {
        try
            hwnd := ControlGetHwnd("ApplicationFrameInputSinkWindow1")
        catch TargetError
            hwnd := 0
        return hwnd
    }
    else
        return 0
}

ActivateRoblox()
{
    try
        WinActivate "Roblox"
    catch
        return 0
    else
        return 1
}


PictureImageSearch(ImagePath, Strength) {
    hwnd := GetRobloxHWND()
    GetRobloxClientPos(hwnd)
    SearchOptions := "*" Strength " " . ImagePath
    if ImageSearch(&FoundX, &FoundY, windowX, windowY, windowX + windowWidth, windowY + windowHeight, SearchOptions) {
        return 1
    } else {
        return 0
    }
}


global current_hive := 1

StartServer() {
    global current_hive
    SetKeyDelay 50
    Send "."
    Sleep 300
    Send "{w down}"
    Sleep 2500
    Send "{w up}"
    Sleep 50
    Send ","
    Sleep 50
    Send "{d down}"
    Sleep 1000
    Send "{d up}"
    current_hive := FindHiveSlot()
    if (current_hive = 0) {
        SetKeyDelay 100
        Send "{Esc}{r}{Enter}"
        Sleep 500
        HealthDetection()
        ZoomOut()
        return 3
    }
    resetcharattempts := 0
    ResetVar := ResetCharacter()
    while (ResetVar == 2) {
        resetcharattempts++
        if resetcharattempts > 4 {
            return 4
        }
        ResetVar := ResetCharacter()
    }

}

ZoomOut() {
    Loop 15 {
        Send "{o down}"
        Sleep 10
        Send "{o up}"
    }
}


DetectLoading(loadingColor, timeout) {
    startTime := A_TickCount
    loop {
        color := PixelGetColor(458, 151)
        ActivateRoblox()
        if (color = loadingColor) {
            break ;; detected loading color
        }
        if (A_TickCount - startTime >= timeout) {
            return false ; Timeout reached for loading color. This means it was not on screen
        }
        Sleep 100
    }


    loop {
        color := PixelGetColor(458, 151)
        if (color != loadingColor) {
            break ;; detected loading color going away
        }
        Sleep 100
    }

    return true ; Loading succesfully managed
}


NightDetection() {
    if PictureImageSearch("img\nightground.png", 16) {
        return 1
    }
    else {
        return 0
    }
}

CheckSpawnPos() {
    Send "i"
    Sleep 500

    if (PictureImageSearch("img\Leaderboard.png", 32) || PictureImageSearch("img\nightlb.png", 32)) {
        SetKeyDelay 100
        Send ",,,,"
        Sleep 2000
        SetKeyDelay 50
        return
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

    Sleep 500

    if PictureImageSearch("img/Hive.png", 32) {
        Send "{e down}"
        Sleep 200
        Send "{e up}"
        return current_hive
    }
}


ResetCharacter() {
    Send "{Esc}{r}{Enter}"
    Sleep 500
    HealthDetection()
    ZoomOut()
    CheckSpawnPos()
    Send "{PgDn}"
    Sleep 250
    if (CheckCocoSpawn() == 1) {
        Send "{Pgup}"
        FalseGoToRamp()
        RedCannon()
        return 1
    } else {
        Send "{Pgup}"
        ZoomOut()
        HiveCorrection()
        GoToRamp()
        ZoomOut()
        RedCannon()
        if (CheckFireButton() == 0) {
            return 2
        }
    }
    return 1
}


HealthDetection() {
    while (PictureImageSearch("img\Health.png", 32)) {
        Sleep 100
    }
    Sleep 500
    return 1

}

CheckCocoSpawn() {

    if (PictureImageSearch("img\Blue.png", 32)) {
        return 1
    } else if (PictureImageSearch("img/Black.png", 32)) {
        return 1
    }
    else {
        return 0
    }
}


HiveCorrection() {
    if (PictureImageSearch("img\ground.png", 25) || PictureImageSearch("img\nightground.png", 25)) {
        return 1
    }
    else {
        SetKeyDelay 100
        Send ",,,,"
        return 0
    }
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
    Send "{w down}"
    Sleep 400
    Send "{w up}"
    Send "{Space down}"
    Send "{d down}"
    Sleep 600
    Send "{Space up}"
    Send "{d up}"

    Sleep 200

}

CheckFireButton() {
    Sleep 250
    if PictureImageSearch("img\fire.png", 32) {
        return 1
    }
    return 0
}

VicActivated() {

    Send "{/}{Enter}"
    if PictureImageSearch("img\Warning.png", 32) {
        return 1
    }

    return 0
}

PepperAttackVic() {
    PlayerStatus("Starting Pepper Kill Cycle", 15105570, false)
    StartTime := A_TickCount
    while (!CheckIfDefeated()) {
        ElapsedTime := A_TickCount - StartTime
        if (ElapsedTime > 150000) { ;; 1 minute and 30 seconds to kill vic bee
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
        PlayerStatus("Looped finished", 15105570, false)

    }
    PlayerStatus("Vicious bee has been defeated!", 7419530, true)
    Sleep 7500
    return
}

MtnAttackVic() {
    PlayerStatus("Starting Mtn Kill Cycle", 11027200, false)
    StartTime := A_TickCount
    while (!CheckIfDefeated()) {
        ElapsedTime := A_TickCount - StartTime
        if (ElapsedTime > 150000) { ;; 2m 30s to kill vic bee
            break
        }
        Send "{d down}"
        Sleep 1500
        Send "{d up}"
        loop 5 {
            Send "{s down}"
            Sleep 400
            Send "{s up}"
        }
        Send "{a down}"
        Sleep 400
        Send "{a up}"
        loop 5 {
            Send "{w down}"
            Sleep 400
            Send "{w up}"
        }
        PlayerStatus("Looped finished", 11027200, false)

    }
    PlayerStatus("Vicious bee has been defeated!", 7419530, true)
    Sleep 7500
    return
}

AttackVic() {
    PlayerStatus("Starting Vicious Kill Cycle", 15844367, false)
    StartTime := A_TickCount
    while (!CheckIfDefeated()) {
        ElapsedTime := A_TickCount - StartTime
        if (ElapsedTime > 120000) { ;; 1m 30s to kill vic bee
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
        PlayerStatus("Looped finished", 15844367, false)
    }
    PlayerStatus("Vicious bee has been defeated!", 7419530, true)
    Sleep 7500

    return
}

CheckIfDefeated() {
    Send "{/}{Enter}"
    if PictureImageSearch("img\Defeated.png", 32) {
        return 1
    }
    return 0
}