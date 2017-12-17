call c:\batch\setpath.bat FBWIN

make DEBUG=1
if ERRORLEVEL 1 goto DONE

make DEBUG=1 tests
if ERRORLEVEL 1 goto DONE

:DONE

