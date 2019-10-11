' ******************************************************************************
' * Title         : MCP4921.bas                                                *
' * Version       : 1.0                                                        *
' * Last Updated  : 07.08.2011                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * Target MCU    : ATMega128A                                                 *
' * IDE           : BASCOM AVR 2.0.7.0                                         *
' * Peripherals   : Pull-Up Resistors                                          *
' * Description   : 4bit LCD Mode                                              *
' ******************************************************************************
' Set LCD SWitch on (Backlight)
' Set Switch DA.SCK, DA.CS, DA.DI - Place the Vref Jumber
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
Config Spi = Hard , Interrupt = Off , Data Order = Msb , Master = Yes , Polarity = Low , Phase = 0 , Clockrate = 128 , Noss = None , Spiin = 0
Config Portb.6 = Output : Mcp4921_cs Alias Portb.6 : Reset Mcp4921_cs
Spiinit
'-----------------------
'-----------------------[Single Variable Configuration]
Config Single = Scientific , Digits = 3
'-----------------------
'-----------------------[Variables]
Dim A(2) As Byte , Dac_val As Word , Dac_volt As Single
'-----------------------[Constants]
Const V_ref = 5
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]
Cursor Off Noblink : Dac_val = 0
Do
   Gosub Write_adc : Gosub Calc_v_out : Waitms 50
   Incr Dac_val : If Dac_val > 4095 Then Dac_val = 0
Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[ ]
Write_adc:
'0   BUF   GA   SHDN  D11 D10 D9 D8 | D7 D6 D5 D4 D3 D2 D1 D0
'15   14   13    12    11           |  7                    0
' 0    0    1     1   [               0 ~ 4095              ]
   A(1) = High(dac_val) : A(1).7 = 0 : A(1).6 = 0 : A(1).5 = 1 : A(1).4 = 1
   A(2) = Low(dac_val)
   Reset Mcp4921_cs : Waitus 20 : Spiout A(1) , 2 : Waitus 20 : Set Mcp4921_cs
Return
'-----------------------
'--->[ ]
Calc_v_out:
   Dac_volt = Dac_val * V_ref : Dac_volt = Dac_volt / 4096
   If Dac_val = 0 Then
      Cls
      Locate 1 , 1 : Lcd "DAC VAL: "
      Locate 2 , 1 : Lcd "OUT VAL: " : Locate 2 , 16 : Lcd "V"
   End If
   Locate 1 , 10 : Lcd Dac_val
   Locate 2 , 10 : Lcd Dac_volt
Return
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
