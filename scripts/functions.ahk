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


nm_KeyVars(){
    return
	(
	'
    WKey := "' WKey '" ; w
    AKey := "' AKey '" ; a
    SKey := "' SKey '" ; s
    Dkey := "' Dkey '" ; d
    RotLeft := "' RotLeft '" ; ,
    RotRight := "' RotRight '" ; .
    RotUp := "' RotUp '" ; PgUp
    RotDown := "' RotDown '" ; PgDn
    ZoomIn := "' ZoomIn '" ; i
    ZoomOut := "' ZoomOut '" ; o
    Ekey := "' Ekey '" ; e
    Rkey := "' Rkey '" ; r
    Lkey := "' Lkey '" ; l
    EscKey := "' EscKey '" ; Esc
    EnterKey := "' EnterKey '" ; Enter
    SpaceKey := "' SpaceKey '" ; Space
    SlashKey := "' SlashKey '" ; /
    '
	)
}

nm_Walk(tiles, MoveKey1, MoveKey2:=0){ ; string form of the function which holds MoveKey1 (and optionally MoveKey2) down for 'tiles' tiles, not to be confused with the pure form in nm_createWalk below
	return
	(
	'Send "{' MoveKey1 ' down}' (MoveKey2 ? '{' MoveKey2 ' down}"' : '"') '
	Walk(' tiles ')
	Send "{' MoveKey1 ' up}' (MoveKey2 ? '{' MoveKey2 ' up}"' : '"')
	)
}


nm_createWalk(movement, name:="", vars:="") ; this function generates the 'walk' code and runs it for a given 'movement' (AHK code string), using movespeed correction if 'NewWalk' is enabled and legacy movement otherwise
{
	; F13 is used by 'natro_macro.ahk' to tell 'walk' to complete a cycle
	; F14 is held down by 'walk' to indicate that the cycle is in progress, then released when the cycle is finished
	; F16 can be used by any script to pause / unpause the walk script, when unpaused it will resume from where it left off

	DetectHiddenWindows 1 ; allow communication with walk script
    MoveSpeedNum := IniRead("settings.ini", "Settings", "movespeed")
    
	script :=
	(
	'
    #SingleInstance Off
    #NoTrayIcon
    ProcessSetPriority("AboveNormal")
    Setkeydelay ' KeyDelay '
    KeyHistory 0
    ListLines 0
    OnExit(ExitFunc)

    #Include "%A_ScriptDir%\lib"
    #Include "Gdip_All.ahk"
    #Include "Gdip_ImageSearch.ahk"
    #Include "Roblox.ahk"
	

	; #Include Walk.ahk performs most of the initialisation, i.e. creating bitmaps and storing the necessary functions
	; MoveSpeedNum must contain the exact in-game movespeed without buffs so the script can calculate the true base movespeed
	
    pToken := Gdip_Startup()
    bitmaps := Map()
    bitmaps.CaseSense := 0
	
    #Include "Walk.ahk"
    movespeed := ' MoveSpeedNum '
    both            := (Mod(movespeed*1000, 1265) = 0) || (Mod(Round((movespeed+0.005)*1000), 1265) = 0)
    hasty_guard     := (both || Mod(movespeed*1000, 1100) < 0.00001)
    gifted_hasty    := (both || Mod(movespeed*1000, 1150) < 0.00001)
    base_movespeed  := round(movespeed / (both ? 1.265 : (hasty_guard ? 1.1 : (gifted_hasty ? 1.15 : 1))), 0)


    
	'

	'
	offsetY := ' GetYOffset() '

	' nm_KeyVars() '
	' vars '

	start()
	return

	nm_Walk(tiles, MoveKey1, MoveKey2:=0)
	{
		Send "{" MoveKey1 " down}" (MoveKey2 ? "{" MoveKey2 " down}" : "")
		' ('Walk(tiles)') '
		Send "{" MoveKey1 " up}" (MoveKey2 ? "{" MoveKey2 " up}" : "")
	}

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

	F13::
		start(hk?)
		{
			Send "{F14 down}"
			' movement '
			Send "{F14 up}"
		}

	F16::
	{
		static key_states := Map(Dkey,0, AKey,0, WKey,0, SKey,0, SpaceKey,0)
		if A_IsPaused
		{
			for k,v in key_states
				if (v = 1)
					Send "{" k " down}"
		}
		else
		{
			for k,v in key_states
			{
				key_states[k] := GetKeyState(k)
				Send "{" k " up}"
			}
		}
		Pause -1
	}

	ExitFunc(*)
	{
		Send "{' Dkey ' up}{' AKey ' up}{' WKey ' up}{' SKey ' up}{' SpaceKey ' up}{F14 up}"
		try Gdip_Shutdown(pToken)
	}
	'
	) ; this is just ahk code, it will be executed as a new script

    shell := ComObject("WScript.Shell")
    exec := shell.Exec('"' A_AhkPath '" /script /force *')
    exec.StdIn.Write(script)
    exec.StdIn.Close()

	if WinWait("ahk_class AutoHotkey ahk_pid " exec.ProcessID, , 2) {
		DetectHiddenWindows 0
		currentWalk.pid := exec.ProcessID
		
	}
	else {
		DetectHiddenWindows 0
		return 0
	}
}


