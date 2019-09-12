$regfile = "m8def.dat"
$crystal = 4000000
$baud = 19200
'----------------------
Config Serialin = Buffered , Size = 10
Config Serialout = Buffered , Size = 10
Enable Interrupts
'----------------------
Dim Arr(10) As Byte
'----------------------
Baud = 9600
Do
   If Ischarwaiting() = 1 Then
      Inputbin Arr(1) , 10
      Printbin Arr(1) ; 10
      Waitms 10
      Clear Serialin : Clear Serialout
   End If
Loop
End
'----------------------