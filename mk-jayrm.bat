call c:\batch\setpath.bat FBWIN
echo mk-jayrm.bat

make
if ERRORLEVEL 1 goto DONE

make tests
if ERRORLEVEL 1 goto DONE

tests\tests.exe

:DONE
