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

HyperSleep(ms)
{
    static freq := (DllCall("QueryPerformanceFrequency", "Int64*", &f := 0), f)
    DllCall("QueryPerformanceCounter", "Int64*", &begin := 0)
    current := 0, finish := begin + ms * freq / 1000
    while (current < finish)
    {
        if ((finish - current) > 30000)
        {
            DllCall("Winmm.dll\timeBeginPeriod", "UInt", 1)
            DllCall("Sleep", "UInt", 1)
            DllCall("Winmm.dll\timeEndPeriod", "UInt", 1)
        }
        DllCall("QueryPerformanceCounter", "Int64*", &current)
    }
}


global current_hive := 1

StartServer() {
    global current_hive
    SetKeyDelay 50
    send "{" RotRight " 1}"
    Sleep(300)
    Send "{" WKey " down}"
    Sleep(550)
    glider()
    Sleep(550)
    Send "{" WKey " up}"
    Sleep(50)
    send "{" RotLeft " 1}"
    Sleep(50)
    Send "{" Dkey " down}"
    Sleep(1000)
    Send "{" Dkey " up}"
    current_hive := FindHiveSlot()
    if (current_hive = 0) {
        PlayerStatus("Could Not Claim hive retrying..", 15277667, false)
        SetKeyDelay 100
        send "{" EscKey "}{" Rkey "}{" EnterKey "}"
        Sleep(500)
        HealthDetection()
        ZoomOut()
        return 3
    }
    if (ResetMainCharacter() == false) {
        return 4
    }
}


StartServerLoop() {
    GetServerIds()
    StartServerAttempts := 0
    ServerVar := StartServer()
    while (ServerVar == 3 || ServerVar == 4) {
        StartServerAttempts++
        if StartServerAttempts == 3 {
            PlayerStatus("leaving server could not claim hive current_hive = 0", 8359053, true)
            return
        }

        if ServerVar == 4 {
            PlayerStatus("leaving server reset count went over 4...", 8359053, true)
            return
        }
        ServerVar := StartServer()
    }
}

ZoomOut() {
    Loop 15 {
        Send "{" ZoomOuter " down}"
        Sleep(10)
        Send "{" ZoomOuter " up}"
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
            try {
                PlayerStatus("Closing roblox place restricted error", 15548997, false)
                HWND := GetRobloxHWND()
                WinClose(HWND)
                WinClose(HWND)
            } catch Error as e {
                PlayerStatus('Something went horribly wrong! Erorr:' e.Message '', 15548997, false)
            }
            return false ; Timeout reached for loading color. This means it was not on screen
        }
        Sleep(100)
    }


    loop {
        color := PixelGetColor(458, 151)
        if (color != loadingColor) {
            break ;; detected loading color going away
        }
        Sleep(100)
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
    send "{" ZoomIn " 1}"
    Sleep(500)

    if (PictureImageSearch("img\Leaderboard.png", 32) || PictureImageSearch("img\nightlb.png", 32)) {
        SetKeyDelay 100
        send "{" RotRight " 4}"
        Sleep(2000)
        SetKeyDelay 50
        return
    }

}

FindHiveSlot() {
    global current_hive
    HyperSleep(300)
    Send "{" AKey " down}"
    HyperSleep(500)
    Send "{" AKey " up}"
    HyperSleep(1500)
    current_hive := 1
    if (ClaimHive(current_hive)) {
        return current_hive
    }
    Loop 5 {
        Send "{" AKey " down}"
        HyperSleep(1045)
        Send "{" AKey " up}"
        HyperSleep(1500)
        current_hive++
        if (ClaimHive(current_hive)) {
            return current_hive
        }
    }
    return 0
}

ClaimHive(current_hive) {
    ImagePath := "img/Hive.png"

    Sleep(750)

    if PictureImageSearch("img/Hive.png", 32) {
        Send "{" Ekey " down}"
        Sleep(200)
        Send "{" Ekey " up}"

        PlayerStatus("Claimed hiveslot " current_hive, 10181046, false)
        return current_hive
    }
}


