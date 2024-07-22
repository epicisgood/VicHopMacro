


PepperPatch() {
    Send "{" DKey " down}"
    Movespeed(250)
    Send "{" SpaceKey " up}"
    Movespeed(2300)
    Send "{" DKey " up}"
    ;; 35 bee zone still at ground

    Send "{" WKey " down}"
    Movespeed(400)
    Send "{" WKey " up}"
    Movespeed(100)
    Send "{" SKey " down}"
    Movespeed(350)
    Send "{" SKey " up}"
    Movespeed(100)

    ;;jumping into it
    Send "{" DKey " down}{" SpaceKey " down}"
    Movespeed(200)
    Send "{" SpaceKey " up}"
    Send "{" WKey " down}"
    Movespeed(450)
    Send "{" WKey " up}"
    Movespeed(500)
    Send "{" DKey " up}"

    Send "{" WKey " down}{" DKey " down}"
    Movespeed(200)
    Send "{" DKey " up}"
    Movespeed(300)
    Send "{" WKey " up}"

    ;;second platform
    Send "{" WKey " down} {" SpaceKey " down}"
    Movespeed(500)
    Send "{" SpaceKey " up} {" WKey " up}"
    ;; correction to not bug out
    Send "{" WKey " down}"
    Send "{" AKey " down}"
    Movespeed(300)
    Send "{" AKey " up}"
    Movespeed(1900)
    Send "{" WKey " up}"
    Send "{" DKey " down}"
    Movespeed(600)
    Send "{" DKey " up}"

    ;; STUPID JUMP TO FIX BROOO
    Send "{" SpaceKey " down}{" WKey " down}"
    Movespeed(300)
    Send "{" SpaceKey " up}{" WKey " up}"
    Movespeed(500)
    Send "{" SpaceKey " down}{" WKey " down}"
    Movespeed(300)
    Send "{" SpaceKey " up}{" WKey " up}"
    Movespeed(500)

    Send "{" SpaceKey " down}{" WKey " down}"
    Movespeed(300)
    Send "{" SpaceKey " up}{" WKey " up}"
    Movespeed(500)
    Send "{" SpaceKey " down}{" WKey " down}"
    Movespeed(300)
    Send "{" SpaceKey " up}{" WKey " up}"
    Movespeed(500)

    PlayerStatus("Debugging pepper patch lmk if this breaks", 7419530, false)
    Send "{" WKey " down}"
    Movespeed(1600)
    Send "{" SpaceKey " down}"
    Movespeed(200)
    Send "{" SpaceKey " up}"
    Movespeed(300)
    Send "{" WKey " up}"

    ; Move to pepper field from next to coconut
    Send "{" WKey " down}"
    Send "{" DKey " down}"
    Movespeed(2000)
    Send "{" WKey " up}"
    Send "{" DKey " up}"
    Send "{" SpaceKey " down}"
    Send "{" DKey " down}"
    Movespeed(250)
    Send "{" SpaceKey " up}"
    Movespeed(2000)
    Send "{" DKey " up}"

    ;; jump to field

    Send "{" SpaceKey " down}"
    Send "{" DKey " down}"
    Movespeed(100)
    Send "{" SpaceKey " up}"
    Movespeed(900)
    Send "{" DKey " up}"
    Movespeed(200)
    Send "{" SKey " down}"
    Movespeed(700)
    Send "{" SKey " up}"
    ;; Search vicious bee at pepper field

    Send "{" WKey " down}"
    Movespeed(1600)
    Movespeed(650)
    Send "{" WKey " up}"

    Send "{" DKey " down}"
    Movespeed(700)
    Send "{" DKey " up}"

    ;; pollen detection here or smth
    Send "{" SKey " down}"
    Movespeed(1600)
    Movespeed(650)
    Send "{" SKey " up}"

    Send "{" DKey " down}"
    Movespeed(600)
    Send "{" DKey " up}"

    Send "{" WKey " down}"
    Movespeed(1600)
    Movespeed(650)
    Send "{" WKey " up}"
}


MountainTop() {
    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"
    HyperSleep(3500)

    Send "{" WKey " down}"
    Movespeed(1700)
    Send "{" WKey " up}"

    Send "{" AKey " down}"
    Movespeed(750)
    Send "{" AKey " up}"

    Send "{" SKey " down}"
    Movespeed(2300)
    Send "{" SKey " up}"

    Send "{" DKey " down}"
    Movespeed(1500)
    Send "{" DKey " up}"

    Send "{" WKey " down}"
    Movespeed(1500)
    Movespeed(750)
    Send "{" WKey " up}"
}

Rose(){
    SetKeyDelay 50, 50
    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"

    HyperSleep(230)

    Send "{" DKey " down}"
    Send "{" SpaceKey " down}"
    HyperSleep(25)
    Send "{" SpaceKey " up}"
    Send "{" SpaceKey " down}"
    HyperSleep(25)
    Send "{" SpaceKey " up}"
    HyperSleep(500)
    Send "{" DKey " up}"

    HyperSleep(3000)

    Send "{" SpaceKey " down}"
    Movespeed(50)
    Send "{" SpaceKey " up}"

    ;; Search for vicious bee

    Movespeed(500)
    Send "{" AKey " down}"
    Movespeed(1700)
    Movespeed(1100)
    Send "{" AKey " up}"

    Send "{" SKey " down}"
    Movespeed(600)
    Send "{" SKey " up}"

    Send "{" DKey " down}"
    Movespeed(1700)
    Movespeed(1100)
    Send "{" DKey " up}"

    Send "{" SKey " down}"
    Movespeed(600)
    Send "{" SKey " up}"

    Send "{" AKey " down}"
    Movespeed(1700)
    Movespeed(1100)
    Send "{" AKey " up}"
    SetKeyDelay 50
}

