PepperPatch() {
    movement := 
    (
        '
        nm_Walk(25, DKey)
        Send "{" DKey " down}{" SpaceKey " down}"
        Walk(2)
        Send "{" SpaceKey " up}"
        nm_Walk(4, WKey)
        Walk(5)
        Send "{" DKey " up}"
    
        nm_Walk(2, WKey, DKey)
        Walk(3)
        Send "{" WKey " up}"
    
        Send "{" WKey " down}{" SpaceKey " down}"
        Walk(2)
        Send "{" SpaceKey " up}"
    
        ;; Correction to not bug out
        Send "{" AKey " down}"
        Walk(3)
        Send "{" AKey " up}"
        Walk(19)
        Send "{" WKey " up}"
        nm_Walk(6, DKey)
    
        ;; Jump part
        nm_Walk(2, WKey, SpaceKey)
        Hypersleep(600)
        nm_Walk(2, WKey, SpaceKey)
        Hypersleep(600)
    
        nm_Walk(2, WKey, SpaceKey)
        Hypersleep(600)
        nm_Walk(2, WKey, SpaceKey)
        Hypersleep(600)
    
        Send "{" WKey " down}"
        Walk(13)
        ' PressSpace() '
        Walk(4)
        Send "{" WKey " up}"
    
        ;; Move to pepper field from next to coconut
        nm_Walk(3, DKey)
        ' glider() '
        HyperSleep(500)
        nm_walk(16,Dkey)
        ' PressSpace() '
        nm_Walk(6, WKey)
    
        ' PressSpace() '
        nm_Walk(9, DKey)
    
        ;; At field
        nm_Walk(19, WKey)
        nm_Walk(5, DKey)
        nm_Walk(19, SKey)
        nm_Walk(5, DKey)
        nm_Walk(19, WKey)
        
        
        
        
        '
    )

    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
}

PepperToCannon() {
    movement :=
    (
    '
    Send "{" RotLeft " 4}"
    nm_Walk(3, WKey)
    ' glider() '
    nm_Walk(20, WKey)
    nm_Walk(10, AKey)
    nm_Walk(20, Dkey)
    nm_Walk(3, SKey)

    nm_Walk(3, Dkey)
    ' glider() '

    Send "{" Dkey " down}{" WKey " down}"
    HyperSleep(2700)
    Send "{" WKey " up}"
    HyperSleep(700)
    Send "{" Dkey " up}"

    ' PressSpace() '
    Send "{" RotRight " 4}"

            
        
        '
    )

    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()

}

; we should probably check if the player died during searching
MountainTop() {
    movement :=
    (
    '
    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"
    HyperSleep(3500)

    nm_Walk(15, WKey)
    nm_Walk(5, AKey)
    nm_Walk(20, SKey)
    nm_Walk(11, DKey)
    nm_Walk(18, WKey)
            
        
        '
    )

    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T20 L"
    nm_endWalk()
}

MountainToCactus() {
    movement :=
    (
    '
    nm_Walk(15, WKey)
    nm_Walk(15, Dkey)
    nm_walk(1, Akey)
    nm_walk(2,SKey)
    nm_Walk(5.5, WKey)
    ' glider() '

    Send "{" WKey " down}"
    HyperSleep(300)
    Send "{" WKey " up}"
    Send "{" DKey " down}"
    HyperSleep(2200)
    Send "{" DKey " up}"

    Send "{" SKey " down}"
    HyperSleep(300)
    Send "{" SKey " up}"

    ' PressSpace() '

    nm_Walk(10,AKey)
    nm_Walk(7,SKey)
    nm_Walk(3,WKey)
    nm_Walk(5,Dkey)

    nm_Walk(24, DKey)
    nm_Walk(4, SKey)
    nm_Walk(24, AKey)
    nm_Walk(4, SKey)
    nm_Walk(24, DKey)
            
        '
    )

    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
}

