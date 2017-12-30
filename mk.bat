@echo off
echo Building fbcunit library
make
if ERRORLEVEL 1 goto DONE
echo Building fbcunit tests
make tests
:DONE
