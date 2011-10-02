@echo off
echo "LAL mofifs asm"

REM cd .\vwf
REM vwfi vwflen.txt lentbl.dat aaa 0
REM bmp2fnt Lalvwf8.bmp -w16 -h12 -g
REM pause
cd asm
X816 -l top.asm
copy top.obj ..\sortie\top.ips
pause