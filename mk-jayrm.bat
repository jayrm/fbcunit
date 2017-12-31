call c:\batch\setpath.bat FBWIN
echo mk-jayrm.bat

REM touch inc/fbcunit.bi

make
if ERRORLEVEL 1 goto DONE

REM tests\tests.exe
REM examples\ex01.exe
REM examples\ex02.exe

:DONE
