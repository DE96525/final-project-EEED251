#include<p18F4550.inc> 

lp_cnt1    set 0x00
lp_cnt2    set 0x01

        org 0x00 
        goto start 
        org 0x08 
        retfie 
        org 0x18 
        retfie 
;=================================================;
dup_nop    macro kk
        variable i

i=0
        while i < kk
        nop

i+=1
        endw
        endm

D10ms   movlw    d'20'
        movwf    lp_cnt2,A
again1  movlw    d'250'
        movwf     lp_cnt1,A
again2  dup_nop    d'17'
        decfsz    lp_cnt1,F,A
        bra     again2
        decfsz     lp_cnt2,F,A
        bra        again1
        return

delays	movlw	d'30'
		movwf	lp_cnt2,A
again3	movlw	d'250'
		movwf 	lp_cnt1,A
again4	dup_nop	d'247'
		decfsz	lp_cnt1,F,A
		bra 	again4
		decfsz 	lp_cnt2,F,A
		bra		again3
		return

;=======================================================;


settinglcd		bcf		PORTC,4,A
				bcf		PORTC,5,A
				bsf		PORTC,6,A
				call	D10ms
				bcf		PORTC,6,A
				return
				
senddata		bsf		PORTC,4,A
				bcf		PORTC,5,A
				bsf		PORTC,6,A
				call	D10ms
				bcf		PORTC,6,A
				return

clear			movlw	0x01				;buat subrotine;
				movwf	PORTD,A
				call	settinglcd
				RETURN
;=====================================================;

displayNAME	movlw 	D'73'
			movwf	PORTD,A
			call	senddata
			
			movlw 	D'75'
			movwf	PORTD,A
			call	senddata
			
			movlw 	D'77'
			movwf	PORTD,A
			call	senddata
			
			movlw 	D'65'
			movwf	PORTD,A
			call	senddata
			
			movlw 	D'76'
			movwf	PORTD,A
			call	senddata
			return

displayID	movlw	D'66'
			movwf	PORTD,A
			call	senddata
			movlw	D'65'
			movwf	PORTD,A
			call	senddata
			movlw	D'78'
			movwf	PORTD,A
			call	senddata
			movlw	D'71'
			movwf	PORTD,A
			call	senddata
			movlw	D'73'
			movwf	PORTD,A
			call	senddata
			return

displayBIRTH	movlw	D'50'
				movwf	PORTD,A
				call	senddata
				movlw	D'51'
				movwf	PORTD,A
				call	senddata
				movlw	D'47'
				movwf	PORTD,A
				call	senddata
				movlw	D'49'
				movwf	PORTD,A
				call	senddata
				movlw	D'49'
				movwf	PORTD,A
				call	senddata
				movlw	D'47'
				movwf	PORTD,A
				call	senddata
				movlw	D'50'
				movwf	PORTD,A
				call	senddata
				movlw	D'48'
				movwf	PORTD,A
				call	senddata
				movlw	D'48'
				movwf	PORTD,A
				call	senddata
				movlw	D'49'
				movwf	PORTD,A
				call	senddata
				return

;===========================================;

;==========================================;
;		program start
;===========================================;

start	movlw    B'00001110'
        movwf    TRISB,A
		movlw	B'0000011'
		movwf	TRISC,A
		clrf	TRISD,A
		bsf		TRISB, 0, A
		
		

		movlw	0x38
		movwf	PORTD,A
		call	settinglcd						
		movlw	0x0F
		movwf	PORTD,A
		call	settinglcd
		movlw	0x01
		movwf	PORTD,A
		call	settinglcd

;================================================;		
		
;===============================================;

PB1		btfss	PORTC,0,A
		bra		PB2
		call	displayNAME
		call	delays
		call	clear
		bra		PB2	
		

PB2		btfss	PORTC,1,A
		bra		PB3
		call	displayID
		call	delays
		call	clear
		bra		PB3

PB3		btfss	PORTB,0,A
		bra		PB1
		call	displayBIRTH
		call	delays
		call	clear
		bra		PB1

		return
		end