#Requires AutoHotkey v2.0
#SingleInstance Force
#Warn VarUnset, Off
SetWorkingDir A_ScriptDir
KeyDelay := 40

; Default RobloxOpenTime = 20, BSSLoadTime = 5
; Incase you have a really slow pc and need more than 20 seconds to open roblox.
RobloxOpenTime := 20 

; How many seconds from roblox (Joining Server...) to blue loading screen
; Ususually good to change for unkown status or any other ingame erros.
BSSLoadTime := 15

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
SC_LShift:= "sc02a" ; LShift

global data := GetUpdateData()

settingsFile := A_ScriptDir . "\settings.ini"


if (!FileExist(settingsFile)) {
    IniWrite("", settingsFile, "Settings", "url")
    IniWrite("", settingsFile, "Settings", "discordID")
    IniWrite("", settingsFile, "Settings", "movespeed")
    IniWrite(1, settingsFile, "Settings", "Stockings")
    IniWrite(1, settingsFile, "Settings", "Feast")
    IniWrite(1, settingsFile, "Settings", "Candles")
    IniWrite(1, settingsFile, "Settings", "Samovar")
    IniWrite(1, settingsFile, "Settings", "LidArt")

    IniWrite(1, settingsFile, "Settings", "Pepper")
    IniWrite(1, settingsFile, "Settings", "Mountain")
    IniWrite(1, settingsFile, "Settings", "Cactus")
    IniWrite(1, settingsFile, "Settings", "Rose")
    IniWrite(0, settingsFile, "Settings", "Spider")
    IniWrite(0, settingsFile, "Settings", "Clover")

}


#include %A_ScriptDir%\lib\

#Include FormData.ahk
#Include Gdip_All.ahk
#include Gdip_ImageSearch.ahk
#include json.ahk
#Include roblox.ahk
#Include walk.ahk

; All for gui lol
#Include ComVar.ahk
#Include Promise.ahk
#Include WebView2.ahk
#Include WebViewToo.ahk

#Include %A_ScriptDir%\images\
#include bitmaps.ahk
#include %A_ScriptDir%\scripts\

#Include functions.ahk
#Include gui.ahk
#include joinserver.ahk
#Include paths.ahk
#Include timers.ahk
#Include webhook.ahk





NightSearchAttempts := 1

