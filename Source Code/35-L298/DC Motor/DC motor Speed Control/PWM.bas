'==========================================================================
'=      Download from : www.avrprojects.info                              =
'=                                                                        =
'=                                                                        =
'=      W  W  W  .  A  V  R  P  R  O  J  E  C  T  S  .  I  N  F  O        =
'=                                                                        =
'==========================================================================

$regfile = "m16def.dat"
$crystal = 1000000
'============================================================================
Config Timer1 = Pwm , Pwm = 8 , Compare A Pwm = Clear Down , Prescale = 1024
Config Portb = Input
Config Portc = Output
Config Porta = Output
'============================================================================
Dim A As Word , B As Bit
'============================================================================
Declare Sub Progress(num As Word)
'============================================================================
A = 100
Pwm1a = A

Portc.0 = 1
Portc.1 = 0
B = 0
'============================================================================
Do
'////////////////////////////////////////////////////////////////////////////
If Pinb.0 = 1 Then
   A = A + 10
   If A >= 250 Then A = 250
   Pwm1a = A
   Waitms 250
End If
'////////////////////////////////////////////////////////////////////////////
If Pinb.1 = 1 Then
   A = A - 10
   If A <= 10 Then A = 10
   Pwm1a = A
   Waitms 250
End If
'////////////////////////////////////////////////////////////////////////////
If Pinb.2 = 1 Then

   If B = 0 Then
      B = 1
      Portc.0 = 0
      Portc.1 = 1
   Elseif B = 1 Then
      B = 0
      Portc.0 = 1
      Portc.1 = 0
   End If
   Waitms 250

End If
'////////////////////////////////////////////////////////////////////////////
Call Progress(a)
'////////////////////////////////////////////////////////////////////////////
Loop
'============================================================================
End
'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\

Sub Progress(num As Word)

If Num < 25 Then
   Portc.7 = 1
   Portc.6 = 0
   Porta = 0
End If
If Num < 50 And Num >= 25 Then
   Portc.6 = 1
   Portc.7 = 1
   Porta = 0
End If
If Num < 75 And Num >= 50 Then
   Portc.6 = 1
   Portc.7 = 1
   Porta = &B00000001
End If
If Num < 100 And Num >= 75 Then
   Portc.6 = 1
   Portc.7 = 1
   Porta = &B00000011
End If
If Num < 125 And Num >= 100 Then
   Portc.6 = 1
   Portc.7 = 1
   Porta = &B00000111
End If
If Num < 150 And Num >= 125 Then
   Portc.6 = 1
   Portc.7 = 1
   Porta = &B00001111
End If
If Num < 175 And Num >= 150 Then
   Portc.6 = 1
   Portc.7 = 1
   Porta = &B00011111
End If
If Num < 200 And Num >= 175 Then
   Portc.6 = 1
   Portc.7 = 1
   Porta = &B00111111
End If
If Num < 225 And Num >= 200 Then
   Portc.6 = 1
   Portc.7 = 1
   Porta = &B01111111
End If
If Num < 255 And Num >= 225 Then
   Portc.6 = 1
   Portc.7 = 1
   Porta = &B11111111
End If

End Sub