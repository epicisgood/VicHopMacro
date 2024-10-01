#Requires AutoHotkey v2.0
#SingleInstance Force
#Warn VarUnset, Off
SetWorkingDir A_ScriptDir

KeyDelay := 40

Setkeydelay KeyDelay

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
Lkey := "sc002" ; 1
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

global SeverAttempts := 0
global NightserchesAttempts := 0
MainLoop() {
    while (JoinServer() == 2) {
        HyperSleep(350)
    }
    if (NightDetection() == 1) {
        global SeverAttempts := 0
        global NightserchesAttempts := 0
        PlayerStatus("Night Detected!!", "0x000000", , false)
        Send "{" Zoomout " 15}"
        if (!StartServerLoop()) {
            return
        }
    } else {
        global SeverAttempts += 1
        global NightserchesAttempts += 1
        PlayerStatus("Searching For Night Servers. " NightserchesAttempts "x", "0x1ABC9C", , false, , false)
        return
    }
    PlayerStatus("Going to Pepper Patch.", "0x1F8B4C", , false, , false)

    PepperPatch()
    PlayerStatus("Finished Checking Pepper Patch.", "0x57F287", , false)
    if (AttackVicLoop("pepper")) {
        return
    }
    PepperToCannon()
    if LeaveServerEarly()
        return
    if (!CheckFireButton()) {
        if !ResetCharacterLoop()
            return
    }
    PlayerStatus("Going to Mountain Top Field.", "0x1F8B4C", , false, , false)

    MountainTop()
    PlayerStatus("Finished Checking Mountain Top Field.", "0x57F287", , false)

    if (AttackVicLoop("mountain")) {
        return
    }
    if LeaveServerEarly()
        return
    PlayerStatus("Going to Cactus Field.", "0x1F8B4C", , false, , false)

    MountainToCactus()
    PlayerStatus("Finished Checking Cactus Field.", "0x57F287", , false)
    if AttackVicLoop("cactus") {
        return
    }
    if LeaveServerEarly()
        return
    PlayerStatus("Going to Rose Field.", "0x1F8B4C", , false, , false)
    CactusToRose()
    if AttackVicLoop("rose") {
        return
    }
    PlayerStatus("Finished Checking Rose Field.", "0x57F287", , false)
    PlayerStatus("No Vicious bees found.", "0x7F8C8D", , false, , false)

    BeesmasInterupt()

}

JoinServer() {
    ActivateRoblox()
    global SeverAttempts
    if (SeverAttempts == 20) {
        global SeverAttempts := 0
        CloseRoblox()
        GetServerIds()
    } else {
        send "{esc}{l}{Enter}"
    }
    
    joinrandomserver()
    if (GameLoaded()) {
        HyperSleep(850)
        return 1
    } else {
        return 2
    }
}