ResetMainCharacter() {
    resetcharattempts := 0
    ResetVar := ResetCharacter()
    while (ResetVar == 2) {
        resetcharattempts++
        if resetcharattempts > 3 {
            PlayerStatus("leaving server recoonecting count went over 3...", 8359053, true)
            return false
        }
        ResetVar := ResetCharacter()
    }
    return true
}

ResetCharacter() {
    send "{" EscKey "}{" Rkey "}{" EnterKey "}"
    Sleep(500)
    HealthDetection()
    ZoomOut()
    CheckSpawnPos()
    Send "{" RotDown " 1}"
    Sleep(250)
    if (CheckCocoSpawn() == 1) {
        Send "{" RotUp " 1}"
        FalseGoToRamp()
        RedCannon()
        return 1
    } else {
        Send "{" RotUp " 1}"
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
        Sleep(100)
    }
    Sleep(500)
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
        send "{" RotLeft " 4}"
        return 0
    }
}


GoToRamp() {
    global current_hive
    SetKeyDelay 50, 50
    Sleep(300)
    Send "{" Dkey " down}"
    Sleep(1000 * current_hive)
    Send "{" Dkey " up}"
    Sleep(500)
    Send "{" SpaceKey " down}"
    Send "{" Dkey " down}"
    Sleep(100)
    Send "{" SpaceKey " up}"
    Sleep(200)
    Send "{" Dkey " up}"
}

FalseGoToRamp() {
    SetKeyDelay 50, 50
    Send "{" WKey " down}"
    Sleep(1800)
    Send "{" WKey " up}"
    Send "{" Dkey " down}"
    Sleep(3000)
    Send "{" Dkey " up}"
    Send "{" SpaceKey " down}"
    Send "{" Dkey " down}"
    Sleep(100)
    Send "{" SpaceKey " up}"
    Sleep(200)
    Send "{" Dkey " up}"
}

RedCannon() {
    SetKeyDelay 50, 50
    Send "{" WKey " down}"
    Sleep(400)
    Send "{" WKey " up}"
    Send "{" SpaceKey " down}"
    Send "{" Dkey " down}"
    Sleep(600)
    Send "{" SpaceKey " up}"
    Send "{" Dkey " up}"

    Sleep(200)

}

glider() {
    loop 2 {
        Send "{" SpaceKey " down}"
        Sleep(250)
        Send "{" SpaceKey " up}"
    }
}


CheckFireButton() {
    Sleep(400)
    if PictureImageSearch("img\fire.png", 32) {
        return 1
    }
    return 0
}

VicActivated() {

    Send "{" SlashKey "}" "{" EnterKey "}"
    Sleep(100)
    if PictureImageSearch("img\Warning.png", 32) {
        return 1
    }

    return 0
}

Dead := false

PepperAttackVic() {
    PlayerStatus("Starting Pepper Kill Cycle", 15105570, false)
    global Dead
    Dead := false

    StartTime := 0
    StartTime := A_TickCount
    while (!CheckIfDefeated()) {
        ElapsedTime := A_TickCount - StartTime
        if (ElapsedTime > 150000) { ;; 1 minute and 30 seconds to kill vic bee
            return 2
        }
        if (Dead == true) {
            return 3
        }

        Loop 2 {
            PlayerDied()
            Send "{" WKey " down}"
            Sleep(400)
            Send "{" WKey " up}"
            Sleep(500)
        }
        Loop 2 {
            PlayerDied()
            Send "{" AKey " down}"
            Sleep(400)
            Send "{" AKey " up}"
            Sleep(500)
        }
        Loop 2 {
            PlayerDied()
            Send "{" SKey " down}"
            Sleep(400)
            Send "{" SKey " up}"
            Sleep(500)
        }
        Loop 2 {
            PlayerDied()
            Send "{" Dkey " down}"
            Sleep(400)
            Send "{" Dkey " up}"
            Sleep(500)
        }
        PlayerStatus("Looped finished", 15105570, false)

    }
    Sleep(5000)
    PlayerStatus("Vicious bee has been defeated!", 7419530, true)
    Sleep(7500)
    return 2
}

