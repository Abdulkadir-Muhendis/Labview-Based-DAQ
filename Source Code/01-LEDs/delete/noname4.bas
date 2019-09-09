' ******************************************************************************
' * Title         : LEDs.bas                                                   *
' * Version       : 1.0                                                        *
' * Last Updated  : 17.07.2011                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * Target MCU    : ATMega128A                                                 *
' * Author        : Walid Balid                                                *
' * IDE           : BASCOM AVR 2.0.7.0                                         *
' * Peripherals   : LEDs                                                       *
' * Description   : GPIOs as Outputs                                           *
' ******************************************************************************
' Place the Jumbers: LED.A, LED.B, LED.C, LED.D, LED.E (Activate LEDs)
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'-----------------------[Definitions]
$regfile = "m128def.dat"
$crystal = 8000000
'-----------------------
'-----------------------[GPIO Configurations]
Config Pina.6 = Output : Led_a Alias Porta.6
Config Pina.3 = Output : Led_b Alias Porta.3
'-----------------------
'-----------------------[Variables]
Dim I As Byte
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]
Do
   Set Led_a : Set Led_b : Waitms 500 : Reset Led_a : Reset Led_a : Waitms 500
Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~