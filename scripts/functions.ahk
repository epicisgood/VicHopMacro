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
global KeyDelay

StartServer() {
    global KeyDelay
    global current_hive
    send "{" RotRight " 1}"
    Walk(3)
    Send "{" Dkey " down}"
    Walk(2)
    Send "{" Dkey " up}"
    Send "{" WKey " down}"
    Walk(23)
    Send "{" WKey " up}"
    HyperSleep(50)
    send "{" RotLeft " 1}"
    current_hive := FindHiveSlot()
    if (current_hive = 0) {
        PlayerStatus("Could Not Claim hive retrying..", 15277667, false)
        KeyDelay := 100
        SetKeyDelay 100
        send "{" EscKey "}{" Rkey "}{" EnterKey "}"
        SetKeyDelay KeyDelay
        HyperSleep(500)
        HealthDetection()
        ZoomOut()
        return 3
    }
    if (ResetMainCharacter() == false) {
        return 4
    }
}


StartServerLoop() {
    StartServerAttempts := 0
    ServerVar := StartServer()
    while (ServerVar == 3 || ServerVar == 4) {
        StartServerAttempts++
        if StartServerAttempts == 3 {
            PlayerStatus("leaving server could not claim hive current_hive = 0", 8359053, true)
            return 1
        }

        if ServerVar == 4 {
            PlayerStatus("leaving server reset count went over 4...", 8359053, true)
            return 1
        }
        ServerVar := StartServer()
    }
}

ZoomOut() {
    Send "{" ZoomOuter " 15}"
}


DetectLoading(loadingColor, timeout) {
    startTime := A_TickCount
    loop {
        hwnd := GetRobloxHWND()
        GetRobloxClientPos(hwnd)
        offsetY := GetYOffset()
        pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + offsetY "|" windowWidth "|" windowHeight)

        color := PixelGetColor(458, 151)
        ActivateRoblox()

        if (Gdip_ImageSearch(pBMScreen, bitmaps["GameRestricted"], , , , , , 10) = 1) {
            CloseRoblox(hwnd, pBMScreen)
            return false
        }

        if (Gdip_ImageSearch(pBMScreen, bitmaps["GamePermission"], , , , , , 10) = 1) {
            CloseRoblox(hwnd, pBMScreen)
            return false
        }

        if (color = loadingColor) {
            break
        }

        if (A_TickCount - startTime >= timeout) {
            CloseRoblox(hwnd, pBMScreen)
            return false
        }
        Gdip_DisposeImage(pBMScreen)
        HyperSleep(250)
    }

    Gdip_DisposeImage(pBMScreen)

    loop {
        color := PixelGetColor(458, 151)
        if (color != loadingColor) {
            break
        }
        HyperSleep(500)
    }

    return true
}

CloseRoblox(hwnd, pBMScreen) {
    try WinClose "Roblox"
    for p in ComObjGet("winmgmts:").ExecQuery("SELECT * FROM Win32_Process WHERE Name LIKE '%Roblox%' OR CommandLine LIKE '%ROBLOXCORPORATION%'")
        ProcessClose p.ProcessID

    Gdip_DisposeImage(pBMScreen)

}


