$regfile = "m128def.dat"
$crystal = 4000000
$baud = 9600
$baud1 = 9600
'-------------------------
Config Com1 = Dummy , Synchrone = 0 , Parity = None , Stopbits = 1 , Databits = 8 , Clockpol = 0
Config Com2 = Dummy , Synchrone = 0 , Parity = None , Stopbits = 1 , Databits = 8 , Clockpol = 0

Open "com1:" For Binary As #1
Open "com2:" For Binary As #2

Config Serialin = Buffered , Size = 20 , Bytematch = 27
Config Serialin1 = Buffered , Size = 20 , Bytematch = All

Config Serialout = Buffered , Size = 20
Config Serialout1 = Buffered , Size = 20

Enable Interrupts
'-------------------------
Dim Msg As String * 10 
'------------------------
Do
   If Ischarwaiting() = 1 Then
      Input Msg : Print Msg
   End If

   If Ischarwaiting(#2) = 1 Then
      Input #2 , Msg : Print #2 , Msg
   End If
Loop
End
'------------------------
Serial0charmatch:
   Print "Esc Char!"
Return
'------------------------
Serial1bytereceived:
   Print #2 , " "
   Print #2 , "We got a Char!"
Return
'------------------------
Close #1
Close #2