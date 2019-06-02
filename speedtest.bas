MODE129
*L.speed 1200
*SRL.m 8000 4
FOR A%=&2000 TO&7FFF STEP4:!A%=0:NEXT
CALL!&1200
I%=(!&70AND&FFFF)*2
B%=0
R%=1E9
D%=0
REPEAT
CALL!&1202
A%=(!&70AND&FFFF)*2
IFB%<A%:B%=A%
IFR%>A%:R%=A%
C%=C%+A%
D%=D%+1
A%!&2000=A%!&2000+1
UNTIL?&72
IF X%>&5FFF:PRINT"Table overflow":END
IF D%>65535:PRINT"Event overflow":END
IF D%=0:PRINT"No events?":END
@%=&90A
PRINTI%;" init cycles"
PRINTC%;" player cycles"
PRINTD%;" events"
PRINTR%;" min cycles"
PRINT(C%DIVD%);" avg cycles"
PRINTB%;" max cycles"
PRINT"CDF follows (no init): ";
E%=0
GCOL0,1
I%=1279:J%=783
FORA%=0 TO10
MOVE0,(A%*J%)DIV10:DRAWI%,(A%*J%)DIV10
MOVE(A%*I%)DIV10,0:DRAW(A%*I%)DIV10,J%
NEXT
GCOL0,3
FORA%=0 TOB% STEP2
E%=E%+A%!&2000 AND&FFFF
PLOT69,(A%*I%)DIVB%,(E%*J%)DIVD%
NEXT
IF E%<>D% PRINT'"Something went terribly wrong somewhere"