NightDetection() {
    hwnd := GetRobloxHWND()
    GetRobloxClientPos(hwnd)
    offsetY := GetYOffset()
    pBMScreen := Gdip_BitmapFromScreen(windowX + windowWidth // 2 - 200 "|" windowY + offsetY "|" 400 "|" windowHeight)

    if (Gdip_ImageSearch(pBMScreen, bitmaps["nightground"], , , , , , 6) = 1 || Gdip_ImageSearch(pBMScreen, bitmaps["nightground2"], , , , , , 6) = 1) {
        Gdip_DisposeImage(pBMScreen)
        return 1
    } else {
        Gdip_DisposeImage(pBMScreen)
        return 0
    }
}

CheckSpawnPos() {
    ZoomOut()
    send "{" ZoomIn " 1}"
    hwnd := GetRobloxHWND()
    GetRobloxClientPos(hwnd)
    offsetY := GetYOffset()
    pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + offsetY "|" windowWidth "|" windowHeight)
    if (Gdip_ImageSearch(pBMScreen, bitmaps["DayLeaderboard"], , , , , , 10) = 1 || Gdip_ImageSearch(pBMScreen, bitmaps["NightLeaderboard"], , , , , , 10) = 1) {
        Gdip_DisposeImage(pBMScreen)
        PlayerStatus("Leaderboard Detected, Rotating..", 9807270, false)
        SetKeyDelay 100
        send "{" RotRight " 4}"
        Sleep(1000)
        send "{" ZoomOuter " 1}"
        SetKeyDelay KeyDelay
        return
    }
    Gdip_DisposeImage(pBMScreen)

}

FindHiveSlot() {
    global current_hive
    current_hive := 1
    if (ClaimHive(current_hive)) {
        return current_hive
    }
    Loop 5 {
        Send "{" AKey " down}"
        Walk(9)
        Send "{" AKey " up}"
        HyperSleep(500)
        current_hive++
        if (ClaimHive(current_hive)) {
            return current_hive
        }
    }
    return 0
}

