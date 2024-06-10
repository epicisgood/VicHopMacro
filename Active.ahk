#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
CoordMode, Pixel, Screen ; Set coordinate mode to screen.

#Include scripts\paths.ahk
#Include scripts\libary.ahk

`:: 
    loop {
        if (MainLoop() == 1){
            MainLoop()
        }
    }
return

MainLoop(){
    JoinServer()
    loop {
        if (DragScroll() != 1) {
            WinActivate, ahk_class WINDOWSCLIENT ahk_exe RobloxPlayerBeta.exe
            ZoomOut()
            DragScroll()
        } else {
            break
        }
    }
    ZoomOut()
    ; Check for night color
    nightColor := CheckForNight()
    if (nightColor == 0x000000 || nightColor == 0x404040) {
        MouseClickDrag, middle, 300, 300, 300, 302
        StartServer()
        PepperPatch()
    } else {
        return 1
    }
    ; Check for Vic's presence after specific actions
    if (Vic_Detect("img/Warning.png") == 1) {
        AttackVic()
        return 1
    }
    ResetCharacter()
    MountainTop()
    if (Vic_Detect("img/Warning.png") == 1) {
        AttackVic()
        return 1
    }
    ResetCharacter()
    Rose()
    if (Vic_Detect("img/Warning.png") == 1) {
        AttackVic()
        return 1
    }
    ResetCharacter()
    Cactus()
    if (Vic_Detect("img/Warning.png") == 1) {
        AttackVic()
        return 1
    }

    RunWait, taskkill /F /IM RobloxPlayerBeta.exe, , Hide

return 1 
}

JoinServer(){
    RunWait, taskkill /F /IM RobloxPlayerBeta.exe, , Hide
    RunWait, node "scripts/index.js"
    if DetectLoading(0x2257A8, 60000){
        Sleep, 3000
        return
    } else {
        RunWait, taskkill /F /IM RobloxPlayerBeta.exe, , Hide
        JoinServer()
    }
}

DragScroll() {
    WinActivate, ahk_class WINDOWSCLIENT ahk_exe RobloxPlayerBeta.exe

    MouseClickDrag, middle, 300, 302, 300, 300

    Sleep, 500

    MouseGetPos, xpos, ypos
    if (xpos != 300 || ypos != 300) {
        return 1 ; Drag Success
    }
    MouseClickDrag, right, 300, 302, 300, 300
return 0 ; Drag fail
}

CheckForNight() {
    WinActivate, ahk_class WINDOWSCLIENT ahk_exe RobloxPlayerBeta.exe
    
    WinGetPos, x, y, width, height, ahk_class WINDOWSCLIENT ahk_exe RobloxPlayerBeta.exe
    centerX := x + (width // 2)
    PixelGetColor, color, centerX, 150    
    return color
}

