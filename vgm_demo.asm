ORG $80 ; where we want our zero-page vars

EXO_buffer_len = 1024	; this must match the parameter -m
EXO_buffer_start = $7000
EXO_table = $7b00 ; 156-byte table
INCLUDE "lib/exomiser.h.asm"

ORG &1900
.start

INCLUDE "lib/exomiser.asm"
INCLUDE "lib/vgmplayer.asm"
INCLUDE "lib/irq.asm"

LOOP = TRUE

.event_handler
{
	php
	cmp #4
	bne not_vsync

	\\ Preserve registers
	pha:txa:pha:tya:pha

	\\ Poll the music player
	jsr vgm_poll_player
	bcs finished
.return
	\\ Restore registers
	pla:tay:pla:tax:pla

	\\ Return
.not_vsync
	plp
	rts
.finished
	; tune finished
IF LOOP
	LDX #<vgm_data
	LDY #>vgm_data
	JSR vgm_init_stream
ELSE	
	jsr stop_eventv
ENDIF
	jmp return
}


.main
{
	LDX #<vgm_data
	LDY #>vgm_data
	JSR vgm_init_stream


	\\ Start our event driven fx
	ldx #LO(event_handler)
	ldy #HI(event_handler)
	JMP start_eventv
}

.vgm_data
INCBIN "music/vgm_out/Chris Kelly - SMS Power 15th Anniversary Competitions - Collision Chaos.bin.exo"
;INCBIN "a.out"
.end

SAVE "Main", start, end, main


PRINT "Vgm Player Size = ", (vgm_player_end-vgm_player_start)
PRINT "Exo Compressor Size = ", (exo_end-exo_start)
