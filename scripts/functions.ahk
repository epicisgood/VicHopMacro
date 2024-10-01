; nm_gotoRamp() {
;     nm_Walk(5, Wkey)
;     nm_Walk(9.2*HiveSlot-4, RightKey)
; }

HyperSleep(ms) {
    static freq := (DllCall("QueryPerformanceFrequency", "Int64*", &f := 0), f)
    DllCall("QueryPerformanceCounter", "Int64*", &begin := 0)
    current := 0, finish := begin + ms * freq / 1000
    while (current < finish) {
        if ((finish - current) > 30000) {
            DllCall("Winmm.dll\timeBeginPeriod", "UInt", 1)
            DllCall("Sleep", "UInt", 1)
            DllCall("Winmm.dll\timeEndPeriod", "UInt", 1)
        }
        DllCall("QueryPerformanceCounter", "Int64*", &current)
    }
}

nm_Walk(tiles, MoveKey1, MoveKey2 := 0) { ; string form of the function which holds MoveKey1 (and optionally MoveKey2) down for 'tiles' tiles
    Send("{" MoveKey1 " down}")
    MoveKey2 ? Send("{" MoveKey2 " down}") : ""
    Walk(tiles)
    Send("{" MoveKey1 " up}")
    MoveKey2 ? Send("{" MoveKey2 " up}") : ""
}

GetpBMScreen(pX := 0, pY := 0, pWidth := 0, pHeight := 0) {
    hwnd := GetRobloxHWND()
    GetRobloxClientPos(hwnd)
    offsetY := GetYOffset()

    ; Use global variables if the parameters are not provided (i.e., are 0)
    global windowX, windowY, windowWidth, windowHeight
    x := (pX != 0) ? pX : windowX
    y := (pY != 0) ? pY : windowY
    width := (pWidth != 0) ? pWidth : windowWidth
    height := (pHeight != 0) ? pHeight : windowHeight

    return Gdip_BitmapFromScreen(x "|" y + offsetY "|" width "|" height)
}

GameLoaded() {
    loadingColor := 0x2257A8
    startTime := A_TickCount
    ActivateRoblox()
    ; every 300ms all of this happens no way!
    loop {
        if (A_TickCount - startTime >= 14000 || A_TickCount - startTime >= 20000) {
            pBMScreen := GetpBMScreen()
            if (Gdip_ImageSearch(pBMScreen, bitmaps["GameLoadingBee"], , , , , , 15) = 1 || A_TickCount - startTime >= 27000) {
                CloseRoblox()
                Gdip_DisposeImage(pBMScreen)
                return 0
            }
            Gdip_DisposeImage(pBMScreen)
        }
        
        color := PixelGetColor(458, 151)
        if (color = loadingColor) {
            break
        }
        
        if (Mod(A_TickCount - startTime, 300) = 0) {
            pBMScreen := GetpBMScreen()
            for i, k in ["GameRestricted", "GamePermission"] {
                if (Gdip_ImageSearch(pBMScreen, bitmaps[k], , , , , , 10) = 1) {
                    CloseRoblox()
                    Gdip_DisposeImage(pBMScreen)
                    return 0
                }
            }
            Gdip_DisposeImage(pBMScreen)
        }

        HyperSleep(300)  
    }

    loop {
        color := PixelGetColor(458, 151)
        if (color != loadingColor) {
            break
        }
        HyperSleep(500)
    }

    return 1
}

global current_hive := 1

StartServerLoop() {
    ; 2 means player could not reset character correctly
    ; 0 means failure at claiming hive
    ; 1 means success at hive
    StartServer() {
        global current_hive
        send "{" RotRight " 1}"
        Walk(3)
        nm_Walk(2, Dkey)
        nm_Walk(23, WKey)
        send "{" RotLeft " 1}"

        current_hive := FindHiveSlot()
        if (current_hive == 0) {
            PlayerStatus("Hive not found, retrying.", "0xE91E63", , false)
            send "{" EscKey "}{" Rkey "}{" EnterKey "}"
            HyperSleep(500)
            HealthDetection()
            send "{" Zoomout " 15}"
            return 0
        }

        if (!ResetCharacterLoop()) {
            return 2
        }
        return 1
    }

    attempts := 0
    result := StartServer()
    while (result == 0) {
        attempts++
        if (attempts == 2) {
            PlayerStatus("Leaving server: Failed claiming hive after 4 attempts.", "0x7F8C8D", , true)
            return 0
        } else if (result == 2) {
            return 0
        }
        result := StartServer()
    }
    return 1
}

