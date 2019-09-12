$regfile = "m8def.dat"
$crystal = 4000000
$baud = 9600
'----------------------
Dim Uart_var As Byte
'----------------------
Do
   If Ischarwaiting() = 1 Then
      Uart_var = Inkey()
      Print "ASCII code " ; Uart_var
      Print "Character  " ; Chr(uart_var)
   End If
Loop Until Uart_var = 27
End
'----------------------