nm_endWalk() ; this function ends the walk script
{
	global currentWalk
	DetectHiddenWindows 1
	try WinClose "ahk_class AutoHotkey ahk_pid " currentWalk.pid
	DetectHiddenWindows 0
	currentWalk.pid := currentWalk.name := ""
	; if issues, we can check if closed, else kill and force keys up
}

GetpBMScreen(pX := 0, pY := 0, pWidth := 0, pHeight := 0) {
    hwnd := GetRobloxHWND()
    GetRobloxClientPos(hwnd)
    offsetY := GetYOffset()

    global windowX, windowY, windowWidth, windowHeight
    x := (pX != 0) ? pX : windowX
    y := (pY != 0) ? pY : windowY
    width := (pWidth != 0) ? pWidth : windowWidth
    height := (pHeight != 0) ? pHeight : windowHeight

    return Gdip_BitmapFromScreen(x "|" y + offsetY "|" width "|" height)
}


global counter := 0 
GameLoaded() {
    global BSSLoadTime
    WinMaximize(GetRobloxHWND())

    loop RobloxLoadTime {
        if GetRobloxHWND() {
            ; PlayerStatus("Detected Roblox Open", "0x00a838", ,false, ,false)   
            ActivateRoblox()
            break
        }
        if (A_Index = RobloxLoadTime) {
            PlayerStatus("No Roblox Found", "0xc500ec", , false, , true) ; change to false later
            if (WinExist("Roblox ahk_exe RobloxPlayerInstaller.exe") || WinExist("Bloxstrap")){
                PlayerStatus("Installing roblox updates..", "0x2f00ff", ,false)
                while (WinExist("Roblox ahk_exe RobloxPlayerInstaller.exe")){
                    Sleep 1000
                    if (A_Index == 120){
                        PlayerStatus("Installing roblox update failed. Killing and trying again.", "0x2f00ff", ,false)
                        try WinKill("Roblox")
                        ; global ChangeServer := true
                        sleep 2000
                        return 0
                    }
                }
                PlayerStatus("Finished roblox updates..", "0x2f00ff", ,false)
            }
            CloseRoblox()
            sleep 5000
            ; global ChangeServer := true
            return 0
        }
        Sleep 1000
    }

    counter := 0
    ;STAGE 2 - wait for Blue loading screen (or loaded game)
    loop {
        ActivateRoblox()
        pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + 30 "|" windowWidth "|" windowHeight - 30)
        if Mod(A_Index, BSSLoadTime // 2){
            MouseMove windowX + windowWidth//4, windowY + windowHeight//4
        }
        if (Gdip_ImageSearch(pBMScreen, bitmaps["robloxlogin"] , , , , , , 25) = 1 || Gdip_ImageSearch(pBMScreen, bitmaps["robloxsignup"] , , , , , , 25) = 1) {
            PlayerStatus("Logging back into roblox app", "0xc161f8", ,false)
            Gdip_DisposeImage(pBMScreen)
            run "https://www.roblox.com/games/1537690962/Bee-Swarm-Simulator"
            Sleep 15000
            pBMScreen := GetpBMScreen()
            if (Gdip_ImageSearch(pBMScreen, bitmaps["playbutton"], &OutputList, , , , , 25, ,3) = 1) {
                coords := StrSplit(OutputList, ",")
                MouseMove coords[1], coords[2]
                Sleep 1000
                Click
                Click
                Sleep 15000
            }
            Gdip_DisposeImage(pBMScreen)
    
            for hwnd in WinGetList(,, "Program Manager")
                {
                    p := WinGetProcessName("ahk_id " hwnd)
                    if (InStr(p, "Roblox") || InStr(p, "AutoHotkey"))
                        continue ; skip roblox and AHK windows
                    title := WinGetTitle("ahk_id " hwnd)
                    if (title = "")
                        continue ; skip empty title windows
                    s := WinGetStyle("ahk_id " hwnd)
                    if ((s & 0x8000000) || !(s & 0x10000000))
                        continue ; skip NoActivate and invisible windows
                    s := WinGetExStyle("ahk_id " hwnd)
                    if ((s & 0x80) || (s & 0x40000) || (s & 0x8))
                        continue ; skip ToolWindow and AlwaysOnTop windows
                    try
                    {
                        WinActivate "ahk_id " hwnd
                        WinMaximize("ahk_id " hwnd)
                        Sleep 500
                        Send "^{w}"
                    }
                    break
                }    
            return 0
        }

        if !GetRobloxClientPos() {
            PlayerStatus("Disconnected from roblox", "0xfa7900", ,false, ,false)
            Gdip_DisposeImage(pBMScreen)
            return 0
        }
        If (Gdip_ImageSearch(pBMScreen, bitmaps["loading"], , , , , 150, 4) = 1) {
            Gdip_DisposeImage(pBMScreen)
            ; PlayerStatus("Detected BSS Loading Screen", "0x0060c0", ,false, ,false)
            break
        }
        if (Gdip_ImageSearch(pBMScreen, bitmaps["science"], , , , , 150, 2) = 1) {
            Gdip_DisposeImage(pBMScreen)
            ; PlayerStatus("Detected BSS Loaded", "0x34495E", ,false, ,false)
            return 1
        }
        if (Gdip_ImageSearch(pBMScreen, bitmaps["disconnected"], , , , , , 2) = 1) {
            Gdip_DisposeImage(pBMScreen)
            PlayerStatus("Disconnected join error", "0xfa7900", ,false, ,false)
            return 0
        }
        if (Gdip_ImageSearch(pBMScreen, bitmaps["X"], &OutputList , , , , , 5) = 1) {
            coords := StrSplit(OutputList, ",")
            MouseMove coords[1], coords[2]+60
            Sleep 1000
            Click
            Click
        }
        ; InGame Errors Detection
        Gdip_DisposeImage(pBMScreen)
        pBMScreen := GetpBMScreen(windowX + windowWidth * 0.4, windowY + windowHeight - windowHeight * 0.4, windowWidth * 0.2, windowHeight // 2)
        if (Gdip_ImageSearch(pBMScreen, bitmaps["GameRestricted"], , , , , , 15) = 1) {
            Gdip_DisposeImage(pBMScreen)
            PlayerStatus("Experience is restricted", "0xaaf861", ,false, ,false)
            return 0
        }
        if (Gdip_ImageSearch(pBMScreen, bitmaps["GameFull"] , , , , , , 15) = 1) {
            Gdip_DisposeImage(pBMScreen)
            PlayerStatus("Experience is full", "0x61f8f8", ,false, ,false)
            return 0
        }
        if (Gdip_ImageSearch(pBMScreen, bitmaps["UnknownStatus"] , , , , , , 15) = 1) { ; this is all i need left 
            Gdip_DisposeImage(pBMScreen)
            PlayerStatus("Unknown status", "0xc3f861", ,false, ,false)
            return 0
        }
        if (Gdip_ImageSearch(pBMScreen, bitmaps["SystemError"] , , , , , , 15) = 1) {
            Gdip_DisposeImage(pBMScreen)
            PlayerStatus("Roblox SystemError", "0x000986", ,false, ,false)
            return 0
        }
        if (A_Index = BSSLoadTime * 2) { ; Default, 15 seconds.
            Gdip_DisposeImage(pBMScreen)
            PlayerStatus("BSS Join Error.", "0xff0000", ,false)
            return 0
        }
        Gdip_DisposeImage(pBMScreen)
        Sleep 1000 // 2 
    }
    global counter := 0
    
    ;STAGE 3 - wait for loaded game
    loop 90 {
        ActivateRoblox()
        if !GetRobloxClientPos() {
            PlayerStatus("Disconnected from roblox", "0xfa7900", ,false, ,false)
            return 0
        }
        pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY+30 "|" windowWidth "|150")
        if (Gdip_ImageSearch(pBMScreen, bitmaps["science"], , , , , 150, 2) = 1) {
            Gdip_DisposeImage(pBMScreen)
            ; PlayerStatus("Detected Game Loaded", "0x34495E", ,false, ,false)
            return 1
        }
        Gdip_DisposeImage(pBMScreen)
        if (A_Index = 90) {
            PlayerStatus("BSS Load Timeout", "0xff0000", ,false, ,false)
            return 0
        }
        Gdip_DisposeImage(pBMScreen)
        Sleep 1000 ; timeout 2 mins, slow loading
    }
    return 0
}



