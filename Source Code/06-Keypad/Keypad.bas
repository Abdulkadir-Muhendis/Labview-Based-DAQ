' ******************************************************************************
' * Title         : Keypad.bas                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * Target MCU    : ATMega128A                                                 *
' * IDE           : BASCOM AVR 2.0.7.0                                         *
' * Peripherals   : Pull-Up Resistors                                          *
' * Description   : GPIOs as Input; Active High                                *
' ******************************************************************************
' Place the Jumbers:
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'-----------------------[Definitions]
$regfile = "m128def.dat"
$crystal = 8000000
$baud = 9600
'-----------------------
'-----------------------[Keypad Configurations]
Config Kbd = Portd , Delay = 50
'-----------------------
'-----------------------[Variables]
Dim Var As Byte
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]
Print "start"
Do
   Var = Getkbd()
   If Var < 16 Then Gosub Check_number
Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Print the Key Number]
Check_number:
   Select Case Var
      Case 00 : Print "Key Pressed is (1)"
      Case 01 : Print "Key Pressed is (2)"
      Case 02 : Print "Key Pressed is (3)"
      Case 03 : Print "Key Pressed is (A)"
      Case 04 : Print "Key Pressed is (4)"
      Case 05 : Print "Key Pressed is (5)"
      Case 06 : Print "Key Pressed is (6)"
      Case 07 : Print "Key Pressed is (B)"
      Case 08 : Print "Key Pressed is (7)"
      Case 09 : Print "Key Pressed is (8)"
      Case 10 : Print "Key Pressed is (9)"
      Case 11 : Print "Key Pressed is (C)"
      Case 12 : Print "Key Pressed is (*)"
      Case 13 : Print "Key Pressed is (0)"
      Case 14 : Print "Key Pressed is (#)"
      Case 15 : Print "Key Pressed is (D)"
   End Select
Return
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
