' ******************************************************************************
' * Title         : SendRC5.bas                                                *
' * Version       : 1.0                                                        *
' * Last Updated  : 26.07.2011                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * Target MCU    : ATMega128A                                                 *
' * IDE           : BASCOM AVR 2.0.7.0                                         *
' * Peripherals   : RC5 Receiver; LCD                                          *
' * Description   : RC5 Code with 4bit LCD Mode                                *
' ******************************************************************************
' Place the RC5 LED (Sender)
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'-----------------------[Definitions]
$regfile = "m128def.dat"
$crystal = 8000000
'-----------------------
'-----------------------[Switch]
Config Debounce = 100
Config Pine.4 = Input : Send_rc5 Alias Pine.4 : Porte.4 = 1
'-----------------------
'-----------------------[Variables]
Dim Rc5_address As Byte , Rc5_command As Byte , Rc5_toggle As Byte
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]
Enable Interrupts : Cls
Rc5_address = 27 : Rc5_command = 18 : Rc5_toggle = 0

Do
   Debounce Send_rc5 , 0 , Send_rc5_code , Sub
  
   Waitms 100
Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Read RC5 Code]
Send_rc5_code:
   Rc5send Rc5_toggle , Rc5_address , Rc5_command
Return
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
