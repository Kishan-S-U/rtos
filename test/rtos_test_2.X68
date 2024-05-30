        org     usrcode
        and     #%1111100011111111,sr
t0:     move.l  #syscr,d0
        move.l  #t1,d1
        move.l  #$3000,d2
        trap    #sys

        move.l  #syscr,d0
        move.l  #t2,d1
        move.l  #$4000,d2
        trap    #sys
        
t00:    move.l  #kseg,a0
        move.l  a,d1
        move.l  b,d2
        add.l   d1,d2
        move.l  #syswtmx,d0
        trap    #sys
        move.l  c,d3
        sub     d3,d2
        add.l   d2,a0
        move.b  (a0),d3
        move.b  d3,sevseg
        move.l  #syssgmx,d0
        trap    #sys
        bra     t00

t1:     move.l  a,d0
        add     #1,d0
        move.l  d0,a
       
        move.l  #syswtmx,d0
        trap    #sys
        move.l  c,d0
        add     #1,d0
        move.l  d0,c
        move.l  #syssgmx,d0
        trap    #sys
        bra     t1

t2:     move.l  b,d0
        add     #1,d0
        move.l  d0,b
        
        move.l  #syswtmx,d0
        trap    #sys
        move.l  c,d0
        add     #1,d0
        move.l  d0,c
        move.l  #syssgmx,d0
        trap    #sys
        bra     t2


a       dc.l    0
b       dc.l    0
c       dc.l    0
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
        END     res



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