ClaimHive(current_hive) {

    GetBitmap() {
        hwnd := GetRobloxHWND()
        GetRobloxClientPos(hwnd)
        offsetY := GetYOffset()
        pBMScreen := Gdip_BitmapFromScreen(windowX + windowWidth // 2 - 200 "|" windowY + offsetY "|400|125")
        while ((A_Index <= 20) && (Gdip_ImageSearch(pBMScreen, bitmaps["FriendJoin"], , , , , , 6) = 1)) {
            Gdip_DisposeImage(pBMScreen)
            MouseMove windowX + windowWidth // 2 - 3, windowY + 24
            Click
            MouseMove windowX + 350, windowY + offsetY + 100
            Sleep 500
            pBMScreen := Gdip_BitmapFromScreen(windowX + windowWidth // 2 - 200 "|" windowY + offsetY "|400|125")
        }
        return pBMScreen
    }

    Sleep(500)
    pBMScreen := GetBitmap()
    if (Gdip_ImageSearch(pBMScreen, bitmaps["claimhive"], , , , , , 2, , 6) = 1) {
        Send "{" Ekey " down}"
        Sleep(200)
        Send "{" Ekey " up}"
        PlayerStatus("Claimed hiveslot " current_hive, 10181046, false)
        Gdip_DisposeImage(pBMScreen)
        return current_hive
    }
    Gdip_DisposeImage(pBMScreen)
}

; Function to call ResetCharacter loop use this one
ResetMainCharacter() {
    resetcharattempts := 0
    ResetVar := ResetCharacter()
    while (ResetVar == 2) {
        resetcharattempts++
        if resetcharattempts > 6 {
            PlayerStatus("Failed 6 times going to cannon, leaving server...", 8359053, true)
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
    CheckSpawnPos()
    Send "{" RotDown " 1}"
    if (CheckCocoSpawn() == 1) {
        Send "{" RotUp " 1}"
        GoToRamp2()
        RedCannon()
        if (CheckFireButton() == 0) {
            return 2
        }
    } else {
        Send "{" RotUp " 1}"
        ZoomOut()
        HiveCorrection()
        GoToRamp()
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
    HyperSleep(300)
    hwnd := GetRobloxHWND()
    GetRobloxClientPos(hwnd)
    offsetY := GetYOffset()
    pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + offsetY "|" windowWidth "|" windowHeight)

    search := Gdip_ImageSearch(pBMScreen, bitmaps["DayCoconut"], , , , , , 10) = 1 || Gdip_ImageSearch(pBMScreen, bitmaps["NightCoconut"], , , , , , 10) = 1 || Gdip_ImageSearch(pBMScreen, bitmaps["DayCoconut2"], , , , , , 10) = 1 || Gdip_ImageSearch(pBMScreen, bitmaps["DayCoconut3"], , , , , , 10) = 1

    if (search) {
        ;  || Gdip_ImageSearch(pBMScreen, bitmaps["NightCoconut2"], , , , , , 10) = 1) {
        Gdip_DisposeImage(pBMScreen)
        return 1
    } else {
        Gdip_DisposeImage(pBMScreen)
        return 0
    }
}

HiveCorrection() {
    hwnd := GetRobloxHWND()
    GetRobloxClientPos(hwnd)
    offsetY := GetYOffset()
    pBMScreen := Gdip_BitmapFromScreen(windowX + windowWidth // 2 - 200 "|" windowY + offsetY "|" 400 "|" windowHeight)
    if (Gdip_ImageSearch(pBMScreen, bitmaps["nightground"], , , , , , 6) = 1 || Gdip_ImageSearch(pBMScreen, bitmaps["nightground2"], , , , , , 6) = 1 || Gdip_ImageSearch(pBMScreen, bitmaps["ground"], , , , , , 6) = 1 || Gdip_ImageSearch(pBMScreen, bitmaps["ground2"], , , , , , 6) = 1 || Gdip_ImageSearch(pBMScreen, bitmaps["NightTransitionGround"], , , , , , 6) = 1) {
        Gdip_DisposeImage(pBMScreen)
        return 1
    }
    else {
        Gdip_DisposeImage(pBMScreen)
        PlayerStatus("Ground Not Detected Rotating..", 9807270, false)
        SetKeyDelay 100
        send "{" RotLeft " 4}"
        Setkeydelay KeyDelay
        return 0
    }
}


GoToRamp() {
    global current_hive
    Send "{" WKey " down}"
    Walk(5)
    Send "{" WKey " up}"

    Send "{" Dkey " down}"
    Walk(9 * current_hive)
    Send "{" Dkey " up}"
    Walk(5)
    Send "{" SpaceKey " down}"
    Send "{" Dkey " down}"
    Walk(1)
    Send "{" SpaceKey " up}"
    Walk(1)
    Send "{" Dkey " up}"
    HyperSleep(1000)

}
GoToRamp2() {
    Send "{" WKey " down}{" Dkey " down}"
    Walk(24.5)
    Send "{" WKey " up}"
    Walk(10)
    Send "{" Dkey " up}"
    Send "{" SpaceKey " down}"
    Send "{" Dkey " down}"
    Walk(1)
    Send "{" SpaceKey " up}"
    Walk(1)
    Send "{" Dkey " up}"
    HyperSleep(1000)
}

RedCannon() {
    Send "{" WKey " down}"
    Walk(1)
    Send "{" WKey " up}"

    Send "{" Dkey " down}"
    Walk(5)
    Send "{" Dkey " up}"


}

glider() {
    loop 2 {
        Send "{" SpaceKey " down}"
        HyperSleep(250)
        Send "{" SpaceKey " up}"
    }
}


CheckFireButton() {
    HyperSleep(400)
    hwnd := GetRobloxHWND()
    offsetY := GetYOffset(hwnd)
    pBMScreen := Gdip_BitmapFromScreen(windowX + windowWidth // 2 - 200 "|" windowY + offsetY "|400|125")
    if (Gdip_ImageSearch(pBMScreen, bitmaps["redcannon"], , , , , , 2, , 2) = 1) {
        Gdip_DisposeImage(pBMScreen)
        return 1
    }
    Gdip_DisposeImage(pBMScreen)
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
    PlayerStatus("Attacking Vicious Bee...", 15105570, false)
    global Dead
    Dead := false

    StartTime := 0
    StartTime := A_TickCount
    while (!CheckIfDefeated()) {
        ElapsedTime := A_TickCount - StartTime
        if (ElapsedTime > 150000) { ;; 1 minute and 30 seconds to kill vic bee
            Playerstatus("Timeout exceeded, took to long to kill vicious bee", 0, false)
            return 2
        }
        if (Dead == true) {
            return 3
        }

        Loop 2 {
            PlayerDied()
            Send "{" WKey " down}"
            Walk(4)
            PlayerDied()
            Send "{" WKey " up}"
            PlayerDied()
            Walk(5)
        }
        Loop 2 {
            PlayerDied()
            Send "{" AKey " down}"
            Walk(4)
            PlayerDied()
            Send "{" AKey " up}"
            Walk(5)
            PlayerDied()
        }
        Loop 2 {
            PlayerDied()
            Send "{" SKey " down}"
            Walk(4)
            PlayerDied()
            Send "{" SKey " up}"
            Walk(5)
            PlayerDied()
        }
        Loop 2 {
            PlayerDied()
            Send "{" Dkey " down}"
            Walk(4)
            PlayerDied()
            Send "{" Dkey " up}"
            Walk(5)
            PlayerDied()
        }

    }
    Sleep(5000)
    PlayerStatus("Vicious bee has been defeated!", 7419530, true)

    return 2
}

MtnAttackVic() {
    PlayerStatus("Attacking Vicious Bee...", 11027200, false)
    StartTime := 0
    StartTime := A_TickCount

    global Dead
    Dead := false


    while (!CheckIfDefeated()) {
        ElapsedTime := A_TickCount - StartTime
        if (ElapsedTime > 150000) { ;; 2m 30s to kill vic bee
            Playerstatus("Timeout exceeded, took to long to kill vicious bee", 0, false)
            break
        }
        if (Dead == true) {
            return 3
        }
        PlayerDied()
        Send "{" Dkey " down}"
        Walk(15)
        Send "{" Dkey " up}"
        PlayerDied()
        loop 5 {
            PlayerDied()
            Send "{" SKey " down}"
            Walk(4)
            PlayerDied()
            Send "{" SKey " up}"
        }
        Send "{" AKey " down}"
        Walk(4)
        PlayerDied()
        Send "{" AKey " up}"
        PlayerDied()
        loop 5 {
            Send "{" WKey " down}"
            PlayerDied()
            Walk(4)
            Send "{" WKey " up}"
        }

    }
    Sleep(5000)
    PlayerStatus("Vicious bee has been defeated!", 7419530, true)

    return 2
}

AttackVic() {
    PlayerStatus("Attacking Vicious Bee...", 15844367, false)
    StartTime := 0
    StartTime := A_TickCount

    global Dead
    Dead := false


    while (!CheckIfDefeated()) {
        ElapsedTime := A_TickCount - StartTime
        if (ElapsedTime > 120000) { ;; 1m 30s to kill vic bee
            Playerstatus("Timeout exceeded, took to long to kill vicious bee", 0, false)
            break
        }
        if (Dead == true) {
            return 3
        }
        Loop 2 {
            PlayerDied()
            Send "{" WKey " down}"
            Walk(4)
            PlayerDied()
            Send "{" WKey " up}"
            Walk(5)
        }
        Loop 2 {
            PlayerDied()
            Send "{" AKey " down}"
            Walk(4)
            PlayerDied()
            Send "{" AKey " up}"
            Walk(5)
        }
        Loop 2 {
            PlayerDied()
            Send "{" SKey " down}"
            Walk(4)
            PlayerDied()
            Send "{" SKey " up}"
            Walk(5)
        }
        Loop 2 {
            PlayerDied()
            Send "{" Dkey " down}"
            Walk(4)
            PlayerDied()
            Send "{" Dkey " up}"
            Walk(5)
        }
    }
    Sleep(5000)
    PlayerStatus("Vicious bee has been defeated!", 7419530, true)


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
    } else if PictureImageSearch("img\Defeated.png", 32) {
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