NightDetection() {
    pBMScreen := GetpBMScreen(windowX + windowWidth // 2 - 200, windowY + offsetY, 400, windowHeight)
    for i, k in ["nightground", "nightground2"
    ] {
        if (Gdip_ImageSearch(pBMScreen, bitmaps[k], , , , , , 6) = 1) {
            Gdip_DisposeImage(pBMScreen)
            return 1 ; returns 1
        }
    }
    Gdip_DisposeImage(pBMScreen)
    return 0

}

; returns the current hive which is 1-6 or fails with a return 0 if no hives found
FindHiveSlot() {

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
            PlayerStatus("Claimed hiveslot: " current_hive, "0x9B59B6", , false)
            Gdip_DisposeImage(pBMScreen)
            return current_hive
        }
        Gdip_DisposeImage(pBMScreen)
    }

    global current_hive
    current_hive := 1
    if (ClaimHive(current_hive)) {
        return current_hive
    }
    loop 5 {
        nm_Walk(9, AKey)
        HyperSleep(500)
        current_hive++
        if (ClaimHive(current_hive)) {
            return current_hive
        }
    }
    return 0
}

; returns 1 if character successfuly reseted and currently is at red cannon
; returns 0 if failed
ResetCharacterLoop() {

    ResetCharacter() {
        send "{" EscKey "}{" Rkey "}{" EnterKey "}"
        Sleep(500)
        HealthDetection()
        Send "{" Zoomout " 15}"
        Send "{" RotDown " 1}"
        if (CheckNotHiveSpawn() == 1) {
            Send "{" RotUp " 1}"
            GoToRamp2()
            RedCannon()
            if (!CheckFireButton()) {
                return 0
            }
        } else {
            Send "{" RotUp " 1}"
            RotateHiveCorrection()
            GoToRamp()
            RedCannon()
            if (!CheckFireButton()) {
                return 0
            }
        }
        return 1
    }

    Attempts := 0
    loop {
        Result := ResetCharacter()
        if (Result == 1) {
            break
        }
        Attempts++
        if (Attempts > 6) {
            PlayerStatus("Leaving server: Too many reset attempts.", "0x7F8C8D", , true)
            return 0
        }
    }

    return 1
}

HealthDetection() {
    ; Natro Macro reset thingy
    n := 0
    while ((n < 2) && (A_Index <= 200)) {
        Sleep 100
        pBMScreen := GetpBMScreen(windowX "|" windowY "|" windowWidth "|50")
        n += (Gdip_ImageSearch(pBMScreen, bitmaps["emptyhealth"], , , , , , 10) = (n = 0))
        Gdip_DisposeImage(pBMScreen)
    }
    Sleep 1000

    return 1

}

