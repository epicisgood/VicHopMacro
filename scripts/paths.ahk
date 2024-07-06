glider(){
    Sleep 500

    Send "{space down}"
    Sleep 50
    Send "{space up}"
    Sleep 210

    Send "{space down}"
    Sleep 50
    Send "{space up}"

    Sleep 250
}

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

    ;;jumping into it
    Send "{d down}{space down}"
    Sleep 300
    Send "{w down}"
    Send "{space up}"
    Sleep 300
    Send "{w up}"
    Sleep 500
    Send "{d up}"

    Send "{w down}{d down}"
    Sleep 600
    Send "{w up}{d up}"

    ;;second plateform
    Send "{w down} {Space down}"
    Sleep 500
    Send "{Space up} {w up}"
    ;; correction to not bug out
    Send "{w down}"
    Send "{a down}"
    Sleep 300
    Send "{a up}"
    Sleep 1900
    Send "{w up}"
    Send "{d down}"
    Sleep 400
    Send "{d up}"
    Sleep 50
    Send "{w down}{space down}"
    Sleep 1200
    Send "{space up}"
    Sleep 1200
    Send "{space down}"
    Sleep 200
    Send "{space up}"
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
    Sleep 2000
    Send "{d up}"

    ;; jump to feild

    Send "{space down}"
    Send "{d down}"
    Sleep 100
    Send "{space up}"
    Sleep 900
    Send "{d up}"
    Sleep 200
    Send "{s down}"
    Sleep 700
    Send "{s up}"
    ; Search vicious bee at pepper field

    Send "{w down}"
    glider()
    Sleep 650
    Send "{w up}"

    Send "{d down}"
    Sleep 700
    Send "{d up}"

    ;; pollen detection here or smth
    Send "{s down}"
    glider()
    Sleep 650
    Send "{s up}"


    Send "{d down}"
    Sleep 700
    Send "{d up}"

    Send "{w down}"
    glider()
    Sleep 650
    Send "{w up}"

}

MountainTop() {
    SetKeyDelay 0, 50
    Sleep 100
    Send "{e down}"
    Sleep 100
    Send "{e up}"
    Sleep 3500

    Send "{w down}"
    glider()
    Sleep 200
    Send "{w up}"

    Send "{a down}"
    Sleep 750
    Send "{a up}"

    Send "{s down}"
    glider()
    Sleep 750
    Send "{s up}"

    Send "{d down}"
    glider()
    Sleep 50
    Send "{d up}"

    Send "{w down}"
    glider()
    Sleep 750
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
    glider()
    Sleep 1100
    Send "{a up}"

    Send "{s down}"
    Sleep 550
    Send "{s up}"

    Send "{d down}"
    glider()
    Sleep 1100
    Send "{d up}"

    Send "{s down}"
    Sleep 550
    Send "{s up}"

    Send "{a down}"
    glider()
    Sleep 1100
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

    Send "{d down}"
    glider()
    Sleep 1000
    Send "{d up}"

    Send "{s down}"
    Sleep 500
    Send "{s up}"

    Send "{a down}"
    glider()
    Sleep 1000
    Send "{a up}"

    Send "{s down}"
    Sleep 500
    Send "{s up}"

    Send "{d down}"
    glider()
    Sleep 1000
    Send "{d up}"




}