call c:\batch\setpath.bat FBWIN

make DEBUG=1 TARGET=win32
if ERRORLEVEL 1 goto DONE

:DONE