MainLoop() {
    global NightSearchAttempts, data
    while (!JoinServer()) {
        Sleep(500)
    }

    if (!NightDetection()) {
        NightSearchAttempts += 1
        PlayerStatus("Searching For Night Servers. " NightSearchAttempts-1 "x", "0x1ABC9C", , false, , false)
        return
    }

    NightSearchAttempts := 1
    PlayerStatus("Night Detected!!", "0x000000", , false)
    Send "{" Zoomout " 15}"
    
    global ViciousField := "none"
    if (!StartServerLoop()) {
        return
    }

    PepperChecked := IniRead(settingsFile, "Settings", "Pepper", 0)
    MountainChecked := IniRead(settingsFile, "Settings", "Mountain", 0)
    CactusChecked := IniRead(settingsFile, "Settings", "Cactus", 0)
    RoseChecked := IniRead(settingsFile, "Settings", "Rose", 0)
    SpiderChecked := IniRead(settingsFile, "Settings", "Spider", 0)
    CloverChecked := IniRead(settingsFile, "Settings", "Clover", 0)


    if (!CheckFireButton()) {
        if !ResetCharacterLoop()
            return
    }
    openChat()
    if LeaveServerEarly()
        return
    if (VicSpawnedDetection("none", false)) {
        return
    }
    if (PepperChecked){
        PlayerStatus("Going to Pepper Patch.", "0x1F8B4C", , false, , false)
        PepperPatch()
        openChat()
        if LeaveServerEarly()
            return
        if (VicSpawnedDetection("pepper")) {
            return
        }
        PlayerStatus("Finished Checking Pepper Patch.", "0x57F287", , false)
        PepperToCannon()
        openChat()
        if LeaveServerEarly()
            return
        if (!CheckFireButton()) {
            if !ResetCharacterLoop()
                return
        }
        if (VicSpawnedDetection("none", false)) {
            return
        }
    }
    if (MountainChecked){
        PlayerStatus("Going to Mountain Top Field.", "0x1F8B4C", , false, , false)
        MountainTop()
        openChat()
        if LeaveServerEarly()
            return
        if (VicSpawnedDetection("mountain")) {
            return
        }
        PlayerStatus("Finished Checking Mountain Top Field.", "0x57F287", , false)
    }

    if (CactusChecked){
        PlayerStatus("Going to Cactus Field.", "0x1F8B4C", , false, , false)
        if MountainChecked
            MountainToCactus()

        if !MountainChecked {
            if (!CheckFireButton()) {
                if !ResetCharacterLoop()
                    return
            }
            if LeaveServerEarly()
                return
            if (VicSpawnedDetection("none", false)) {
                return
            }
            Cactus()
        }

        openChat()
        if LeaveServerEarly()
            return
        if VicSpawnedDetection("cactus") {
            return
        }
        PlayerStatus("Finished Checking Cactus Field.", "0x57F287", , false)
    }
    if (RoseChecked){
        PlayerStatus("Going to Rose Field.", "0x1F8B4C", , false, , false)
        if CactusChecked
            CactusToRose()

        if !CactusChecked {
            if (!CheckFireButton()) {
                if !ResetCharacterLoop()
                    return
            }
            if LeaveServerEarly()
                return
            if (VicSpawnedDetection("none", false)) {
                return
            }
            Rose()
        }

        openChat()
        if VicSpawnedDetection("rose") {
            return
        }
        PlayerStatus("Finished Checking Rose Field.", "0x57F287", , false)
    }

    if (SpiderChecked){
        PlayerStatus("Going to Spider Field.", "0x1F8B4C", , false, , false)
        if (!CheckFireButton()) {
            if !ResetCharacterLoop()
                return
        }
        if LeaveServerEarly()
            return
        if (VicSpawnedDetection("none", false)) {
            return
        }
        Spider()
        openChat()
        if VicSpawnedDetection("spider") {
            return
        }
        PlayerStatus("Finished Checking Spider Field.", "0x57F287", , false)
    }

    if (CloverChecked){
        PlayerStatus("Going to Clover Field.", "0x1F8B4C", , false, , false)
        if (!CheckFireButton()) {
            if !ResetCharacterLoop()
                return
        }
        if LeaveServerEarly()
            return
        if (VicSpawnedDetection("none", false)) {
            return
        }
        Clover()
        openChat()
        if VicSpawnedDetection("clover") {
            return
        }
        PlayerStatus("Finished Checking Clover Field.", "0x57F287", , false)
    }


    PlayerStatus("No Vicious bees found.", "0x7F8C8D", , false, , false)
    if (data.beesmas){
        BeesmasInterupt()
    }


}

; Returns True = Inside Bee Swarm!
; Returns False = Join Error
JoinServer() {
    global NightSearchAttempts
    joinrandomserver()
    if (Mod(NightSearchAttempts, 20) == 0) {
        GetServerIds(8)
    } 
    if (GameLoaded()) {
        return true
    }

    return false
}

; F3::{
;     GameLoaded()
;     MsgBox("YAY")
; }

; GetServerIds(1)
; F3::{
;     joinrandomserver()
; }


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

ScreenResolution(){
    if (A_ScreenDPI != 96){
        MsgBox "
        (
        Your Display Scale seems to be a value other than 100%. This means the macro will NOT work correctly!
        
        To change this:
        Right click on your Desktop -> Click 'Display Settings' -> Under 'Scale & Layout', set Scale to 100% -> Close and Restart Roblox before starting the macro.
        )", "WARNING!!", 0x1030 " T60"
    }
    
    ; if (A_ScreenHeight > 1080 || A_ScreenWidth > 1920){
    ;     MsgBox "
    ;     (
    ;         Your Resolution is too massive!! Lower it to 1920x1080 or any lower. This means the macro will NOT work correctly!
            
    ;         To change this:
    ;         Right click on your Desktop -> Click 'Display Settings' -> Under 'Scale & Layout', set Resolution to 1920x1080.
    ;         You can also use a Remote Desktop (RDP) to use this macro under or 1920x1080 resolution. For more information I would recommend looking up information on how to macro on an RDP  
    ;         )", "WARNING!!", 0x1030 " T60"
    ;     }
        
    }
    
    
ScreenResolution()
