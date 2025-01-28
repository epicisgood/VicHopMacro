#Requires AutoHotkey v2.0
#SingleInstance Force
#Warn VarUnset, Off
SetWorkingDir A_ScriptDir
KeyDelay := 40


; Default RobloxLoadTime = 20, BSSLoadTime = 20
; How many seconds to open Roblox (i would not lower this)
RobloxLoadTime := 20 
; How many seconds from roblox to inside bee swarm (blue loading screen)
BSSLoadTime := 20 

Setkeydelay KeyDelay

GetRobloxClientPos()
pToken := Gdip_Startup()
bitmaps := Map()
bitmaps.CaseSense := 0
currentWalk := {pid:"", name:""} ; stores "pid" (script process ID) and "name" (pattern/movement name)
CoordMode "Mouse", "Screen"
CoordMode "Pixel", "Screen"
SendMode "Event"

WKey := "sc011" ; w
AKey := "sc01e" ; a
SKey := "sc01f" ; s
Dkey := "sc020" ; d
RotLeft := "vkBC" ; ,
RotRight := "vkBE" ; .
RotUp := "sc149" ; PgUp
RotDown := "sc151" ; PgDn
ZoomIn := "sc017" ; i
ZoomOut := "sc018" ; o
Ekey := "sc012" ; e
Rkey := "sc013" ; r
Lkey := "sc026" ; l
EscKey := "sc001" ; Esc
EnterKey := "sc01c" ; Enter
SpaceKey := "sc039" ; Space
SlashKey := "sc035" ; /

#include %A_ScriptDir%\lib\

#Include FormData.ahk
#Include Gdip_All.ahk
#include Gdip_ImageSearch.ahk
#include json.ahk
#Include roblox.ahk
#Include walk.ahk

#Include %A_ScriptDir%\images\
#include bitmaps.ahk
#include %A_ScriptDir%\scripts\

#Include functions.ahk
#Include gui.ahk
#include joinserver.ahk
#Include paths.ahk
#Include timers.ahk
#Include webhook.ahk



ServerAttempts := 1 ; used for joinserver function to Clear ServerIds()
NightSearchAttempts := 0 ; just for the webhook timer nothing else prob could be merged into 1 var but ya

MainLoop() {
    global ServerAttempts, NightSearchAttempts
    while (JoinServer() == 2) {
        HyperSleep(350)
    }
    if (NightDetection() == 1) {
        ServerAttempts := 1
        NightSearchAttempts := 0
        PlayerStatus("Night Detected!!", "0x000000", , false)
        Send "{" Zoomout " 15}"
        global Viciousfield := 0
        if (!StartServerLoop()) {
            return
        }
    } else {
        ServerAttempts += 1
        NightSearchAttempts += 1
        PlayerStatus("Searching For Night Servers. " NightSearchAttempts "x", "0x1ABC9C", , false, , false)
        return
    }
    if (!CheckFireButton()) {
        if !ResetCharacterLoop()
            return
    }
    if LeaveServerEarly()
        return
    if (VicSpawnedDetection("none", false)) {
        return
    }
    PlayerStatus("Going to Pepper Patch.", "0x1F8B4C", , false, , false)
    PepperPatch()
    if LeaveServerEarly()
        return
    if (VicSpawnedDetection("pepper")) {
        return
    }
    PlayerStatus("Finished Checking Pepper Patch.", "0x57F287", , false)
    PepperToCannon()
    if LeaveServerEarly()
        return
    if (!CheckFireButton()) {
        if !ResetCharacterLoop()
            return
    }
    if (VicSpawnedDetection("none"), false) {
        return
    }
    PlayerStatus("Going to Mountain Top Field.", "0x1F8B4C", , false, , false)
    MountainTop()
    if LeaveServerEarly()
        return
    if (VicSpawnedDetection("mountain")) {
        return
    }
    PlayerStatus("Finished Checking Mountain Top Field.", "0x57F287", , false)
    PlayerStatus("Going to Cactus Field.", "0x1F8B4C", , false, , false)
    MountainToCactus()
    if LeaveServerEarly()
        return
    if VicSpawnedDetection("cactus") {
        return
    }
    PlayerStatus("Finished Checking Cactus Field.", "0x57F287", , false)
    PlayerStatus("Going to Rose Field.", "0x1F8B4C", , false, , false)
    CactusToRose()
    if VicSpawnedDetection("rose") {
        return
    }
    PlayerStatus("Finished Checking Rose Field.", "0x57F287", , false)
    PlayerStatus("No Vicious bees found.", "0x7F8C8D", , false, , false)
    BeesmasInterupt()

    ClearRoblox()

}


JoinServer() {
    global ServerAttempts
    ProccesCounter := 1
    for p in ComObjGet("winmgmts:").ExecQuery("SELECT * FROM Win32_Process WHERE Name LIKE '%Roblox%' OR CommandLine LIKE '%ROBLOXCORPORATION%'")
        ProccesCounter++
    if (Mod(ProccesCounter, 6) == 0) {
        ClearRoblox()
        sleep 1000
    }
    loadroblox()
    if (Mod(ServerAttempts, 20) == 0) {
        ServerAttempts := 1
        GetServerIds()
        CloseRoblox()
        HyperSleep(2000)
    } else {
        SetKeyDelay 250
        if GetRobloxClientPos()
            send "{esc}{l}{Enter}"
        global KeyDelay
        SetKeyDelay KeyDelay
        HyperSleep(2000)
    }
    if (GameLoaded()) {
        HyperSleep(850)
        return 1
    } else {
        return 2
    }
}
loadroblox() {
    global RobloxLoadTime
    joinrandomserver()
    loop RobloxLoadTime {
        if GetRobloxHWND() {
            ActivateRoblox()
            return
        }
        ; PlayerStatus("Detected Roblox Open", "0x00a838", ,false, ,false)    }
        if (A_Index = RobloxLoadTime) {
            PlayerStatus("No Roblox Found", "0xc500ec", , false, , true) ; change to false later
            if (WinExist("Roblox ahk_exe RobloxPlayerInstaller.exe")){

                PlayerStatus("Installing roblox updates..", "0x2f00ff", ,false)
                while (WinExist("Roblox ahk_exe RobloxPlayerInstaller.exe")){
                    Sleep 1000
                }
                PlayerStatus("Finished roblox updates..", "0x2f00ff", ,false)
            }
            ClearRoblox()
            sleep 5000
            return
        }
        Sleep 1000
    }
}
ElevateScript() {
	try
		file := FileOpen("scripts\functions.ahk", "a")
	catch {
		if (!A_IsAdmin || !(DllCall("GetCommandLine","Str") ~= " /restart(?!\S)"))
			Try RunWait '*RunAs "' A_AhkPath '" /script /restart "' A_ScriptFullPath '"'
		if !A_IsAdmin {
			MsgBox "You must run VichopMacro as administrator in this folder!`nIf you don't want to do this, move the macro to a different folder (e.g. Downloads, Desktop)", "Error", 0x40010
			ExitApp
		}
		; elevated but still can't write, read-only directory?
		MsgBox "You cannot run VichopMacro in this folder!`nTry moving the macro to a different folder (e.g. Downloads, Desktop)", "Error", 0x40010
    }
}
ElevateScript()

