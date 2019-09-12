$regfile = "m8def.dat"
$crystal = 4000000
'------------------------
Ucsrb = 0
Dim Value As Byte , A As Byte
Wait 1
'------------------------
Open "comb.0:9600,8,n,1" For Output As #1
Open "comb.1:9600,8,n,1" For Input As #2

Open "comc.0:9600,8,n,1" For Output As #3
Open "comc.1:9600,8,n,1" For Input As #4

Open "comd.6:9600,8,n,1" For Output As #5
Open "comd.7:9600,8,n,1" For Input As #6
'------------------------
Print #1 , "SW UART1, " ; "Enter a value"
   Input #2 , Value
      Print #1 , "value is: " ; Value
Print #3 , "SW UART2, " ; "Enter a value"
   Input #4 , Value
      Print #3 , "value is: " ; Value
Print #5 , "SW UART3, " ; "Enter a value"
   Input #6 , Value
      Print #5 , "value is: " ; Value
'------------------------
Get # 2 , A
Put # 1 , A
'------------------------

Do
   Value = Inkey(#2)
      If Value > 0 Then Print #1 , "SW UART1:" ; Chr(value)

   Value = Inkey(#4)
      If Value > 0 Then Print #3 , "SW UART2:" ; Chr(value)

   Value = Inkey(#6)
      If Value > 0 Then Print #5 , "SW UART3:" ; Chr(value)
Loop Until Inkey(#2) = 1 Or Inkey(#4) = 1 Or Inkey(#6) = 1
'------------------------
Close #6 : Close #5 : Close #4
Close #3 : Close #2 : Close #1
End