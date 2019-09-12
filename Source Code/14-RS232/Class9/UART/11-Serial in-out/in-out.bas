$regfile = "m8def.dat"
$crystal = 4000000
'$baud = 9600
'------------------------
Ucsrb = 0
Dim S As String * 5
Dim Mybaud As Long
Mybaud = 19200
'------------------------
Do
   Serin S , 0 , D , 0 , Mybaud , 0 , 8 , 1
   Serout S , 0 , D , 1 , Mybaud , 0 , 8 , 1

   Wait 1
Loop
End
'------------------------