CactusToRose() {
    movement :=
    (
    '
	nm_Walk(7, WKey)
	nm_Walk(8, Dkey)
	nm_Walk(10, WKey)
	nm_Walk(13, AKey)

	nm_Walk(16,Dkey)
    Send "{" WKey " down}"
	HyperSleep(1000)
    ' glider() '
    HyperSleep(4000)
    Send "{" WKey " up}"

    nm_Walk(16, Dkey)
    nm_Walk(5, SKey)

    ; rose pathing
    nm_Walk(25, AKey)
    nm_Walk(4, SKey)
    nm_Walk(24, DKey)
    nm_Walk(5, SKey)
    nm_Walk(24, AKey)
            
        '
    )

    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
}
Rose() {
    movement :=
    (
    '
    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"

    HyperSleep(230+210)
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
    HyperSleep(50)
    Send "{" SpaceKey " up}"

    ;; Search for vicious bee

    HyperSleep(500)
    nm_Walk(26, AKey)
    nm_Walk(5, SKey)
    nm_Walk(26, DKey)
    nm_Walk(5, SKey)
    nm_Walk(26, AKey)
            
        '
    )

    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
}

Cactus() {
    movement :=
    (
    '
    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"
    ;; Glide to cactus
    HyperSleep(1000)
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
    HyperSleep(550)
    Send "{" SpaceKey " down}"
    HyperSleep(300)
    Send "{" SpaceKey " up}"
    Send "{" SKey " up}"

    ;; Landed at cactus field
    HyperSleep(2000)
    nm_walk(4,Dkey)
    nm_Walk(24, DKey)
    nm_Walk(4, SKey)
    nm_Walk(24, AKey)
    nm_Walk(4, SKey)
    nm_Walk(24, DKey)
            
        '
    )

    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()

}


Spider(){
    movement :=
    (
    '
    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"
    HyperSleep(750)
    ' PressSpace() '
    HyperSleep(100)
    ' PressSpace() '
    HyperSleep(100)
    ' PressSpace() '
    HyperSleep(2500)
            
        '
    )

    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
}

Clover(){
    movement :=
    (
    '
    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"
    HyperSleep(170)
    ' PressSpace() '
    HyperSleep(100)
    ' PressSpace() '
    Send "{" AKey " down}"
    HyperSleep(1500)
    Send "{" AKey " up}"

    HyperSleep(3000)
            
        '
    )

    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
}


; beesmas paths 