MtnAttackVic() {
    PlayerStatus("Starting Mtn Kill Cycle", 11027200, false)
    StartTime := 0
    StartTime := A_TickCount

    global Dead
    Dead := false


    while (!CheckIfDefeated()) {
        ElapsedTime := A_TickCount - StartTime
        if (ElapsedTime > 150000) { ;; 2m 30s to kill vic bee
            break
        }
        if (Dead == true) {
            return 3
        }
        PlayerDied()
        Send "{" Dkey " down}"
        Sleep(1500)
        Send "{" Dkey " up}"
        PlayerDied()
        loop 5 {
            PlayerDied()
            Send "{" SKey " down}"
            Sleep(400)
            Send "{" SKey " up}"
        }
        Send "{" AKey " down}"
        Sleep(400)
        Send "{" AKey " up}"
        PlayerDied()
        loop 5 {
            Send "{" WKey " down}"
            Sleep(400)
            Send "{" WKey " up}"
        }
        PlayerStatus("Looped finished", 11027200, false)

    }
    Sleep(5000)
    PlayerStatus("Vicious bee has been defeated!", 7419530, true)
    Sleep(7500)
    return 2
}

AttackVic() {
    PlayerStatus("Starting Vicious Kill Cycle", 15844367, false)
    StartTime := 0
    StartTime := A_TickCount

    global Dead
    Dead := false


    while (!CheckIfDefeated()) {
        ElapsedTime := A_TickCount - StartTime
        if (ElapsedTime > 120000) { ;; 1m 30s to kill vic bee
            break
        }
        if (Dead == true) {
            return 3
        }
        Loop 2 {
            PlayerDied()
            Send "{" WKey " down}"
            Sleep(400)
            Send "{" WKey " up}"
            Sleep(500)
        }
        Loop 2 {
            PlayerDied()
            Send "{" AKey " down}"
            Sleep(400)
            Send "{" AKey " up}"
            Sleep(500)
        }
        Loop 2 {
            PlayerDied()
            Send "{" SKey " down}"
            Sleep(400)
            Send "{" SKey " up}"
            Sleep(500)
        }
        Loop 2 {
            PlayerDied()
            Send "{" Dkey " down}"
            Sleep(400)
            Send "{" Dkey " up}"
            Sleep(500)
        }
        PlayerStatus("Looped finished", 15844367, false)
    }
    Sleep(5000)
    PlayerStatus("Vicious bee has been defeated!", 7419530, true)
    Sleep(7500)

    return 2
}

PlayerDied() {
    global Dead
    if PictureImageSearch("img\died.png", 32) {
        Dead := true
        PlayerStatus("Bro Died To vicious bee during battle... What an embarrassment", 2899536, false)
        return 1
    } else {
        return 0
    }
}


CheckIfDefeated() {
    Send "{" SlashKey "}" "{" EnterKey "}"
    if PictureImageSearch("img\Party_ballon.png", 16) {
        PlayerStatus("Bouyant Party Balloon succesfully detected!!", 3447003, false)
        return 0
    }
    if PictureImageSearch("img\Defeated.png", 32) {
        return 1
    }
    return 0
}


; Main Function to call only

; 3 = died
; 2 = Succesfully defeated / timeout reached
VIciousAttackLoop(CurrentFeild := 1) {
    if (VicActivated() == 1) {
        result := ViciousBattle(CurrentFeild)
        if (result == 3) {
            return 3
        } else {
            return
        }

    }
    return 1
}

; From Vicious Attack Loop Function to call only
ViciousBattle(State) {
    if (state == 1) {
        result := AttackVic()

        if (result == 2) {
            return
        } else {
            return 3
        }
    }
    if (state == 2) {
        result := MtnAttackVic()

        if (result == 2) {
            return
        } else {
            return 3
        }
    }
    if (state == 3) {
        result := PepperAttackVic()

        if (result == 2) {
            return
        } else {
            return 3
        }
    }
    return
}