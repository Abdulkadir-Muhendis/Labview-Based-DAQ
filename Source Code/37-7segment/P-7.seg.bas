

$regfile = "m128def.dat"
$crystal = 8000000

Dim A As Byte
Dim C As Byte
Dim E As Byte

Config Porta = Output

Dataout Alias Porta.5
Clock Alias Porta.7
Rck Alias Porta.6

Reset Porta.0
Set Porta.1
Set Porta.2
Set Porta.3
Set Porta.4
Do
   For A = 0 To 9

         E = Lookup(a , 7seg)
         E = E + 128
         Shiftout Dataout , Clock , E , 0 , 8 , 500


         Set Rck
         Waitms 1
         Reset Rck
         Waitms 1000
   Next A

Loop

End

7seg:
Data &H3F , &H06 , &H5B , &H4F , &H66 , &H6D , &H7C , &H07 , &H7F , &H67