global current_hive := 1

StartServerLoop() {
    ; 0 means failure at claiming hive
    ; 1 means success at hive
    StartServer() {
        global current_hive
		movement :=
		(
		'Send "{' Dkey ' down}"
		Walk(4)
		Send "{' WKey ' down}"
		Walk(20)
		Send "{' Dkey ' up}{' WKey ' up}"'
		)
		nm_createWalk(movement)
		KeyWait "F14", "D T5 L"
		KeyWait "F14", "T20 L"
		nm_endWalk()

        current_hive := FindHiveSlot()
        if (current_hive == 0) {
            PlayerStatus("Hive not found, retrying.", "0xE91E63", , false)
            send "{" EscKey "}{" Rkey "}{" EnterKey "}"
            HyperSleep(500)
            HealthDetection()
            send "{" Zoomout " 15}"
            return 0
        }
        GoToRamp()

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
        movement := nm_Walk(9.2, AKey)
        nm_createWalk(movement)
        KeyWait "F14", "D T5 L"
        KeyWait "F14", "T20 L"
        nm_endWalk()
        current_hive++
        if (ClaimHive(current_hive)) {
            return current_hive
        }
    }
    return 0
}

; NOT beesmas detection.
NightDetection() {
    pBMScreen := GetpBMScreen(windowX + windowWidth // 2 - 200, windowY + offsetY, 400, windowHeight)
    for i, k in ["nightground"] {
        if (Gdip_ImageSearch(pBMScreen, bitmaps[k], , , , , , 6) = 1) {
            if (!Gdip_ImageSearch(pBMScreen, bitmaps["ground"], , , , , , 6) = 1 || !Gdip_ImageSearch(pBMScreen, bitmaps["ground2"], , , , , , 6) = 1) {
                Gdip_DisposeImage(pBMScreen)
                return 1 ; returns 1 night detected
            }
        }
        Gdip_DisposeImage(pBMScreen)
        return 0

    }

}

;Beesmas function
; NightDetection() {
;     pBMScreen := GetpBMScreen(windowX + windowWidth // 2 - 200, windowY + offsetY, 400, windowHeight)
;     for i, k in ["nightground", "nightground2"] {
;         if (Gdip_ImageSearch(pBMScreen, bitmaps[k], , , , , , 6) = 1) {
;             Gdip_DisposeImage(pBMScreen)
;             return 1 ; returns 1
;         }
;     }
;     Gdip_DisposeImage(pBMScreen)
;     return 0

; }


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
            if (!CheckFireButton()) {
                return 0
            }
        } else {
            Send "{" RotUp " 1}"
            ; RotateHiveCorrection()
            GoToRamp()
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
    while ((n < 2) && (A_Index <= 80)) { ; 8 seconds 
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

    for i, k in ["NotHiveSpawn", "NotHiveSpawnNight"] {
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

    ; for i, k in ["nightground", "nightground2", "ground", "ground2", "NightTransitionGround"] { Beesmas ground
    for i, k in ["nightground" "ground", "ground2"] { ; this doesnt even work but im lazy to fix it so im just not gnona use this yay problem solved.. hopefully...
        if (Gdip_ImageSearch(pBMScreen, bitmaps[k], , , , , , 16) = 1) {
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
    movement :=
    (
    '
    nm_Walk(5, Wkey)
    nm_Walk(9.2 * ' current_hive ' - 4, Dkey)
    ' PressSpace() '
    nm_Walk(3, Dkey)
    nm_Walk(1,Wkey)
    nm_Walk(5,Dkey)
    '
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T20 L"
    nm_endWalk()

}
GoToRamp2() {
    movement := 
    (
    '
    Send "{" Dkey " down}"
    nm_Walk(25, WKey)
    Walk(10)
    Send "{" Dkey " up}"
    Send "{" SpaceKey " down}"
    Send "{" Dkey " down}"
    Walk(1)
    Send "{" SpaceKey " up}"
    Walk(1)
    Send "{" Dkey " up}"
    nm_Walk(2,Wkey)
    nm_Walk(8,Dkey)
    '
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T20 L"
    nm_endWalk()
}



glider() {
    return 
    (
        '
        Send "{" SpaceKey " down}"
        HyperSleep(100)
        Send "{" SpaceKey " up}"
        HyperSleep(100)

        Send "{" SpaceKey " down}"
        HyperSleep(100)
        Send "{" SpaceKey " up}"
        HyperSleep(100)

        Send "{" SpaceKey " down}"
        HyperSleep(100)
        Send "{" SpaceKey " up}"
    '
    )
}

PressSpace() {
    return 
    (
        '
    Send "{" SpaceKey " down}"
    HyperSleep(100)
    Send "{" SpaceKey " up}"
    '
    )
}

CheckFireButton() {
    HyperSleep(500)
    pBMScreen := GetpBMScreen(windowX + windowWidth // 2 - 200, windowY + offsetY, 400, 125)
    if (Gdip_ImageSearch(pBMScreen, bitmaps["redcannon"], , , , , , 2, , 2) = 1) {
        Gdip_DisposeImage(pBMScreen)
        return 1
    }
    Gdip_DisposeImage(pBMScreen)
    return 0
}

; Checks the ⚠️ emoji to see if vicious bee is summoned
; ActiveVicious() {

;     Send "{" SlashKey "}" "{" EnterKey "}"
;     Sleep(100)

;     pBMScreen := GetpBMScreen()
;     if (Gdip_ImageSearch(pBMScreen, bitmaps["ViciousActive"], , , , , , 10)) {
;         Gdip_DisposeImage(pBMScreen)
;         return 1
;     }
;     Gdip_DisposeImage(pBMScreen)
;     return 0
; }

; field is where player where go to fight vicious bee again
AttackVicLoop(field) {
    if (field == "rose" || field == "spider") {
        Send "{" RotRight " 4}"
    }
    if (field == "pepper"){
        Send "{" RotLeft " 2}"

    }
    if (field == 'mountain') {
        if (AttackVic("mountain") == 0) {
            if !ResetCharacterLoop()
                return 1
            MountainTop()
            AttackVic("mountain")
        }
        return 1
    } else if (AttackVic() == 0) {
        switch field {
            case "pepper":
                if !ResetCharacterLoop()
                    return 1
                PepperPatch()
                AttackVic()
                ; in order mountain would be next

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
            case "spider":
                if !ResetCharacterLoop()
                    return 1
                Spider()
                Send "{" RotRight " 4}"
                AttackVic()
            case "clover":
                if !ResetCharacterLoop()
                    return 1
                Clover()
                AttackVic()
        }
        return 1
    }
}
Dead := false
ViciousLeft := false
; returns 2 if timeout reached or vic bee left for some reason
; returns 1 if vicious bee killed
; returns 0 if player died
AttackVic(field := '') {
    PlayerStatus("Attacking: Vicious Bee!", "0xe67e22", , false, , false)
    StartTime := 0
    StartTime := A_TickCount
    currentMinute := A_Min

    global Dead := false
    global ViciousLeft := false

    while (!TadaViciousDefeated()) {
        ElapsedTime := A_TickCount - StartTime
        if (ElapsedTime > 90000 || ViciousLeft == true) { ;; 1m 30s to kill vicious bee
            PlayerStatus("Took too long to kill vicious bee.", "0x000000", , false)
            return 2
        }
        if (Dead == true) {
            return 0
        }

        if (field == "mountain" && currentMinute <= 14) {
            movement :=
            (
            'Send "{" Dkey " down}"
            Walk(15)
            Send "{" Dkey " up}"
            loop 5 {
                Send "{" SKey " down}"
                Walk(4)
                Send "{" SKey " up}"
            }
            Send "{" AKey " down}"
            Walk(4)
            Send "{" AKey " up}"
            loop 5 {
                Send "{" WKey " down}"
                Walk(4)
                Send "{" WKey " up}"
            }'
            )

        } else {
            movement := 
            (
            '
            loop 2 {
                Send "{" WKey " down}"
                Walk(4)
                Send "{" WKey " up}"
                Walk(5)
            }
            loop 2 {
                Send "{" AKey " down}"
                Walk(4)
                Send "{" AKey " up}"
                Walk(5)
            }
            loop 2 {
                Send "{" SKey " down}"
                Walk(4)
                Send "{" SKey " up}"
                Walk(5)
            }
            loop 2 {
                Send "{" Dkey " down}"
                Walk(4)
                Send "{" Dkey " up}"
                Walk(5)
            }
            '
        )
        }
        nm_createWalk(movement)
        SetTimer(CheckPlayerDied, 500)
        KeyWait "F14", "D T5 L"
        KeyWait "F14", "T20 L"
        nm_endWalk()
        SetTimer(CheckPlayerDied, 0)
    }

    ; global ViciousDeaftedCounter += 1
    Sleep(5000)
    PlayerStatus("Vicious bee has been defeated!", "0x71368A", ,false)
    return 1
}

CheckPlayerDied() {
    global Dead
    global ViciousLeft
    pBMScreen := GetpBMScreen(windowWidth - 400, windowHeight - 125, 400, 125)
    if (Gdip_ImageSearch(pBMScreen, bitmaps["YouDied"], , , , , , 2)) {
        Dead := true
        PlayerStatus("Died during battle: What an embarrassment", "0x2C3E50", , false)
        nm_endWalk()
        Gdip_DisposeImage(pBMScreen)
        return 1
    }
    if (Gdip_ImageSearch(pBMScreen, bitmaps["ViciousLeft"], , , , , , 20)) {
        ViciousLeft := true
        PlayerStatus("Vicious bee left sadly...", "0x4f2663", , false)
        nm_endWalk()
        Gdip_DisposeImage(pBMScreen)
        return 0
    }
    Gdip_DisposeImage(pBMScreen)

}

; Returns 1 if vicious bee was detected
; Returns 0 if no vicious bee was found
; Checks the 🎉 emoji to see if vicious bee is defeated
TadaViciousDefeated() {
    Send "{" SlashKey "}" "{" EnterKey "}"
    pBMScreen := GetpBMScreen(windowX + windowWidth - 500, windowY, 500, 300)
    if (Gdip_ImageSearch(pBMScreen, bitmaps["TadaViciousDead"], , , , , , 10)) {
        Gdip_DisposeImage(pBMScreen)
        return 1
    }
    Gdip_DisposeImage(pBMScreen)
    return 0

}
global Viciousfield := 0
ViciousSpawnLocation() {
    global Viciousfield
    Send "{" SlashKey "}" "{" EnterKey "}"
    pBMScreen := GetpBMScreen(windowX + windowWidth - 500, windowY, 500, 300)
    if (!Gdip_ImageSearch(pBMScreen, bitmaps["ViciousActive"], , , , , , 8)) {
        Gdip_DisposeImage(pBMScreen)
        return 0
    }

    VicSpawned := ["pepper", "mountain", "cactus", "rose", "spider", "clover"]
    ; VicSpawned := ["pepper","pepper2", "mountain", "mountain2", "cactus", "cactus2", "rose", "rose2", "spider","spider2", "clover", "clover2"]
    for i, field in VicSpawned {
        if (Gdip_ImageSearch(pBMScreen, bitmaps["Viciousbee"][field], , , , , , 9)) {
            field := StrReplace(field, "2")
            global Viciousfield := field
            if (Gdip_ImageSearch(pBMScreen, bitmaps["GiftedVicious"], , , , , , 5)){
                PlayerStatus(Viciousfield " Gifted Vicious Was detected!", "0x7004eb")
                Gdip_DisposeImage(pBMScreen)
                return field
            }
            PlayerStatus(Viciousfield " Vicious Was detected!", "0x213fc4")
            Gdip_DisposeImage(pBMScreen)
            return field
        }
    }
    Gdip_DisposeImage(pBMScreen)
    return 0
}

; returns 1 if we need to break out of loop
VicSpawnedDetection(field, reset := true) { ; if we at cannon we dont need to reset
    ViciousSpawnLocation()
    sleep 500
    if (Viciousfield == 0)
        return 0
    if (field == "none" && Viciousfield == "pepper")
        return 0
    pBMScreen := GetpBMScreen(windowWidth - 400, windowHeight - 125, 400, 125)
    if (Gdip_ImageSearch(pBMScreen, bitmaps["ViciousLeft"], , , , , , 20)){
        Gdip_DisposeImage(pBMScreen)
        PlayerStatus("Vicious bee left sadly...", "0x4f2663", , false)
        return 1
    }
    Gdip_DisposeImage(pBMScreen)
    if (Viciousfield == field) {
        AttackVicLoop(Viciousfield)
        return 1
    } else {
        PlayerStatus("Going to " Viciousfield "!", "0x213fc4", , false)
        if (reset == true){
            if !ResetCharacterLoop()
                return 1
        }
        switch Viciousfield {
            case "pepper":
                PepperPatch()
            case "mountain":
                MountainTop()
            case "cactus":
                Cactus()
            case "rose":
                Rose()
            case "spider":
                Spider()
            case "clover":
                Clover()
        }
        
        AttackVicLoop(Viciousfield)
        return 1
        
    }
}

LeaveServerEarly() {
    if (TadaViciousDefeated()) {
        PlayerStatus("Leaving server: Vicious bee Defeated Already", "0x206694", , false)
        return 1
    }
}
