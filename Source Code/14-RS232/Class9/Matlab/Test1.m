ser = serial('COM1','BaudRate',9600,'DataBits',8);
fopen(ser)

fprintf(ser,'This is Test')
A = fscanf(ser);
fprintf(ser,A)

for i=1:5
    fwrite(ser,i);% asci C
end
A = fread(ser);
fwrite(ser,A);

fclose(ser)
delete(ser)
clear ser