Cactus() {   
    SetKeyDelay 50, 50
    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"
    ;; Glide to cactus
    HyperSleep(750)
    Send "{" DKey " down}"
    Send "{" SpaceKey " down}"
    HyperSleep(300)
    Send "{" SpaceKey " up}"
    Send "{" SpaceKey " down}"
    HyperSleep(100)
    Send "{" SpaceKey " up}"
    HyperSleep(1500)
    Send "{" DKey " up}"

    Send "{" SKey " down}"
    HyperSleep(400)
    Send "{" SpaceKey " down}"
    HyperSleep(300)
    Send "{" SpaceKey " up}"
    Send "{" SKey " up}"

    ;; Landed at cactus field
    HyperSleep(2000)

    Send "{" DKey " down}"
    Movespeed(2600)
    Send "{" DKey " up}"

    Send "{" SKey " down}"
    Movespeed(500)
    Send "{" SKey " up}"

    Send "{" AKey " down}"
    Movespeed(2600)
    Send "{" AKey " up}"

    Send "{" SKey " down}"
    Movespeed(500)
    Send "{" SKey " up}"

    Send "{" DKey " down}"
    Movespeed(2600)
    Send "{" DKey " up}"
    SetKeyDelay 50
}




somavoar(){
    HyperSleep(100)
    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"
    Send "{" AKey " down}"
    HyperSleep(1300)
    HyperSleep(500)
    glider()
    HyperSleep(4500)
    Send "{" AKey " up}"
    Send "{" SpaceKey " 1}"
    HyperSleep(2000)


    Send "{" SKey " down}"
    Movespeed(4000)
    Send "{" SKey " up}"

    
    Send "{" SpaceKey " down}{" SKey " down}"
    Movespeed(25)
    Send "{" SpaceKey " up}"
    Movespeed(2000)
    Send "{" AKey " down}"
    Movespeed(1000)
    Send "{" SKey " up}{" AKey " up}"

    Send "{" SpaceKey " down}{" SKey " down}"
    Movespeed(750)
    Send "{" SpaceKey " up}"
    Movespeed(500)
    Send "{" SKey " up}"

    Send "{" AKey " down}"
    Movespeed(500)
    Send "{" AKey " up}"

    Send "{" EKey " down}"
    HyperSleep(50)
    Send "{" EKey " up}"

    HyperSleep(5000)
    Send "{" RotLeft " 1}"  ; <--- , key (turn left)

    Send "{" WKey " down}"
    movespeed(300)
    Send "{" WKey " up}"

    Send "{" Dkey " down}"
    movespeed(300)
    Send "{" Dkey " up}"

    Send "{" SKey " down}"
    movespeed(500)
    Send "{" SKey " up}"

    Send "{" AKey " down}"
    movespeed(300)
    Send "{" AKey " up}"

    Send "{" WKey " down}"
    movespeed(300)
    Send "{" WKey " up}"
}


feast(){
    HyperSleep(100)
    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"
    Send "{" DKey " down}"
    HyperSleep(1175)
    glider()
    HyperSleep(1100)
    Send "{" DKey " up}"
    Send "{" SKey " down}"
    HyperSleep(500)
    Send "{" SKey " up}"
    Send "{" SpaceKey " 1}"
    HyperSleep(1000)
    Send "{" AKey " down}"
    movespeed(1000)
    Send "{" AKey " up}"

    Send "{" WKey " down}"
    movespeed(1500)
    Send "{" WKey " up}"

    Send "{" SKey " down}"
    movespeed(1200)
    Send "{" SKey " up}"

    Send "{" Dkey " down}"
    movespeed(500)
    Send "{" SpaceKey " down}"
    HyperSleep(200)
    Send "{" SpaceKey " up}"
    movespeed(500)
    Send "{" Dkey " up}"

    ;; Claim Feist
    Send "{" EKey " 1}"
    HyperSleep(6000)
    Send "{" RotRight " 3}"
    ;; landed
    Send "{" WKey " down}"
    movespeed(1000)
    Send "{" WKey " up}"

    Send "{" Dkey " down}"
    movespeed(600)
    Send "{" Dkey " up}"


    Send "{" SKey " down}"
    movespeed(400)
    glider()
    movespeed(400)
    Send "{" SKey " up}"
    
    Send "{" AKey " down}"
    movespeed(600)
    Send "{" AKey " up}"


    Send "{" WKey " down}"
    movespeed(400)
    Send "{" WKey " up}"


    Send "{" Dkey " down}"
    movespeed(500)
    Send "{" Dkey " up}"

    Send "{" SKey " down}"
    movespeed(400)
    Send "{" SKey " up}"
}

stockings(){
    HyperSleep(100)
    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"
    Send "{" AKey " down}"
    HyperSleep(600)
    glider()
    HyperSleep(4000)
    Send "{" AKey " up}"
    Send "{" WKey " down}"
    HyperSleep(4000)
    Send "{" WKey " up}"
    Send "{" SKey " down}"
    movespeed(600) ;<-- Need to replace with movespeed when its fixed
    Send "{" SKey " up}"
    ; still needs claim and collect items 

}

