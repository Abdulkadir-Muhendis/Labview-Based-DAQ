' ******************************************************************************
' * Title         : MCP3201.bas                                                *
' * Version       : 1.0                                                        *
' * Last Updated  : 07.08.2011                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * Target MCU    : ATMega128A                                                 *
' * Author        : Walid Balid                                                *
' * IDE           : BASCOM AVR 2.0.7.0                                         *
' * Peripherals   : Pull-Up Resistors                                          *
' * Description   : 4bit LCD Mode                                              *
' ******************************************************************************
' Set LCD SWitch on (Backlight)
' Set Switch AD.SCK, AD.CS, AD.DO - Place the Vref Jumber
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'-----------------------[Definitions]
$regfile = "m128def.dat"
$crystal = 8000000
'-----------------------
'-----------------------[LCD Configuration]
Config Lcdpin = Pin , Db4 = Portc.4 , Db5 = Portc.5 , Db6 = Portc.6 , Db7 = Portc.7 , E = Portg.1 , Rs = Portg.0 , Wr = Portg.2
Config Lcd = 16 * 2
'-----------------------
'-----------------------[ADC Configuration]
Config Spi = Soft , Din = Pinb.3 , Ss = None , Clock = Portb.1 , Spiin = 0 , Mode = 0 , Speed = 10 , Setup = 10

Config Portb.7 = Output : Mcp3201_cs Alias Portb.7 : Reset Mcp3201_cs
Spiinit
'-----------------------
'-----------------------[Single Variable Configuration]
Config Single = Scientific , Digits = 2
'-----------------------
'-----------------------[Variables]
Dim A(2) As Byte , Adc_val As Word , Adc_volt As Single
'-----------------------[Constants]
Const V_ref = 5
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]
Cursor Off Noblink
Do
   Gosub Read_adc : Gosub Calc_v_in : Wait 1
Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[ ]
Read_adc:
   Reset Mcp3201_cs : Waitus 5 : Spiin A(1) , 2 : Waitus 5 : Set Mcp3201_cs
Return
'-----------------------
'--->[ ]
Calc_v_in:
   Adc_val = A(1) * 256 : Adc_val = Adc_val + A(2)
   Adc_val = Adc_val And &B0001111111111111
   Shift Adc_val , Right , 1
   Adc_volt = Adc_val * V_ref : Adc_volt = Adc_volt / 4096
   Cls
   Locate 1 , 1 : Lcd "ADC VAL: " ; Adc_val
   Locate 2 , 1 : Lcd "IN VOLT: " ; Adc_volt ; " V"
Return
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~