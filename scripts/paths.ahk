#Requires AutoHotkey v2

PepperPatch() {
    SetKeyDelay 0, 50
    Sleep 300
    Send "{d down}"
    Sleep 250
    Send "{Space up}"
    Sleep 2300
    Send "{d up}"
    ;; 35 bee zone still at ground

    Send "{w down}"
    Sleep 400
    Send "{w up}"
    Sleep 100
    Send "{s down}"
    Sleep 200
    Send "{s up}"
    Sleep 100

    Send "{d down}"
    Send "{Space down}"
    Sleep 100
    Send "{Space up}"
    Sleep 100
    Send "{w down}"
    Sleep 400
    Send "{w up}"
    Sleep 1400
    Send "{d up}"

    
    Send "{Space down}"
    Send "{w down}"
    Sleep 250
    Send "{Space up}"
    Sleep 300
    Send "{Space down}"
    Sleep 250
    Send "{Space up}"
    Sleep 2750
    Send "{w up}"

    Send "{Space down}"
    Send "{w down}"
    Sleep 250
    Send "{Space up}"
    Send "{Space down}"
    Send "{w down}"
    Sleep 250
    Send "{Space up}"
    Send "{Space down}"
    Send "{Space down}"
    Send "{w down}"
    Sleep 250
    Send "{Space up}"
    Send "{Space down}"
    Send "{w down}"
    Sleep 250
    Send "{Space up}"
    Sleep 2000
    Send "{w up}"
    Send "{Space down}"
    Send "{w down}"
    Sleep 250
    Send "{Space up}"
    Send "{w up}"

    ; Move to pepper field from next to coconut
    Send "{w down}"
    Send "{d down}"
    Sleep 2400
    Send "{w up}"
    Send "{d up}"
    Send "{Space down}"
    Send "{d down}"
    Sleep 250
    Send "{Space up}"
    Sleep 2500
    Sleep 100
    Send "{d up}"
    ; Next to pepper field
    Send "{a down}"
    Sleep 200
    Send "{a up}"

    ; Tries to not glide against wall
    Send "{w down}"
    Sleep 1600
    Send "{w up}"
    Sleep 150

    ; Search vicious bee at pepper field
    Send "{Space down}"
    Send "{d down}"
    Sleep 250
    Send "{Space up}"
    Sleep 2500
    Send "{d up}"

    Send "{s down}"
    Sleep 2300
    Send "{s up}"
    Sleep 100

    Send "{a down}"
    Sleep 700
    Send "{a up}"
    Sleep 100

    Send "{w down}"
    Sleep 2300
    Send "{w up}"
    Sleep 100

    Send "{a down}"
    Sleep 700
    Send "{a up}"
    Sleep 100

    Send "{s down}"
    Sleep 2300
    Send "{s up}"
    Sleep 100
}

MountainTop() {
    SetKeyDelay 0, 50
    Sleep 100
    Send "{e down}"
    Sleep 100
    Send "{e up}"
    Sleep 4000

    Send "{w down}"
    Sleep 1700
    Send "{w up}"

    Send "{a down}"
    Sleep 750
    Send "{a up}"

    Send "{s down}"
    Sleep 2300
    Send "{s up}"

    Send "{d down}"
    Sleep 1500
    Send "{d up}"

    Send "{w down}"
    Sleep 2600
    Send "{w up}"
}

Rose() {
    SetKeyDelay 50, 50
    Send "{e down}"
    Sleep 100
    Send "{e up}"

    Sleep 230

    Send "{d down}"
    Send "{space down}"
    Sleep 25
    Send "{space up}"
    Send "{space down}"
    Sleep 25
    Send "{space up}"
    Sleep 500
    Send "{d up}"

    Sleep 3000

    Send "{space down}"
    Sleep 50
    Send "{space up}"

    ; Search for vicious bee
    Sleep 500
    Send "{a down}"
    Sleep 2750
    Send "{a up}"

    Send "{s down}"
    Sleep 700
    Send "{s up}"

    Send "{d down}"
    Sleep 2750
    Send "{d up}"

    Send "{s down}"
    Sleep 700
    Send "{s up}"

    Send "{a down}"
    Sleep 2750
    Send "{a up}"
}

Cactus() {
    SetKeyDelay 50, 50
    Send "{e down}"
    Sleep 100
    Send "{e up}"
    ; Glide to cactus 
    Sleep 750
    Send "{d down}"
    Send "{Space down}"
    Sleep 300
    Send "{space up}"
    Send "{Space down}"
    Sleep 100
    Send "{Space up}"
    Sleep 1500
    Send "{d up}"

    Send "{s down}"
    Sleep 400
    Send "{space down}"
    Sleep 300
    Send "{space up}"
    Send "{s up}"

    ; Landed at cactus field
    Sleep 2000

    loop 2 {
        Send "{s down}"
        Sleep 1100
        Send "{s up}"

        Send "{d down}"
        Sleep 600
        Send "{d up}"

        Send "{w down}"
        Sleep 1000
        Send "{w up}"

        Send "{d down}"
        Sleep 600
        Send "{d up}"
    }

    Send "{s down}"
    Sleep 1100
    Send "{s up}"
}
