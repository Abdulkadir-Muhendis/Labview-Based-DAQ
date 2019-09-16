' ******************************************************************************
' * Title         : Int.EEPROM.bas                                             *
' * Version       : 1.0                                                        *
' * Last Updated  : 01.08.2011                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * Target MCU    : ATMega128A                                                 *
' * Author        : Walid Balid                                                *
' * IDE           : BASCOM AVR 2.0.7.0                                         *
' * Peripherals   : Pull-Up Resistors                                          *
' * Description   : 4bit LCD Mode                                              *
' ******************************************************************************
' USB
' $eepleave , $eepromhex
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'-----------------------[Definitions]
$regfile = "m128def.dat"
$crystal = 8000000
$baud = 9600
'-----------------------
'-----------------------[Variables]
Dim I As Byte , S As String * 5
Dim Svar As Sram Byte At &H200
Dim Evar As Eram Byte At &H10
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

'--->[Main Program]
Do
   Do : Loop Until Inkey() = 27
   Svar = &HAA : Writeeeprom Svar , &H10
   S = "abcde" : Writeeeprom S , &H11

   Readeeprom Svar , &H10 : Print Hex(svar)
   Readeeprom S , &H11 : Print S

   Do : Loop Until Inkey() = 27
   Svar = 150 : Evar = Svar
   Print "--------"
Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Store Data in EEPROM]
$eeprom
   Data 1 , 2 , 3 , 4 , 5
$data
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~