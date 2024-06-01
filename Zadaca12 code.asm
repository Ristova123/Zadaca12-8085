THB EQU 00001 101
TLB EQU 00001 100
CSR EQU 00001 000
 2Ch: CALL SERVIS_55
 RET
 34h: CALL SERVIS_55
 RET
 3Ch: CALL SERVIS_75
 RET
 SERVIS_55: MVI E, 0
 CALL POLNI_TIMER ; се полни и се стартува тајмерот
 SERVIS_65: INR H ;бројач на бајти
 RET
SERVIS_75: DCR C ако С=0 изминала 1 сек
 JNZ КРАЈ
DCR D
 JZ GOTOVO ;Aко C и D се 0 изминалe 5 sec.
 MVI C,156d ;ако не се полни тајмерот да брои отпоново
 CALL POLNI_TIMER
 JMP KRAJ
 GOTOVO: MVI E,0 ;крај на јамката во главната програма
 KRAJ: NOP
 RET
POLNI_TIMER:MVI A,10111110 ;62d+128d(краток импулс)=190
 OUT THB ;се полни горниот бајт
 MVI A,10000000 ;128d
 OUT TLB ;се полни долниот бајт
 MVI A,11XXXXXX ;се стартува тајмерот
 OUT CSR
 RET
