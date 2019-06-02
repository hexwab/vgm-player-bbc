ORG $80 ; where we want our zero-page vars

EXO_buffer_len = 1024	; this must match the parameter -m
EXO_buffer_start = $b000
EXO_table = $bf00 ; 156-byte table
INCLUDE "lib/exomiser.h.asm"

ORG &1200
.start

.table
{
	EQUW main
	EQUW time
}

INCLUDE "lib/exomiser.asm"
INCLUDE "lib/vgmplayer.asm"

.time
{
	php
	sei
	lda #4
	sta $fe30
	lda #0
	sta $fe68
	sta $fe69
.start_timing
	clc
	jsr vgm_poll_player
.stop_timing
	lda $fe68
	ldx $fe69
	php
	eor #$ff
	sta $70
	cmp #$fd
	bcc no
	inx
.no
	txa
	eor #$ff
	sta $71
	plp
	bcc notfinished
	
.finished
	inc $72
.notfinished
	lda $f4
	sta $fe30
	plp
	rts
}


.main
{
	sei
	lda #4
	sta $fe30
	lda #0
	sta $fe68
	sta $fe69
.start_timing
	LDX #<$8000
	LDY #>$8000
	JSR vgm_init_stream
.stop_timing
	lda $fe68
	ldx $fe69
	php
	eor #$ff
	sta $70
	cmp #$fd
	bcc no
	inx
.no
	txa
	eor #$ff
	sta $71
	plp
	lda $f4
	sta $fe30
	rts
}

PUTFILE "music/vgm_out/Chris Kelly - SMS Power 15th Anniversary Competitions - Collision Chaos.bin.exo","M",$8000
.end

SAVE "speed", start, end, main
PUTBASIC "speedtest.bas", "S"
PUTFILE "speedboot", "!BOOT", 0, 0

PRINT "Vgm Player Size = ", (vgm_player_end-vgm_player_start)
PRINT "Exo Compressor Size = ", (exo_end-exo_start)
