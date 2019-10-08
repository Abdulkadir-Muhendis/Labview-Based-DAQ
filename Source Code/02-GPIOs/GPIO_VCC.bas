' ******************************************************************************
' * Title         : GPIO_VCC.bas                                               *
' * Version       : 1.0                                                        *
' * Last Updated  : 18.07.2011                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * Target MCU    : ATMega128A                                                 *
' * IDE           : BASCOM AVR 2.0.7.0                                         *
' * Peripherals   : Pull-Up Resistors                                          *
' * Description   : GPIOs as Input; Active High                                *
' ******************************************************************************
' Set   the Jumbers: JP1, JP2, JP3, JP4, JP5 to PD     (Pull-down; Active low)
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'-----------------------[Definitions]
$regfile = "m128def.dat"
$crystal = 8000000
$baud = 9600
'-----------------------
'-----------------------[GPIO Configurations]
Config Porta = Input : Gpio_a Alias Pina : Porta = 255      'Deactivate Int. PUR
Config Portb = Input : Gpio_b Alias Pinb : Portb = 255
Config Portc = Input : Gpio_c Alias Pinc : Portc = 255
Config Portd = Input : Gpio_d Alias Pind : Portd = 255
Config Porte = Input : Gpio_e Alias Pine : Porte = 255
'Config PORTF = Input : Gpio_f Alias PORTF : PORTF = 255
'-----------------------
'-----------------------[Variables]
Dim I As Byte , Gpio_val(5) As Byte
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]
Do
   Gosub Read_gpios : Gosub Print_gpios : Waitms 1000
Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Read GPIOs]
Read_gpios:
   Gpio_val(1) = Gpio_a
   Gpio_val(2) = Gpio_b
   Gpio_val(3) = Gpio_c
   Gpio_val(4) = Gpio_d
   Gpio_val(5) = Gpio_e
Return
'-----------------------
'--->[Send GPIOs Value to Serial]
Print_gpios:
   For I = 1 To 5
      Print Gpio_val(i)
   Next I
   Print "---------"
Return
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
