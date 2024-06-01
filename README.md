# Zadaca12-8085

Систем базиран на 8085 служи за контрола на
влегување во заштитена просторија. По добивање на знак за
старт, на тастатурата на влезот од просторијата, за време од 5
сек треба да се внесат 2 бајти. Да се нацрта хардверско
поврзување и напише процедура за опслужување на
тајмерот. 

**Resenie:**


![Screenshot (1)](https://github.com/Ristova123/Zadaca12-8085/blob/main/Diagram%2012.png)

```
fosc =5MHz t=0,2µsec ts=0.4µsec
2
14=16384 6.5 msec ;8156 може да брои max 6.5 msec
TH,TL 16000 -> 6.4 msec ;ако TH и TL се наполнат со 16000d, 8156 ќе јавува
интерапт на секои 6.4 msec
6.4*156=1000ms=1 sec ;потребно е 156 пати 8155 да јави интерапт за да
знаеме дека изминала 1 sec.
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
```
Главна Програма:
```
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

```

 ![Screenshot (2)](https://github.com/Ristova123/Zadaca12-8085/blob/main/Code%2012.1.png)
 ![Screenshot (3)](https://github.com/Ristova123/Zadaca12-8085/blob/main/Code%20glavna%2012.png)
 ![Screenshot (4)](https://github.com/Ristova123/Zadaca12-8085/blob/main/Code%2012.png)
 
**Develop by:**

[Tamara Ristova ](https://github.com/Ristova123)


**Subject**

Microcomputer's systems

**Built With**

This project is built using the following tools:

- [8085 simulator](https://github.com/8085simulator/8085simulator.github.io?tab=readme-ov-file): Assembler and emulator for the Intel 8085 microprocessor.

**Getting Started**

To get a local copy up and running, follow these steps.

**Prerequisites**

In order to run this project you need:

A working computer
Connection to internet
Setup

**How to Run**

To run the program, you need an 8085 emulator or assembler. You can use emulators like DOSBox or TASM (Turbo Assembler). Here's how to run the program using 8085 simulator:

1. Download and install 8085 simulator from [here](https://github.com/8085simulator/8085simulator.github.io?tab=readme-ov-file).
2. Clone this repository to your local machine.
3. Open 8085 simulator and load the `Zadaca12 code.asm`,`Zadaca12 glavna.asm` file.
4. Assemble the code by pressing the Assemble button.
5. Run the program by pressing the Run button or by pressing F10.
