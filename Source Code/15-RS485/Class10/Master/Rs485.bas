$regfile = "m128def.dat"
$crystal = 8000000
$baud = 9600
'------------------
Config Print0 = Porte.2 , Mode = Set
Config Pine.2 = Output

Config Pine.4 = Input
Key1 Alias Pine.4
Porte.4 = 1
'------------------
Dim Msg As String * 100
'------------------
Do
   Debounce Key1 , 0 , Sendall , Sub
Loop
End
'------------------

Sendall:
   Print "This is RS485 Test Program"
   Print "RS458 Protocol Done Based-on MAX485"
   Print "University of Aleppo - Syria"
   Print "Faculty of Alectrical & Electronic Engineering"
   Print "Control Department"
   Print "Fourth Year Students"
   Print "Computer Aided Design Session"
   Print "Unfutunality This Was The Last & Final Session Lab"
   Print "2nd Semester"
   Print "See You Next Semester Guys ;)"
   Print "Kindest Regards"
   Print "Walid BALID"
   Print ":) :) :) :) :) :) :) :) :) :) :) :)"
   Wait 1
Return
'------------------