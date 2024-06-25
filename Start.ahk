#Requires AutoHotkey v2.0
#SingleInstance Force

CoordMode "Pixel", "Screen"
SendMode "Event"

#Include scripts\paths.ahk
#Include scripts\functions.ahk
#include scripts\joinserver.ahk

F1:: {
    loop {
        MainLoop()
    }
}

F2:: ExitApp()


MainLoop() {
    JoinServer()
    if (NightDetection() == 1) {
        ZoomOut()
        StartServer()
        if (CheckIfDefeated() == 1) {
            return
        }
    } else {
        return
    }
    KillViciousBees()
    return
}

KillViciousBees() {
    PepperPatch()
    if (Vic_Detect("img/Warning.png") == 1) {
        PepperAttackVic()
        return
    }
    ResetCharacter()
    MountainTop()
    if (Vic_Detect("img/Warning.png") == 1) {
        MtnAttackVic()
        return
    }
    ResetCharacter()
    Rose()
    if (Vic_Detect("img/Warning.png") == 1) {
        AttackVic()
        return
    }
    ResetCharacter()
    Cactus()
    if (Vic_Detect("img/Warning.png") == 1) {
        AttackVic()
        return
    }
}

JoinServer() {
    RunWait('taskkill /F /IM RobloxPlayerBeta.exe')
    RunWait('taskkill /F /IM ApplicationFrameHost.exe')
    joinrandomserver()
    if (DetectLoading(0x2257A8, 25000)) {
        Sleep 750
        return
    } else {
        RunWait('taskkill /F /IM RobloxPlayerBeta.exe')
        RunWait('taskkill /F /IM ApplicationFrameHost.exe')
        JoinServer()
    }
}