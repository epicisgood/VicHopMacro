﻿#Requires AutoHotkey v2.0
#SingleInstance Force
#Warn VarUnset, Off
SetWorkingDir A_ScriptDir

KeyDelay := 40

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



; Total Report Varaibles maybe used for the future idk
; global ServerJoinCounter := 0
; global NightServersCounter := 0
; global ViciousDeaftedCounter := 0
; global MacroTime := A_TickCount
ServerAttempts := 1 ; used for joinserver function to Clear ServerIds()
NightSearchAttempts := 0 ; just for the webhook timer nothing else prob could be merged into 1 var but ya

MainLoop() {
    global ServerAttempts, NightSearchAttempts
    while (JoinServer() == 2) {
        HyperSleep(350)
    }
    if (NightDetection() == 1) {
        ; global NightServersCounter += 1
        ; global ServerJoinCounter += 1
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
        ; global ServerJoinCounter += 1
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

}

JoinServer() {
    global ServerAttempts
    loadroblox()
    if (Mod(ServerAttempts, 20) == 0) {
        ServerAttempts := 1
        CloseRoblox()
        GetServerIds()
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
    joinrandomserver()
    loop 15 {
        if GetRobloxHWND() {
            ActivateRoblox()
            return
        }
        ; PlayerStatus("Detected Roblox Open", "0x00a838", ,false, ,false)    }
        if (A_Index = 15) {
            PlayerStatus("No Roblox Found", "0xc500ec", , false, , false) ; change to false later
            try WinClose "Bloxstrap" ; for any bloxstrap users to prevent any errors including "waiting for other intances"
            return
        }
        Sleep 1000
    }
}

F3::{
    if (VicSpawnedDetection("pepper")) {
        return
    }
}