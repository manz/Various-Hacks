@echo off
echo "LAL mofifs asm"

cd .\vwf
vwfi vwflen.txt lentbl.dat aaa 0
bmp2fnt Lalvwf8.bmp -w16 -h12 -g
pause
cd ..\asm
X816 -l lalvwf.asm
copy lalvwf.obj ..\sortie\lalvwf.ips
pause