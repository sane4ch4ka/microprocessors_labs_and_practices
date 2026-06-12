$MOD51
jmp start
org 0bh
clr tcon.4
reti
org 20h
start:
clr c
mov tmod,#01h
setb ie.7
setb ie.1
mov p1,#0h
met1:
mov a,#01h
mov r0,#80
met:
mov TL0,#low(not(50000-1))
mov TH0,#high(not(50000-1))
mov p1,a
setb tcon.4
next:
jnb tcon.5,next
clr tcon.5
djnz r0,met
mov a,#02h
mov r0,#30
met2:
mov TL0,#low(not(50000-1))
mov TH0,#high(not(50000-1))
mov p1,a
setb tcon.4
next2:
jnb tcon.5,next2
clr tcon.5
djnz r0,met2
mov a,#04h
mov r0,#140
met3:
mov TL0,#low(not(50000-1))
mov TH0,#high(not(50000-1))
mov p1,a
setb tcon.4
next3:
jnb tcon.5,next3
clr tcon.5
djnz r0,met3
mov a,#08h
mov r0,#80
met4:
mov TL0,#low(not(50000-1))
mov TH0,#high(not(50000-1))
mov p1,a
setb tcon.4
next4:
jnb tcon.5,next4
clr tcon.5
djnz r0,met4
mov a,#10h
mov r0,#140
met5:
mov TL0,#low(not(50000-1))
mov TH0,#high(not(50000-1))
mov p1,a
setb tcon.4
next5:
jnb tcon.5,next5
clr tcon.5
djnz r0,met5
mov a,#20h
mov r0,#140
met6:
mov TL0,#low(not(50000-1))
mov TH0,#high(not(50000-1))
mov p1,a
setb tcon.4
next6:
jnb tcon.5,next6
clr tcon.5
djnz r0,met6
mov a,#40h
mov r0,#80
met7:
mov TL0,#low(not(50000-1))
mov TH0,#high(not(50000-1))
mov p1,a
setb tcon.4
next7:
jnb tcon.5,next7
clr tcon.5
djnz r0,met7
mov a,#80h
mov r0,#50
met8:
mov TL0,#low(not(50000-1))
mov TH0,#high(not(50000-1))
mov p1,a
setb tcon.4
next8:
jnb tcon.5,next8
clr tcon.5
djnz r0,met8
jmp met1
END

