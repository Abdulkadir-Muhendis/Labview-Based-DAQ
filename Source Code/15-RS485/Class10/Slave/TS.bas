$regfile = "m128def.dat"
$crystal = 8000000
$baud = 9600
'-------------------------
Config Porte.2 = Output
Config Print = Porte.2 , Mode = Reset

Open "comd.3:9600,8,n,1" For Output As #1
Open "comd.2:9600,8,n,1" For Input As #2

Config Serialin = Buffered , Size = 250
Enable Interrupts
'-------------------------
Dim Msg As String * 250
'------------------------
Do
   If Ischarwaiting() = 1 Then
      Input Msg
      Print #1 , Msg
   End If
Loop
End
'------------------------