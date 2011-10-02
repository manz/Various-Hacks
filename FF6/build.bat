cd asm\files

gifwin32 -f ff4warn2.gif -m ff4warn2.map -s ff4warn2.set -c ff4warn2.col
cd ..
x816 intro.asm

copy intro.obj ..\intro.ips
del INTRO.OBJ
pause