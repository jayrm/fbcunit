# Microsoft Developer Studio Project File - Name="fbcunit" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 5.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) External Target" 0x0106

CFG=fbcunit - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "fbcunit.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "fbcunit.mak" CFG="fbcunit - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "fbcunit - Win32 Release" (based on "Win32 (x86) External Target")
!MESSAGE "fbcunit - Win32 Debug" (based on "Win32 (x86) External Target")
!MESSAGE 

# Begin Project
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""

!IF  "$(CFG)" == "fbcunit - Win32 Release"

# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Cmd_Line "NMAKE /f fbcunit.mak"
# PROP BASE Rebuild_Opt "/a"
# PROP BASE Target_File "fbcunit.exe"
# PROP BASE Bsc_Name "fbcunit.bsc"
# PROP BASE Target_Dir ""
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Cmd_Line "NMAKE /f fbcunit.mak"
# PROP Rebuild_Opt "/a"
# PROP Target_File "fbcunit.exe"
# PROP Bsc_Name "fbcunit.bsc"
# PROP Target_Dir ""

!ELSEIF  "$(CFG)" == "fbcunit - Win32 Debug"

# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Cmd_Line "NMAKE /f fbcunit.mak"
# PROP BASE Rebuild_Opt "/a"
# PROP BASE Target_File "fbcunit.exe"
# PROP BASE Bsc_Name "fbcunit.bsc"
# PROP BASE Target_Dir ""
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Cmd_Line "mk-jayrm.bat"
# PROP Rebuild_Opt ""
# PROP Target_File "lib/libfbcunit.a"
# PROP Bsc_Name ""
# PROP Target_Dir ""

!ENDIF 

# Begin Target

# Name "fbcunit - Win32 Release"
# Name "fbcunit - Win32 Debug"

!IF  "$(CFG)" == "fbcunit - Win32 Release"

!ELSEIF  "$(CFG)" == "fbcunit - Win32 Debug"

!ENDIF 

# Begin Group "build"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\changelog.txt
# End Source File
# Begin Source File

SOURCE=.\makefile
# End Source File
# Begin Source File

SOURCE=".\mk-jayrm.bat"
# End Source File
# Begin Source File

SOURCE=.\mk.bat
# End Source File
# Begin Source File

SOURCE=.\mk.sh
# End Source File
# Begin Source File

SOURCE=.\readme.txt
# End Source File
# Begin Source File

SOURCE=.\todo.txt
# End Source File
# End Group
# Begin Group "src"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\src\fbcunit.bas
# End Source File
# Begin Source File

SOURCE=.\src\fbcunit_qb.bas
# End Source File
# End Group
# Begin Group "inc"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\inc\fbcunit.bi
# End Source File
# End Group
# Begin Group "tests"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\tests\fbcu_global.bas
# End Source File
# Begin Source File

SOURCE=.\tests\fbcu_multiple.bas
# End Source File
# Begin Source File

SOURCE=.\tests\fbcu_sanity.bas
# End Source File
# Begin Source File

SOURCE=.\tests\tests.bas
# End Source File
# End Group
# Begin Group "examples"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\examples\ex01.bas
# End Source File
# Begin Source File

SOURCE=.\examples\ex02.bas
# End Source File
# Begin Source File

SOURCE=.\examples\ex03.bas
# End Source File
# Begin Source File

SOURCE=.\examples\ex04.bas
# End Source File
# Begin Source File

SOURCE=.\examples\ex05.bas
# End Source File
# Begin Source File

SOURCE=.\examples\ex06.bas
# End Source File
# End Group
# End Target
# End Project
