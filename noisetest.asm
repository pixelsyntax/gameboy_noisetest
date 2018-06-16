INCLUDE "gbhw.inc"

;Header
SECTION "Vblank",ROM0[$0040]
	nop
	reti

SECTION "Input",ROM0[$0060]
	call 	test
	reti

SECTION "start",ROM0[$0100]
	nop
	jp 		boot

	ROM_HEADER  ROM_MBC1_RAM_BAT, ROM_SIZE_64KBYTE, RAM_SIZE_8KBYTE

boot:
	di

	;set audio to ON
	ld 		a, %10000000
	ld 		[rAUDENA], a
	ld 		a, %01110111
	ld 		[rAUDVOL], a ;max volume for both channels
	ld 		a, %11111111 	
	ld 		[rAUDTERM], a 	;activate terminals
	xor 	a
	ld 		[rAUD4ENV], a
	ld 		a, %00000000
	ld 		[rAUD4LEN], a
	ld 		a, %00100000
	ld 		[rAUD4ENV], a
	ld 		a, %10000001
	ld 		[rAUD4POLY], a
	ld 		a, %10000000
	ld 		[rAUD4GO], a

	ld 		a, IEF_HILO
	ld 		[rIE], a
	ei

loop:
	nop
	jr 		loop

test:
	ld 		a, %00010000 	;set channel 4 envelope to volume 2, no envelope
	ld 		[rAUD4ENV], a 	;
	ret