Samovar() {
    movement := 
    (
        '
        HyperSleep(100)
        Send "{" EKey " down}"
        HyperSleep(100)
        Send "{" EKey " up}"
        Send "{" AKey " down}"
        HyperSleep(1600 + 300) ; glide timing
        ' PressSpace() '
        HyperSleep(100)
        ' PressSpace() '
        HyperSleep(4500)
        Send "{" AKey " up}"
        Send "{" SpaceKey " 1}"
        HyperSleep(2000)
        nm_walk(3,Skey)
        ' glider() '
        nm_walk(25,Skey)


        ' PressSpace() '
        Send "{" Skey " down}"
        HyperSleep(700)
        Send "{" Skey " up}"

        nm_walk(5,Akey)
        nm_walk(10,Skey,Dkey)
        Send "{" Skey " down}"
        Send "{" Dkey " down}"
        HyperSleep(300)
        ' PressSpace() '
        HyperSleep(300)
        Send "{" Dkey " up}"
        Send "{" Skey " up}"

        HyperSleep(1000)
        
        ' PressSpace() '
        HyperSleep(200)
        Send "{" AKey " down}"
        Walk(5)
        Send "{" AKey " up}"

        nm_walk(3,Skey)
        Send "{" EKey " down}"
        HyperSleep(50)
        Send "{" EKey " up}"
    
        HyperSleep(5000)
        Send "{" RotLeft " 6}"  ; <--- , key (turn left)
    
        Send "{" WKey " down}"
        Send "{" DKey " down}"
        Walk(3)
        Send "{" WKey " up}"
        Send "{" DKey " up}"
    
        Send "{" DKey " down}"
        Send "{" SKey " down}"
        Walk(3)
        Send "{" DKey " up}"
        Send "{" SKey " up}"
    
        Send "{" SKey " down}"
        Send "{" AKey " down}"
        Walk(3)
        Send "{" SKey " up}"
        Send "{" AKey " up}"
    
        Send "{" AKey " down}"
        Send "{" WKey " down}"
        Walk(3)
        Send "{" AKey " up}"
        Send "{" WKey " up}"
        
        '
    )

    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
}


 
feast() {
    movement :=
    (
        '
        HyperSleep(100)
        Send "{" EKey " down}"
        HyperSleep(100)
        Send "{" EKey " up}"
        Send "{" DKey " down}"
        HyperSleep(1075) ; 1175 to 975
        ' PressSpace() '
        HyperSleep(100)
        ' PressSpace() '
        HyperSleep(650)
        Send "{" DKey " up}"
        Send "{" SKey " down}"
        HyperSleep(750)
        Send "{" SKey " up}"
        Send "{" SpaceKey " 1}"
        HyperSleep(1000)
        Send "{" AKey " down}"
        Walk(10)
        Send "{" AKey " up}"
    
        Send "{" WKey " down}"
        Walk(15)
        Send "{" WKey " up}"
    
        Send "{" Dkey " down}"
        Walk(12)
        Send "{" Dkey " up}"
    
        Send "{" SKey " down}"
        Walk(7)
        Send "{" SKey " up}"
        hypersleep(300)
        Send "{" SpaceKey " down}"
        HyperSleep(200)
        Send "{" SpaceKey " up}"
        hypersleep(300)
        Send "{" SKey " down}"
        Hypersleep(200)
        Send "{" SKey " up}"
        Hypersleep(1000)
        Send "{" SKey " down}"
        walk(5)
        Send "{" SKey " up}"
        Send "{" AKey " down}"
        Walk(3.5)
        Send "{" AKey " up}"

        ;; Claim Feist
        Send "{" EKey " 1}"
        HyperSleep(6000)
        ;; landed
        Send "{" RotLeft " 2}"
        nm_walk(2,Skey)
        nm_walk(2,Akey,Skey)
        nm_walk(3.5,Wkey,Akey)
        nm_walk(3.5,Wkey,Dkey)
        nm_walk(3,Dkey,Skey)
        nm_walk(3,Akey,Skey)
        HyperSleep(1000)

    
    '
)

    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
}

stockings() {
    movement := 
(
    '
    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"

    Send "{" AKey " down}"
    HyperSleep(750+400) ; gliding timing 700 worked fine ig
    ' PressSpace() '
    HyperSleep(100)
    ' PressSpace() '
    HyperSleep(500)
    Send "{" WKey " down}"
    HyperSleep(7500)
    Send "{" AKey " up}{" WKey " up}"

    Send "{" Dkey " down}"
    Walk(26)
    Send "{" Dkey " up}"

    nm_walk(4, Skey)

    nm_walk(5, Wkey)
    nm_walk(4, Akey)
    nm_walk(4, Skey)


    Send "{" Dkey " down}"
    Walk(6)
    Send "{" Dkey " up}"
    HyperSleep(3000)
    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"

    Send "{" WKey " down}"
    Walk(1.5)
    Send "{" WKey " up}"

    Send "{" AKey " down}"
    Walk(3)
    Send "{" AKey " up}"
    Send "{" SpaceKey " down}"
    HyperSleep(100)
    Send "{" SpaceKey " up}"
    HyperSleep(500)

    Send "{" Dkey " down}"
    Walk(7)
    Send "{" Dkey " up}"

    Send "{" SKey " down}"
    Walk(2)
    Send "{" SKey " up}"

    HyperSleep(500)
    Send "{" SpaceKey " down}"
    HyperSleep(100)
    Send "{" SpaceKey " up}"

    HyperSleep(1000)
    '
)
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
}