; Checks if the player did NOT spawn at hive
CheckNotHiveSpawn() {
    HyperSleep(300)
    pBMScreen := GetpBMScreen(windowX + windowWidth // 2 - 200, windowY + windowHeight - 125, 400, 125)
    ; Gdip_SaveBitmapToFile(pBMScreen, "ss.png")

    for i, k in ["NotHiveSpawn", "NotHiveSpawnNight"
    ] {
        if (Gdip_ImageSearch(pBMScreen, bitmaps[k], , , , , , 15) = 1) {
            Gdip_DisposeImage(pBMScreen)
            return 1
        }
    }

    Gdip_DisposeImage(pBMScreen)
    return 0

}

RotateHiveCorrection() {
    pBMScreen := GetpBMScreen(windowX + windowWidth // 2 - 200, windowY + offsetY, 400, windowHeight)

    for i, k in ["nightground", "nightground2", "ground", "ground2", "NightTransitionGround"
    ] {
        if (Gdip_ImageSearch(pBMScreen, bitmaps[k], , , , , , 6) = 1) {
            Gdip_DisposeImage(pBMScreen)
            return 1
        }
    }

    Gdip_DisposeImage(pBMScreen)
    send "{" RotLeft " 4}"
    return 0

}

GoToRamp() {
    global current_hive
    nm_Walk(5, Wkey)
    nm_Walk(9.2 * current_hive - 4, Dkey)
    PressSpace()
    nm_Walk(3, Dkey)
    HyperSleep(1000)

}
GoToRamp2() {
    Send "{" Dkey " down}"
    nm_Walk(24.5, WKey)
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

PressSpace() {
    Send "{" SpaceKey " down}"
    HyperSleep(100)
    Send "{" SpaceKey " up}"
}

CheckFireButton() {
    HyperSleep(400)
    pBMScreen := GetpBMScreen(windowX + windowWidth // 2 - 200, windowY + offsetY, 400, 125)
    if (Gdip_ImageSearch(pBMScreen, bitmaps["redcannon"], , , , , , 2, , 2) = 1) {
        Gdip_DisposeImage(pBMScreen)
        return 1
    }
    Gdip_DisposeImage(pBMScreen)
    return 0
}

; Checks the ⚠️ emoji to see if vicious bee is summoned
ActiveVicious() {

    Send "{" SlashKey "}" "{" EnterKey "}"
    Sleep(100)

    pBMScreen := GetpBMScreen()
    if (Gdip_ImageSearch(pBMScreen, bitmaps["ViciousActive"], , , , , , 10)) {
        Gdip_DisposeImage(pBMScreen)
        return 1
    }
    Gdip_DisposeImage(pBMScreen)
    return 0
}

; Feild is where player where go to fight vicious bee again
AttackVicLoop(feild) {
    if !ActiveVicious()
        return 0
    if (AttackVic() == 0) {
        switch feild {
            case "pepper":
                if !ResetCharacterLoop()
                    return 1
                PepperPatch()
                AttackVic()
            case "mountain":
                if !ResetCharacterLoop()
                    return 1
                MountainTop()
                Send "{" RotLeft " 2}"
                AttackVic()
            case "cactus":
                if !ResetCharacterLoop()
                    return 1
                Cactus()
                AttackVic()
            case "rose":
                if !ResetCharacterLoop()
                    return 1
                Rose()
                Send "{" RotRight " 4}"
                AttackVic()
        }
    }
    return 1
}
Dead := false

; returns 2 if timeout reached
; returns 1 if vicious bee killed
; returns 0 if player died
AttackVic() {
    PlayerStatus("Attacking: Vicious Bee!", "0xe67e22", , false, , false)
    StartTime := 0
    StartTime := A_TickCount

    global Dead
    Dead := false

    while (!TadaViciousDefeated()) {
        ElapsedTime := A_TickCount - StartTime
        if (ElapsedTime > 240000) { ;; 3 minutes to kill vicious bee
            PlayerStatus("Timeout exceeded: Too long to kill vicious bee", "0x000000", , false)
            return 2
        }
        if (Dead == true) {
            return 0
        }
        loop 2 {
            PlayerDied()
            Send "{" WKey " down}"
            Walk(4)
            PlayerDied()
            Send "{" WKey " up}"
            Walk(5)
        }
        loop 2 {
            PlayerDied()
            Send "{" AKey " down}"
            Walk(4)
            PlayerDied()
            Send "{" AKey " up}"
            Walk(5)
        }
        loop 2 {
            PlayerDied()
            Send "{" SKey " down}"
            Walk(4)
            PlayerDied()
            Send "{" SKey " up}"
            Walk(5)
        }
        loop 2 {
            PlayerDied()
            Send "{" Dkey " down}"
            Walk(4)
            PlayerDied()
            Send "{" Dkey " up}"
            Walk(5)
        }
    }
    Sleep(5000)

    PlayerStatus("Vicious bee has been defeated!", "0x71368A", , true)

    return 1
}

PlayerDied() {
    global Dead
    pBMScreen := GetpBMScreen()
    if (Gdip_ImageSearch(pBMScreen, bitmaps["YouDied"], , , , , , 2)) {
        Dead := true
        PlayerStatus("Died during battle: What an embarrassment", "0x2C3E50", , false)
        Gdip_DisposeImage(pBMScreen)
        return 1
    }
    Gdip_DisposeImage(pBMScreen)
    return 0
}

; Returns 1 if vicious bee was detected
; Returns 0 if no vicious bee was found
; Checks the 🎉 emoji to see if vicious bee is defeated
TadaViciousDefeated() {
    Send "{" SlashKey "}" "{" EnterKey "}"
    global Dead
    pBMScreen := GetpBMScreen(windowX + windowWidth * 0.70, windowY, windowWidth * 0.30, windowHeight * 0.30)

    if (Gdip_ImageSearch(pBMScreen, bitmaps["TadaViciousDead"], , , , , , 5)) {
        Gdip_DisposeImage(pBMScreen)
        return 1
    }
    Gdip_DisposeImage(pBMScreen)
    return 0

}

LeaveServerEarly() {
    if (TadaViciousDefeated() || ActiveVicious()) {
        PlayerStatus("Leaving server: Vicious bee Defeated Already", "0x206694", , false)
        return 1
    }
}
