' ******************************************************************************
' * Title         : LCD.bas                                                    *
' * Version       : 1.0                                                        *
' * Last Updated  : 18.07.2011                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * Target MCU    : ATMega128A                                                 *
' * Author        : Walid Balid                                                *
' * IDE           : BASCOM AVR 2.0.7.0                                         *
' * Peripherals   : Pull-Up Resistors                                          *
' * Description   : 8 bit LCD Mode                                             *
' ******************************************************************************
' Set LCD SWitch on (Backlight)
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
' HOME UPPER | LOWER | THIRD | FOURTH
' UPPERLINE | LOWERLINE | THIRDLINE | FOURTHLINE
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'-----------------------[Definitions]
$regfile = "m128def.dat"
$crystal = 8000000
$baud = 9600
'-----------------------
'-----------------------[LCD Configurations]
Config Lcdpin = Pin , Port = Portc , E = Portg.1 , Rs = Portg.0
Config Lcd = 16 * 2
Config Portg.2 = Output : Reset Portg.2
'-----------------------
'-----------------------[Variables]
Dim I As Byte
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]
Do
   Cls
   Upperline : Lcd "~~Hello World!~~" : Wait 1
   Lowerline : Lcd "(LCD 8-bit Mode)" : Wait 1

   Gosub Shift2right : Gosub Shift2left

   Locate 1 , 8 : Lcd ":" : Wait 1
   Locate 2 , 1 : Lcd ">" : Wait 1

   Shiftcursor Right : Wait 1 : Shiftcursor Left

   Cursor Off Noblink : Wait 1 : Cursor On Blink

   Display Off : Wait 1 : Display On

   Home Upper : Wait 1 : Cls

   Deflcdchar 0 , 32 , 32 , 10 , 21 , 17 , 10 , 4 , 32
   Deflcdchar 1 , 4 , 10 , 17 , 10 , 10 , 17 , 10 , 4
   Locate 1 , 9 : Lcd Chr(0) : Wait 1
   Locate 2 , 9 : Lcd Chr(1) : Wait 1
Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Shift LCD Char to Right]
Shift2right:
   For I = 1 To 8
      Shiftlcd Right : Waitms 500
   Next I
Return
'-----------------------
'--->[Shift LCD Char to Left]
Shift2left:
   For I = 1 To 8
      Shiftlcd Left : Waitms 500
   Next I
Return
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~