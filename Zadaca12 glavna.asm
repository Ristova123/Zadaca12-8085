MVI А, X0X01111b ; маскирај ги сите прекини.
SIM
MVI H,0 ;бројач на бајти.
 MVI C, 156d ;бројач за 1 секунда
MVI D,5d ;бројач за 5 секунди
MVI E,1 ;флег за јамка
MVI А, X0X01110b ; овозможи го само RST 5.5
SIM
VRTI: MOV A,E ;креираме јамка за старт
 ANI FFh
 JNZ VRTI
MVI А, X0X01001b ; овозможи ги само RST 6.5 и RST 7.5
SIM
 MVI E,1
LOOP: MOV A,E
 ANI FFh
 JNZ LOOP
 MOV A,H ;дали се внесени 2 бајти
 CPI 2d
 JZ OK_E
 //NE SE VNESENI DVA BAJTI ;соодветна акција, пр. вклучи аларм
 JMP KRAJ
 OK_E://OK E ;соодветна акција, пр. отвори врата
 KRAJ: NOP
 END 
