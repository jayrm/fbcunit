call c:\batch\setpath.bat FBWIN

make
if ERRORLEVEL 1 goto DONE

make tests

:DONE
