' ******************************************************************************
' * Title         : INPUT.bas                                                  *
' * Version       : 1.0                                                        *
' * Last Updated  : 17.07.2011                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * Target MCU    : ATMega128A                                                 *
' * Author        : Walid Balid                                                *
' * IDE           : BASCOM AVR 2.0.7.0                                         *
' * Peripherals   : LEDs                                                       *
' * Description   : GPIOs as Outputs                                           *
' ******************************************************************************
' Set Switches: RXD1, TXD1
' Place Jusmber
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'-----------------------[Definitions]
$regfile = "m128def.dat"
$crystal = 8000000
$baud1 = 9600
'-----------------------
'-----------------------[USART2 Configuration]
Config Com2 = Dummy , Synchrone = 0 , Parity = None , Stopbits = 1 , Databits = 8 , Clockpol = 0
Open "com2:" For Binary As #1
'-----------------------
'-----------------------[Variables]
Dim Num1 As Integer , Num2 As Integer , Sum As Integer
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]
Print #1 , "Start"
Do
   Num1 = 0 : Num2 = 0

   Input #1 , "Enter 1st Number: " , Num1
   Input #1 , "Enter 2nd Number: " , Num2

   Sum = Num1 + Num2
   Print #1 , "Sum: " ; Sum
   Print #1 , "----------"
Loop
Close #1
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~