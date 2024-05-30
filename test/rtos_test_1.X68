        org     usrcode
        and     #%1111100011111111,sr
;first application program [create task test]

led     equ     $e00010         ;led
sw      equ     $e00014         ;switch
sevseg  equ     $e0000e         ;seven segment display

t0:                             ;TASK 0
        move.l  #syscr,d0       ;start task 1
        move.l  #t1,d1
        move.l  #$4000,d2
        trap    #sys        
                                ;repeat
t00:    move.l  #$01,d1         ;  set led 0
        move.b  d1,led
        
        bra     t00
        
t1:                             ;TASK 1  
                                ;repeat
        move.l  #$02,d0         ;  set led 1
        move.b  d0,led
       
        bra     t1
kseg                        ;7-seg display patterns
        dc.b    $3f ;0
        dc.b    $06 ;1
        dc.b    $5b ;2
        dc.b    $4f ;3
        dc.b    $66 ;4
        dc.b    $6d ;5
        dc.b    $7d ;6
        dc.b    $07 ;7
        dc.b    $7f ;8
        dc.b    $67 ;9
        dc.b    $77 ;A
        dc.b    $7c ;b
        dc.b    $39 ;C
        dc.b    $5e ;d
        dc.b    $79 ;E
        dc.b    $71 ;F
        dc.b    $80 ;.

        END    res  


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
