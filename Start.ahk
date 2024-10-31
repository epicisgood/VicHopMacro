#Requires AutoHotkey v2.0
#SingleInstance Force
#Warn VarUnset, Off
SetWorkingDir A_ScriptDir

KeyDelay := 40

Setkeydelay KeyDelay

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

#include %A_ScriptDir%\scripts\

#Include functions.ahk
#Include gui.ahk
#include joinserver.ahk
#Include paths.ahk
#Include timers.ahk
#Include webhook.ahk

GetRobloxClientPos()
pToken := Gdip_Startup()
bitmaps := Map()
bitmaps.CaseSense := 0

#Include %A_ScriptDir%\images\bitmaps.ahk

global ServerAttempts := 0 ; used for joinserver function to Clear ServerIds()
global NightSearchAttempts := 0 ; just for the webhook timer nothing else prob could be merged into 1 var but ya


; Total Report Varaibles maybe used for the future idk
; global ServerJoinCounter := 0
; global NightServersCounter := 0
; global ViciousDeaftedCounter := 0
; global MacroTime := A_TickCount

MainLoop() {
    while (JoinServer() == 2) {
        HyperSleep(350)
    }
    if (NightDetection() == 1) {
        ; global NightServersCounter += 1
        ; global ServerJoinCounter += 1
        global ServerAttempts := 0
        global NightSearchAttempts := 0
        PlayerStatus("Night Detected!!", "0x000000", , false)
        Send "{" Zoomout " 15}"
        global ViciousFeild := 0
        SetTimer(ViciousSpawnLocation, 500)
        if (!StartServerLoop()) {
            return
        }
    } else {
        global ServerAttempts += 1
        global NightSearchAttempts += 1
        ; global ServerJoinCounter += 1
        PlayerStatus("Searching For Night Servers. " NightSearchAttempts "x", "0x1ABC9C", , false, , false)
        return
    }
    if (VicSpawnedDetection("none")) {
        return
    }
    SetTimer(ViciousSpawnLocation, 0)
    if (!ResetCharacterLoop()) {
        return
    }
    SetTimer(ViciousSpawnLocation, 500)
    if LeaveServerEarly()
        return
    if (VicSpawnedDetection("none", false)) {
        return
    }
    PlayerStatus("Going to Pepper Patch.", "0x1F8B4C", , false, , false)
    PepperPatch()
    if (VicSpawnedDetection("pepper")) {
        return
    }
    PlayerStatus("Finished Checking Pepper Patch.", "0x57F287", , false)
    PepperToCannon()
    if LeaveServerEarly()
        return
    if (!CheckFireButton()) {
        SetTimer(ViciousSpawnLocation, 0)
        if !ResetCharacterLoop()
            return
        SetTimer(ViciousSpawnLocation, 500)
    }
    if (VicSpawnedDetection("none"), false) {
        return
    }
    PlayerStatus("Going to Mountain Top Field.", "0x1F8B4C", , false, , false)
    MountainTop()
    if (VicSpawnedDetection("mountain")) {
        return
    }
    PlayerStatus("Finished Checking Mountain Top Field.", "0x57F287", , false)
    if LeaveServerEarly()
        return
    PlayerStatus("Going to Cactus Field.", "0x1F8B4C", , false, , false)
    MountainToCactus()
    if VicSpawnedDetection("cactus") {
        return
    }
    PlayerStatus("Finished Checking Cactus Field.", "0x57F287", , false)
    if LeaveServerEarly()
        return
    PlayerStatus("Going to Rose Field.", "0x1F8B4C", , false, , false)
    CactusToRose()
    sleep 1000
    if VicSpawnedDetection("rose") {
        return
    }
    PlayerStatus("Finished Checking Rose Field.", "0x57F287", , false)
    PlayerStatus("No Vicious bees found.", "0x7F8C8D", , false, , false)
    SetTimer(ViciousSpawnLocation, 0)

    ; BeesmasInterupt()

}

JoinServer() {
    loadroblox()
    global SeverAttempts
    if (SeverAttempts == 20) {
        global SeverAttempts := 0
        CloseRoblox()
        GetServerIds()
    } else {
        send "{esc}{l}{Enter}"
    }
    if (GameLoaded()) {
        HyperSleep(850)
        return 1
    } else {
        return 2
    }
}
loadroblox() {
    joinrandomserver()
    loop 15 {
        if GetRobloxHWND() {
            ActivateRoblox()
            return
        }
        ; PlayerStatus("Detected Roblox Open", "0x00a838", ,false, ,false)    }
        if (A_Index = 15) {
            PlayerStatus("No Roblox Found", "0xc500ec", , false, , false)
            GetServerIds()
            return
        }
        Sleep 1000
    }
}



