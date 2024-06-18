#SingleInstance, Force
SetWorkingDir, %A_ScriptDir%

PepperPatch(){
    SendMode, Input 
    SetKeyDelay, 0, 50 
    Sleep, 300
    Send, {w down}
    Sleep, 400
    Send, {w up}
    Send, {Space down}
    Send, {d down} 
    Sleep, 250
    Send, {Space up}
    Sleep, 3000
    Send, {d up}

    Send, {d down}
    Send, {w down}
    Sleep, 300
    Send, {w up}
    Send, {Space down}
    Sleep, 250
    Send, {Space up}
    Sleep, 1000
    Send, {d up}

    Send, {Space down}
    Send, {w down}
    Sleep, 250
    Send, {Space up}
    Sleep, 300
    Send, {Space down}
    Sleep, 250
    Send, {Space up}
    Sleep, 2750
    Send, {w up}

    Send, {Space down}
    Send, {w down}
    Sleep, 250
    Send, {Space up}
    Send, {Space down}
    Send, {w down}
    Sleep, 250
    Send, {Space up}
    Send, {Space down}
    Send, {Space down}
    Send, {w down}
    Sleep, 250
    Send, {Space up}
    Send, {Space down}
    Send, {w down}
    Sleep, 250
    Send, {Space up}
    Sleep, 3000
    Send, {w up}
    Send, {Space down}
    Send, {w down}
    Sleep, 250
    Send, {Space up}
    Send, {w up}

    ; move to pepper field from next to coconut
    Send, {w down}
    Send, {d down}
    Sleep, 4000
    Send, {w up}
    Send, {d up}
    Send, {Space down}
    Send, {d down}
    Sleep, 250
    Send, {Space up}
    Sleep, 2500
    Sleep, 100
    Send, {d up}
    ;; next to pepper feild
    Send, {a down}
    Sleep, 200
    Send, {a up}

    ;; tries to not glide agasint wall
    Send, {w down}
    Sleep, 1600
    Send, {w up}
    Sleep, 150
    ;;search vicious bee at pepper field rn

    Send, {Space down}
    Send, {d down}
    Sleep, 250
    Send, {Space up}
    Sleep, 2500
    Send, {d up}

    Send, {s down}
    Sleep, 2300
    Send, {s up}
    Sleep, 100

    Send, {a down}
    Sleep, 700
    Send, {a up}
    Sleep, 100

    Send, {w down}
    Sleep, 2300
    Send, {w up}
    Sleep, 100

    Send, {a down}
    Sleep, 700
    Send, {a up}
    Sleep, 100

    Send, {s down}
    Sleep, 2300
    Send, {s up}
    Sleep, 100

}

MountainTop(){
    SendMode, Input 
    SetKeyDelay, 0, 50 
    Sleep, 100
    RedCannon()
    Sleep, 6000

    Send, {w down}
    Sleep, 1700
    Send, {w up}

    Send, {a down}
    Sleep, 750
    Send, {a up}

    Send, {s down}
    Sleep, 2300
    Send, {s up}

    Send, {d down}
    Sleep, 1500
    Send, {d up}

    Send, {w down}
    Sleep, 2600
    Send, {w up}
}

Rose(){
    SendMode, Input 
    SetKeyDelay, 50
    RedCannon()

    Sleep, 500

    Send, {d down}
    Send, {space down}
    Sleep, 50
    Send, {space up}
    Send, {space down}
    Sleep, 50
    Send, {space up}
    Sleep, 500
    Send, {d up}

    Sleep, 3000

    Send, {space down}
    Sleep, 50
    Send, {space up}

    ;; search for vicious bee

    Send, {w down}
    Sleep, 700
    Send, {w up}

    Send, {a down}
    Sleep, 2750
    Send, {a up}

    Send, {s down}
    Sleep, 700
    Send, {s up}

    Send, {d down}
    Sleep, 2750
    Send, {d up}

    Send, {s down}
    Sleep, 700
    Send, {s up}

    Send, {a down}
    Sleep, 2750
    Send, {a up}
}

Cactus(){
    SendMode, Input 
    SetKeyDelay, 0, 50 
    RedCannon()

    ;; glide to cactux 0

    Sleep, 1000
    Send, {d down}
    Send, {Space down}
    Sleep, 300
    Send, {space up}
    Send, {Space down}
    Sleep, 100
    Send, {Space up}

    Sleep, 1500
    Send, {d up}

    Send, {s down}
    Sleep, 400
    Send, {space down}
    Sleep, 300
    Send, {space up}
    Send, {s up}

    ;; landed at cactus feild
    Sleep, 2000

    loop 2 {
        Send, {s down}
        Sleep, 1100
        Send, {s up}

        Send, {d down}
        Sleep, 800
        Send, {d up}

        Send, {w down}
        Sleep, 1000
        Send, {w up}

        Send, {d down}
        Sleep, 800
        Send, {d up}
    }

    Send, {s down}
    Sleep, 1100
    Send, {s up}
}