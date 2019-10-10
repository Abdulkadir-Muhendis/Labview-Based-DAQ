' ******************************************************************************
' * Title         : GetRC5.bas                                                 *
' * Version       : 1.0                                                        *
' * Last Updated  : 26.07.2011                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * Target MCU    : ATMega128A                                                 *
' * IDE           : BASCOM AVR 2.0.7.0                                         *
' * Peripherals   : RC5 Receiver; LCD                                          *
' * Description   : RC5 Code with 4bit LCD Mode                                *
' ******************************************************************************
' Set LCD SWitch on (Backlight)
' Place the AIN0 and AIN1
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
' The trigger can be set to:
' Rising  (Ain0 > Ain1)
' Falling (Ain0 < Ain1)
' Toggle  (Ain0 > Ain1 and Ain0 < Ain1).
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'-----------------------[Definitions]
$regfile = "m128def.dat"
$crystal = 8000000
'-----------------------
'-----------------------[LCD Configurations]
Config Lcdpin = Pin , Db4 = Portc.4 , Db5 = Portc.5 , Db6 = Portc.6 , Db7 = Portc.7 , E = Portg.1 , Rs = Portg.0 , Wr = Portg.2
Config Lcd = 16 * 2
'-----------------------
'-----------------------[AIN Configurations]
Config Aci = On , Compare = Off , Trigger = Rising
On Aci Isr_aci
Enable Aci
Enable Interrupts
'-----------------------
'-----------------------[Variables]
Dim I As Byte
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]
Start Ac : Cls
Do
   nop
Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Read RC5 Code]
Isr_aci:
   Cls
   I = I + 1
   Lcd "change: " ; I : Waitms 100
Return
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'Acis1 = 0 : Acis0 = 0

'Special Function I/O Register SFIOR
'Bit 3 – ACME: Analog Comparator Multiplexer Enable...
   'When this bit is "1" and the ADC is switched off (ADEN in ADCSRA is zero),
   'the ADC multiplexer selects the negative input to the Analog Comparator.

   'When this bit is written logic zero, AIN1 is applied to the negative input
   'of the Analog Comparator.

'Analog Comparator Control and Status Register – ACSR
'Bit 6 – ACBG: Analog Comparator Bandgap Select
   'When this bit is set, a fixed bandgap reference voltage (1.30 V) replaces
   'the positive input to the Analog Comparator.

   'When this bit is cleared, AIN0 is applied to the positive input of the
   'Analog Comparator.