Candles() {
    movement :=
    (
    '
    Send "{" DKey " down}"
    Walk(25)
    Send "{" DKey " up}"

    Send "{" DKey " down}{" SpaceKey " down}"
    Walk(2)
    Send "{" SpaceKey " up}"
    Send "{" WKey " down}"
    Walk(4)
    Send "{" WKey " up}"
    Walk(5)
    Send "{" DKey " up}"

    Send "{" WKey " down}{" DKey " down}"
    Walk(2)
    Send "{" DKey " up}"
    Walk(3)
    Send "{" WKey " up}"

    Send "{" WKey " down}{" SpaceKey " down}"
    Walk(2)
    Send "{" SpaceKey " up}"
    Walk(3)
    Send "{" WKey " up}"

    Send "{" RotLeft " 4}"

    Send "{" WKey " down}"
    Walk(1)
    ' glider() '
    walk(9)
    Send "{" WKey " up}"

    Send "{" RotLeft " 2}"
    Send "{" WKey " down}"
    Walk(16)
    Send "{" WKey " up}"

    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"

    HyperSleep(5000)

    Send "{" WKey " down}"
    Walk(2)
    Send "{" WKey " up}"

    Send "{" AKey " down}"
    Walk(4)
    Send "{" AKey " up}"
    Send "{" Dkey " down}"
    Walk(8)
    Send "{" Dkey " up}"

    HyperSleep(2000)
    '
)
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
}

LidArt() {
    movement :=
    (
        '
        Send "{" EKey " down}"
        HyperSleep(100)
        Send "{" EKey " up}"
        HyperSleep(3500)
    
        Send "{" RotLeft " 4}"
    
        Send "{" WKey " down}"
        Walk(15)
        Send "{" WKey " up}"
    
        Send "{" AKey " down}"
        Walk(16)
        Send "{" AKey " up}"
    
        Send "{" Dkey " down}"
        Walk(4.5)
        Send "{" Dkey " up}"
    
        Send "{" WKey " down}"
        loop 5 {
            Walk(2)
            ' glider() '
            Walk(2)
        }
        Walk(10)
        Send "{" WKey " up}"
    
        nm_walk(15,Wkey)

        Send "{" SpaceKey " down}"
        HyperSleep(200)
        Send "{" SpaceKey " up}"
        hypersleep(300)
        Send "{" Wkey " down}"
        Hypersleep(300)
        Send "{" Wkey " up}"
        Hypersleep(1000)

        MsgBox("hi")
        Send "{" EKey " down}"
        HyperSleep(100)
        Send "{" EKey " up}"
    
        HyperSleep(4000)
    
        nm_walk(2,Wkey)
        Send "{" SKey " down}"
        Send "{" DKey " down}"
        Walk(1.7)
        Send "{" SKey " up}"
        Send "{" DKey " up}"
    
        Send "{" SKey " down}"
        Send "{" AKey " down}"
        Walk(1.7)
        Send "{" SKey " up}"
        Send "{" AKey " up}"
    
        Send "{" AKey " down}"
        Send "{" WKey " down}"
        Walk(2)
        Send "{" AKey " up}"
        Send "{" WKey " up}"
    
        Send "{" WKey " down}"
        Send "{" DKey " down}"
        Walk(2)
        Send "{" WKey " up}"
        Send "{" DKey " up}"
    
        Send "{" WKey " down}"
        walk(1)
        Send "{" WKey " up}"
    
        Send "{" AKey " down}"
        walk(3)
        Send "{" AKey " up}"
        Send "{" SKey " down}"
        Walk(1)
        Send "{" SKey " up}"
        Send "{" Dkey " down}"
        walk(5)
        Send "{" Dkey " up}"
    
        Send "{" SKey " down}"
        Walk(1)
        Send "{" SKey " up}"
    
        Send "{" AKey " down}"
        walk(5)
        Send "{" AKey " up}"
    
        Send "{" SKey " down}"
        Walk(1)
        Send "{" SKey " up}"
    
        Send "{" Dkey " down}"
        walk(5)
        Send "{" Dkey " up}"

        Send "{" SKey " down}"
        Walk(1)
        Send "{" SKey " up}"
    
        Send "{" Akey " down}"
        walk(5)
        Send "{" Akey " up}"
        '
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()

}
