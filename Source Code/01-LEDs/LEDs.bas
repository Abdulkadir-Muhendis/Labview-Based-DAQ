' ******************************************************************************
' * Title         : LEDs.bas                                                   *
' * Version       : 1.0                                                        *
' * Last Updated  : 17.07.2011                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * Target MCU    : ATMega128A                                                 *
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
Config Porta = Output : Leds_a Alias Porta : Leds_a = 255   'Active Low
Config Portb = Output : Leds_b Alias Portb : Leds_b = 255
Config Portc = Output : Leds_c Alias Portc : Leds_c = 255
Config Portd = Output : Leds_d Alias Portd : Leds_d = 255
Config Porte = Output : Leds_e Alias Porte : Leds_e = 255
'-----------------------
'-----------------------[Variables]
Dim I As Byte
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]
Do
   Gosub Leds_on
   Gosub Leds_off
Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Turn Leds on]
Leds_on:
   For I = 0 To 7
      Reset Leds_a.i : Reset Leds_b.i : Reset Leds_c.i : Reset Leds_d.i : Reset Leds_e.i
      Waitms 100
   Next I
Return
'-----------------------
'--->[Turn Leds off]
Leds_off:
   For I = 7 To 0 Step -1
      Set Leds_a.i : Set Leds_b.i : Set Leds_c.i : Set Leds_d.i : Set Leds_e.i
      Waitms 100
   Next I
Return
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
